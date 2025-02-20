////
////  File.swift
////  ColorVision-App
////
////  Created by Aditya on 06/02/25.
////
//
////
////import SwiftUI
////import ARKit
////import UIKit
////import CoreImage
////
////struct ARColorIdentifierView: UIViewControllerRepresentable {
////    func makeUIViewController(context: Context) -> UIViewController {
////        #if targetEnvironment(simulator)
////        return SimulatorPlaceholderViewController()
////        #else
////        return ARViewController()
////        #endif
////    }
////    
////    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
////}
////
////// MARK: - ARKit View for Real Devices
////class ARViewController: UIViewController, @preconcurrency ARSessionDelegate {
////    let arView = ARSCNView()
////    let colorLabel = UILabel()
////    let contrastLabel = UILabel()
////    let ciContext = CIContext()
////    
////    override func viewDidLoad() {
////        super.viewDidLoad()
////        setupARView()
////        setupColorLabels()
////    }
////    
////    private func setupARView() {
////        arView.frame = view.bounds
////        arView.session.delegate = self
////        view.addSubview(arView)
////        
////        let config = ARWorldTrackingConfiguration()
////        arView.session.run(config)
////    }
////    
////    private func setupColorLabels() {
////        colorLabel.frame = CGRect(x: 20, y: 50, width: 300, height: 50)
////        colorLabel.backgroundColor = .black
////        colorLabel.textColor = .white
////        colorLabel.textAlignment = .center
////        view.addSubview(colorLabel)
////        
////        contrastLabel.frame = CGRect(x: 20, y: 110, width: 300, height: 50)
////        contrastLabel.backgroundColor = .white
////        contrastLabel.textColor = .black
////        contrastLabel.textAlignment = .center
////        view.addSubview(contrastLabel)
////    }
////    
////    func session(_ session: ARSession, didUpdate frame: ARFrame) {
////        detectColor(from: frame)
////    }
////    
////    private func detectColor(from frame: ARFrame) {
////        let pixelBuffer = frame.capturedImage
////        let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
////        let uiImage = UIImage(ciImage: ciImage)
////        
////        guard let centerColor = getCenterPixelColor(from: uiImage) else { return }
////        
////        DispatchQueue.main.async {
////            self.colorLabel.text = "Detected: \(centerColor.name)"
////            self.colorLabel.backgroundColor = centerColor.uiColor
////            
////            let contrastTextColor = centerColor.uiColor.isLight() ? UIColor.black : UIColor.white
////            self.contrastLabel.text = "Contrast: \(centerColor.name)"
////            self.contrastLabel.backgroundColor = contrastTextColor
////            self.contrastLabel.textColor = centerColor.uiColor
////        }
////    }
////    
////    private func getCenterPixelColor(from image: UIImage) -> (name: String, uiColor: UIColor)? {
////        guard let cgImage = image.cgImage else { return nil }
////        let width = cgImage.width
////        let height = cgImage.height
////        let x = width / 2
////        let y = height / 2
////        
////        guard let data = cgImage.dataProvider?.data,
////              let ptr = CFDataGetBytePtr(data) else { return nil }
////        
////        let bytesPerPixel = 4
////        let pixelIndex = (y * width + x) * bytesPerPixel
////        let red = CGFloat(ptr[pixelIndex]) / 255.0
////        let green = CGFloat(ptr[pixelIndex + 1]) / 255.0
////        let blue = CGFloat(ptr[pixelIndex + 2]) / 255.0
////        
////        let detectedColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
////        let colorName = closestColorName(for: detectedColor)
////        
////        return (colorName, detectedColor)
////    }
////    
////    private func closestColorName(for color: UIColor) -> String {
////        let colors: [(name: String, uiColor: UIColor)] = [
////            ("Red", .red), ("Green", .green), ("Blue", .blue), ("Yellow", .yellow),
////            ("Cyan", .cyan), ("Magenta", .magenta), ("Black", .black), ("White", .white),
////            ("Gray", .gray), ("Orange", .orange), ("Purple", .purple)
////        ]
////        
////        return colors.min(by: { color.distance(to: $0.uiColor) < color.distance(to: $1.uiColor) })?.name ?? "Unknown"
////    }
////}
////
////// MARK: - Color Distance Calculation
////extension UIColor {
////    func distance(to color: UIColor) -> CGFloat {
////        var r1: CGFloat = 0, g1: CGFloat = 0, b1: CGFloat = 0, a1: CGFloat = 0
////        var r2: CGFloat = 0, g2: CGFloat = 0, b2: CGFloat = 0, a2: CGFloat = 0
////        
////        self.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
////        color.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
////        
////        return sqrt(pow(r2 - r1, 2) + pow(g2 - g1, 2) + pow(b2 - b1, 2))
////    }
////    
////    func isLight() -> Bool {
////        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
////        self.getRed(&r, green: &g, blue: &b, alpha: &a)
////        return (r * 299 + g * 587 + b * 114) / 1000 > 0.5
////    }
////}
////
////// MARK: - Placeholder for Simulator
////class SimulatorPlaceholderViewController: UIViewController {
////    override func viewDidLoad() {
////        super.viewDidLoad()
////        
////        let imageView = UIImageView(image: UIImage(named: "sample_image"))
////        imageView.contentMode = .scaleAspectFit
////        imageView.frame = view.bounds
////        view.addSubview(imageView)
////        
////        let label = UILabel()
////        label.frame = CGRect(x: 20, y: 50, width: 300, height: 50)
////        label.text = "Simulator Mode (No AR)"
////        label.textColor = .white
////        label.backgroundColor = .black
////        label.textAlignment = .center
////        view.addSubview(label)
////    }
////}
//
//import SwiftUI
//import ARKit
//import RealityKit
//
//struct ARViewContainer: UIViewRepresentable {
//    func makeUIView(context: Context) -> ARView {
//        let arView = ARView(frame: .zero)
//        guard ARWorldTrackingConfiguration.isSupported else {
//                print("❌ AR not supported on this device")
//                return arView
//            }
//        print("Ar working")
//        let config = ARWorldTrackingConfiguration()
//        arView.session.run(config)
//        arView.addGestureRecognizer(UITapGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handleTap)))
//        return arView
//    }
//    
//    func updateUIView(_ uiView: ARView, context: Context) {}
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//    
//    
//
//    class Coordinator: NSObject {
//        var parent: ARViewContainer
//
//        init(_ parent: ARViewContainer) {
//            self.parent = parent
//        }
//        
//        @MainActor @objc func handleTap(_ sender: UITapGestureRecognizer) {
//            guard let arView = sender.view as? ARView,
//                  let frame = arView.session.currentFrame else { return }
//            detectColor(from: frame, in: arView)
//        }
//        
////        @MainActor func detectColor(from frame: ARFrame, in arView: ARView) {
////            let pixelBuffer = frame.capturedImage
////            let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
////            let uiImage = UIImage(ciImage: ciImage)
////            
////            // Log the pixel format
////            let format = CVPixelBufferGetPixelFormatType(pixelBuffer)
////            print("Pixel format: \(format)")
////            
////            guard let centerColor = getCenterPixelColor(from: uiImage) else {
////                print("❌ No color detected")
////                return
////            }
////            print("✅ Detected color: \(centerColor.name)")
////            addFloatingText(in: arView, text: centerColor.name, color: centerColor.uiColor)
////        }
//        
//        @MainActor func detectColor(from frame: ARFrame, in arView: ARView) {
//            let pixelBuffer = frame.capturedImage
//            let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
//            
//            // Convert CIImage to CGImage
//            let ciContext = CIContext()
//            guard let cgImage = ciContext.createCGImage(ciImage, from: ciImage.extent) else {
//                print("❌ Failed to create CGImage from CIImage")
//                return
//            }
//            
//            let uiImage = UIImage(cgImage: cgImage)
//            
//            guard let centerColor = getCenterPixelColor(from: uiImage) else {
//                print("❌ No color detected")
//                return
//            }
//            
//            print("✅ Detected color: \(centerColor.name)")
//            addFloatingText(in: arView, text: centerColor.name, color: centerColor.uiColor)
//        }
//
//        
//
//        func getCenterPixelColor(from image: UIImage) -> (name: String, uiColor: UIColor)? {
//            guard let cgImage = image.cgImage else {
//                print("❌ Failed to get CGImage from UIImage")
//                return nil
//            }
//            
//            let width = cgImage.width
//            let height = cgImage.height
//            let x = width / 2
//            let y = height / 2
//            
//            // Ensure the image has valid dimensions
//            guard width > 0, height > 0 else {
//                print("❌ Invalid image dimensions")
//                return nil
//            }
//            
//            // Create a bitmap context to extract pixel data
//            let colorSpace = CGColorSpaceCreateDeviceRGB()
//            let bytesPerPixel = 4
//            let bytesPerRow = bytesPerPixel * width
//            let bitsPerComponent = 8
//            
//            var rawData = [UInt8](repeating: 0, count: width * height * bytesPerPixel)
//            guard let context = CGContext(
//                data: &rawData,
//                width: width,
//                height: height,
//                bitsPerComponent: bitsPerComponent,
//                bytesPerRow: bytesPerRow,
//                space: colorSpace,
//                bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
//            ) else {
//                print("❌ Failed to create CGContext")
//                return nil
//            }
//            
//            context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
//            
//            // Calculate the pixel index for the center pixel
//            let pixelIndex = (y * width + x) * bytesPerPixel
//            let red = CGFloat(rawData[pixelIndex]) / 255.0
//            let green = CGFloat(rawData[pixelIndex + 1]) / 255.0
//            let blue = CGFloat(rawData[pixelIndex + 2]) / 255.0
//            let alpha = CGFloat(rawData[pixelIndex + 3]) / 255.0
//            
//            let detectedColor = UIColor(red: red, green: green, blue: blue, alpha: alpha)
//            let colorName = closestColorName(for: detectedColor)
//            
//            return (colorName, detectedColor)
//        }
//        
//        func closestColorName(for color: UIColor) -> String {
//            let colors: [(name: String, uiColor: UIColor)] = [
//                ("Red", .red), ("Green", .green), ("Blue", .blue), ("Yellow", .yellow),
//                ("Cyan", .cyan), ("Magenta", .magenta), ("Black", .black), ("White", .white),
//                ("Gray", .gray), ("Orange", .orange), ("Purple", .purple)
//            ]
//            
//            return colors.min(by: { color.distance(to: $0.uiColor) < color.distance(to: $1.uiColor) })?.name ?? "Unknown"
//        }
//        
////        @MainActor func addFloatingText(in arView: ARView, text: String, color: UIColor) {
////            let mesh = MeshResource.generateText(text, extrusionDepth: 0.01, font: .systemFont(ofSize: 0.1), containerFrame: .zero, alignment: .center, lineBreakMode: .byWordWrapping)
////            let material = SimpleMaterial(color: color, isMetallic: false)
////            let entity = ModelEntity(mesh: mesh, materials: [material])
////            
////            // Create an anchor in front of the camera
////            let anchor = AnchorEntity(world: SIMD3<Float>(0, 0, -0.5)) // Place text 0.5m in front
////            anchor.addChild(entity)
////            
////            // Clear previous anchors and add new one
////            arView.scene.anchors.removeAll()
////            arView.scene.addAnchor(anchor)
////        }
////        @MainActor func addFloatingText(in arView: ARView, text: String, color: UIColor) {
////            // Generate 3D text mesh
////            let mesh = MeshResource.generateText(text,
////                                                 extrusionDepth: 0.02,
////                                                 font: .systemFont(ofSize: 1, weight: .bold),
////                                                 containerFrame: .zero,
////                                                 alignment: .center,
////                                                 lineBreakMode: .byWordWrapping)
////
////            // Convert UIColor to MaterialColorParameter
////            let material = SimpleMaterial(color: color, isMetallic: false)
////
////            let entity = ModelEntity(mesh: mesh, materials: [material])
////            entity.scale = SIMD3<Float>(0.05, 0.05, 0.05) // Adjust scale for visibility
////
////            // Positioning text in front of the camera
////            guard let cameraTransform = arView.session.currentFrame?.camera.transform else {
////                print("❌ Failed to get camera transform")
////                return
////            }
////
////            let forward = cameraTransform.columns.2 // Get camera's forward direction
////            let position = cameraTransform.columns.3 - forward * 0.5 // Place 0.5m in front
////
////            let anchor = AnchorEntity(world: [position.x, position.y, position.z])
////            anchor.addChild(entity)
////
////            // Remove old anchors and add new one
////            arView.scene.anchors.removeAll()
////            arView.scene.addAnchor(anchor)
////
////            print("✅ Floating text added at position \(position)")
////        }
//        @MainActor func addFloatingText(in arView: ARView, text: String, color: UIColor) {
//            // Generate 3D text mesh with a larger font size
//            let mesh = MeshResource.generateText(text,
//                                                 extrusionDepth: 0.02,
//                                                 font: .systemFont(ofSize: 0.3, weight: .bold), // Increased font size
//                                                 containerFrame: .zero,
//                                                 alignment: .center,
//                                                 lineBreakMode: .byWordWrapping)
//
//            // Create a material with the given color
//            let material = SimpleMaterial(color: color, isMetallic: false)
//            let entity = ModelEntity(mesh: mesh, materials: [material])
//
//            // Increase the entity scale for better visibility
//            entity.scale = SIMD3<Float>(0.1, 0.1, 0.1) // Increased scale
//
//            // Get camera position
//            guard let cameraTransform = arView.session.currentFrame?.camera.transform else {
//                print("❌ Failed to get camera transform")
//                return
//            }
//
//            let forward = cameraTransform.columns.2 // Camera's forward direction
//            let position = cameraTransform.columns.3 - forward * 0.5 // Place 0.5m in front
//
//            // Create anchor and add entity
//            let anchor = AnchorEntity(world: [position.x, position.y, position.z])
//            anchor.addChild(entity)
//
//            // Remove old anchors and add the new one
//            arView.scene.anchors.removeAll()
//            arView.scene.addAnchor(anchor)
//
//            print("✅ Floating text added at position \(position)")
//        }
//
//
//
//    }
//}
//
//// MARK: - Color Distance Calculation
//extension UIColor {
//    func distance(to color: UIColor) -> CGFloat {
//        var r1: CGFloat = 0, g1: CGFloat = 0, b1: CGFloat = 0, a1: CGFloat = 0
//        var r2: CGFloat = 0, g2: CGFloat = 0, b2: CGFloat = 0, a2: CGFloat = 0
//        
//        self.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
//        color.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
//        
//        return sqrt(pow(r2 - r1, 2) + pow(g2 - g1, 2) + pow(b2 - b1, 2))
//    }
//}

