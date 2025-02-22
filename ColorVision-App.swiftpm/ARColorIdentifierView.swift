//
//  File.swift
//  ColorVision-App
//
//  Created by Aditya on 06/02/25.
//



import SwiftUI
import ARKit
import RealityKit

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        guard ARWorldTrackingConfiguration.isSupported else {
            return arView
        }
        
        let config = ARWorldTrackingConfiguration()
        arView.session.run(config)
        
        arView.isUserInteractionEnabled = true
        arView.addGestureRecognizer(UITapGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handleTap(_:))))
        
        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        var parent: ARViewContainer

        init(_ parent: ARViewContainer) {
            self.parent = parent
        }

        @MainActor @objc func handleTap(_ sender: UITapGestureRecognizer) {
            guard let arView = sender.view as? ARView else { return }
            
            let tapLocation = sender.location(in: arView)

            guard let frame = arView.session.currentFrame else {
                return
            }

            detectColor(from: frame, in: arView, at: tapLocation)
        }

        @MainActor func detectColor(from frame: ARFrame, in arView: ARView, at location: CGPoint) {
            let pixelBuffer = frame.capturedImage
            let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
            
            let ciContext = CIContext()
            guard let cgImage = ciContext.createCGImage(ciImage, from: ciImage.extent) else {
                return
            }
            
            let uiImage = UIImage(cgImage: cgImage)
            
            guard let detectedColor = getPixelColor(from: uiImage, at: location, in: arView) else {
                return
            }
            
            addFloatingText(in: arView, text: detectedColor.name, color: detectedColor.uiColor)
        }

        @MainActor func getPixelColor(from image: UIImage, at location: CGPoint, in arView: ARView) -> (name: String, uiColor: UIColor)? {
            guard let cgImage = image.cgImage else {
                return nil
            }
            
            let width = cgImage.width
            let height = cgImage.height
            let x = Int((location.x / arView.bounds.width) * CGFloat(width))
            let y = Int((location.y / arView.bounds.height) * CGFloat(height))

            guard x > 0, y > 0, x < width, y < height else {
                return nil
            }

            let colorSpace = CGColorSpaceCreateDeviceRGB()
            let bytesPerPixel = 4
            let bytesPerRow = bytesPerPixel * width
            let bitsPerComponent = 8
            
            var rawData = [UInt8](repeating: 0, count: width * height * bytesPerPixel)
            guard let context = CGContext(
                data: &rawData,
                width: width,
                height: height,
                bitsPerComponent: bitsPerComponent,
                bytesPerRow: bytesPerRow,
                space: colorSpace,
                bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
            ) else {
                return nil
            }
            
            context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))

            let pixelIndex = (y * width + x) * bytesPerPixel
            let red = CGFloat(rawData[pixelIndex]) / 255.0
            let green = CGFloat(rawData[pixelIndex + 1]) / 255.0
            let blue = CGFloat(rawData[pixelIndex + 2]) / 255.0
            let alpha = CGFloat(rawData[pixelIndex + 3]) / 255.0

            let detectedColor = UIColor(red: red, green: green, blue: blue, alpha: alpha)
            let colorName = closestColorName(for: detectedColor)

            return (colorName, detectedColor)
        }

        func closestColorName(for color: UIColor) -> String {
            let colors: [(name: String, uiColor: UIColor)] = [
                ("Red", UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)),
                ("Dark Red", UIColor(red: 0.6, green: 0.0, blue: 0.0, alpha: 1.0)),
                ("Light Red", UIColor(red: 1.0, green: 0.4, blue: 0.4, alpha: 1.0)),
                
                ("Green", UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)),
                ("Dark Green", UIColor(red: 0.0, green: 0.5, blue: 0.0, alpha: 1.0)),
                ("Olive", UIColor(red: 0.5, green: 0.5, blue: 0.0, alpha: 1.0)),
                ("Yellow-Green", UIColor(red: 0.7, green: 0.8, blue: 0.2, alpha: 1.0)),
                
                ("Blue", UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)),
                ("Dark Blue", UIColor(red: 0.0, green: 0.0, blue: 0.6, alpha: 1.0)),
                ("Light Blue", UIColor(red: 0.4, green: 0.6, blue: 1.0, alpha: 1.0)),

                ("Yellow", UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)),
                ("Golden Yellow", UIColor(red: 1.0, green: 0.8, blue: 0.2, alpha: 1.0)),

                ("Cyan", UIColor(red: 0.0, green: 1.0, blue: 1.0, alpha: 1.0)),
                ("Teal", UIColor(red: 0.0, green: 0.5, blue: 0.5, alpha: 1.0)),

                ("Magenta", UIColor(red: 1.0, green: 0.0, blue: 1.0, alpha: 1.0)),
                ("Pink", UIColor(red: 1.0, green: 0.4, blue: 0.6, alpha: 1.0)),

                ("Brown", UIColor(red: 0.6, green: 0.3, blue: 0.0, alpha: 1.0)),
                ("Dark Brown", UIColor(red: 0.4, green: 0.2, blue: 0.0, alpha: 1.0)),
                ("Beige", UIColor(red: 0.9, green: 0.8, blue: 0.6, alpha: 1.0)),

                ("Black", .black),
                ("White", .white),
                ("Gray", .gray),
                ("Dark Gray", UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1.0)),
                ("Light Gray", UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1.0))
            ]

            guard let closestMatch = colors.min(by: { color.distance(to: $0.uiColor) < color.distance(to: $1.uiColor) })
            else { return "Unknown" }

            let matchDistance = color.distance(to: closestMatch.uiColor)
            let distanceThreshold: CGFloat = 0.35

            return matchDistance <= distanceThreshold ? closestMatch.name : "Unknown"
        }


        
        @MainActor func addFloatingText(in arView: ARView, text: String, color: UIColor) {
            let mesh = MeshResource.generateText(
                text,
                extrusionDepth: 0.02,
                font: .systemFont(ofSize: 0.3, weight: .bold),
                containerFrame: .zero,
                alignment: .center,
                lineBreakMode: .byWordWrapping
            )

            let material = SimpleMaterial(color: color, isMetallic: false)
            let entity = ModelEntity(mesh: mesh, materials: [material])
            entity.scale = SIMD3<Float>(0.1, 0.1, 0.1)

            guard let cameraTransform = arView.session.currentFrame?.camera.transform else {
                return
            }

           
            let cameraPosition = cameraTransform.columns.3
            let forwardVector = -normalize(cameraTransform.columns.2)
            let position = cameraPosition + forwardVector * 0.5

            let anchor = AnchorEntity(world: [position.x, position.y, position.z])
            anchor.addChild(entity)

            entity.orientation = simd_quatf(cameraTransform)

            arView.scene.anchors.removeAll()
            arView.scene.addAnchor(anchor)

        }

    }
}

// MARK: - Color Distance Calculation
extension UIColor {
    func distance(to color: UIColor) -> CGFloat {
        var r1: CGFloat = 0, g1: CGFloat = 0, b1: CGFloat = 0, a1: CGFloat = 0
        var r2: CGFloat = 0, g2: CGFloat = 0, b2: CGFloat = 0, a2: CGFloat = 0
        
        self.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        color.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        
        return sqrt(pow(r2 - r1, 2) + pow(g2 - g1, 2) + pow(b2 - b1, 2))
    }
}