import SwiftUI
import ARKit
import RealityKit

struct ARViewContainer: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        guard ARWorldTrackingConfiguration.isSupported else {
            print("❌ AR not supported on this device")
            return arView
        }
        
        let config = ARWorldTrackingConfiguration()
        arView.session.run(config)
        
        // Ensure ARView is interactive
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
            print("📍 Tap detected at: \(tapLocation)")

            guard let frame = arView.session.currentFrame else {
                print("❌ No valid AR frame detected")
                return
            }

            detectColor(from: frame, in: arView, at: tapLocation)
        }

        @MainActor func detectColor(from frame: ARFrame, in arView: ARView, at location: CGPoint) {
            let pixelBuffer = frame.capturedImage
            let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
            
            let ciContext = CIContext()
            guard let cgImage = ciContext.createCGImage(ciImage, from: ciImage.extent) else {
                print("❌ Failed to create CGImage")
                return
            }
            
            let uiImage = UIImage(cgImage: cgImage)
            
            guard let detectedColor = getPixelColor(from: uiImage, at: location, in: arView) else {
                print("❌ No color detected")
                return
            }
            
            print("✅ Detected color: \(detectedColor.name)")
            addFloatingText(in: arView, text: detectedColor.name, color: detectedColor.uiColor)
        }

        @MainActor func getPixelColor(from image: UIImage, at location: CGPoint, in arView: ARView) -> (name: String, uiColor: UIColor)? {
            guard let cgImage = image.cgImage else {
                print("❌ Failed to get CGImage")
                return nil
            }
            
            let width = cgImage.width
            let height = cgImage.height
            let x = Int((location.x / arView.bounds.width) * CGFloat(width))
            let y = Int((location.y / arView.bounds.height) * CGFloat(height))

            guard x > 0, y > 0, x < width, y < height else {
                print("❌ Tap outside valid range")
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
                print("❌ Failed to create CGContext")
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
//        func closestColorName(for color: UIColor) -> String {
//            let colors: [(name: String, uiColor: UIColor)] = [
//                ("Red", .red), ("Green", .green), ("Blue", .blue), ("Yellow", .yellow),
//                ("Cyan", .cyan), ("Magenta", .magenta), ("Black", .black), ("White", .white),
//                ("Gray", .gray), ("Orange", .orange), ("Purple", .purple)
//            ]
//            
//            // Find the closest color match
//            guard let closestMatch = colors.min(by: { color.distance(to: $0.uiColor) < color.distance(to: $1.uiColor) })
//            else { return "Unknown" }
//            
//            // Check if the closest match is within a reasonable threshold
//            let matchDistance = color.distance(to: closestMatch.uiColor)
//            let distanceThreshold: CGFloat = 0.35 // Adjust this value based on testing
//            
//            return matchDistance <= distanceThreshold ? closestMatch.name : "Unknown"
//        }


        
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

            // Get the camera's transform
            guard let cameraTransform = arView.session.currentFrame?.camera.transform else {
                print("❌ Failed to get camera transform")
                return
            }

            // Position the text directly in front of the camera (not diagonally)
            let cameraPosition = cameraTransform.columns.3
            let forwardVector = -normalize(cameraTransform.columns.2) // Move it slightly forward
            let position = cameraPosition + forwardVector * 0.5 // Adjust distance from camera

            // Create an anchor at the new position
            let anchor = AnchorEntity(world: [position.x, position.y, position.z])
            anchor.addChild(entity)

            // Make sure the text always faces the user
            entity.orientation = simd_quatf(cameraTransform) // Align to camera's orientation

            arView.scene.anchors.removeAll() // Remove previous labels
            arView.scene.addAnchor(anchor) // Add new label

            print("✅ Floating text added at position \(position)")
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
