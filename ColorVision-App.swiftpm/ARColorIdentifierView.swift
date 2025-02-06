//
//  File.swift
//  ColorVision-App
//
//  Created by Aditya on 06/02/25.
//

//import SwiftUI
//import ARKit
//import Vision
//import SceneKit
//
//struct ARColorIdentifierView: UIViewControllerRepresentable {
//    func makeUIViewController(context: Context) -> ARViewController {
//        return ARViewController()
//    }
//
//    func updateUIViewController(_ uiViewController: ARViewController, context: Context) {}
//}
//
//class ARViewController: UIViewController, @preconcurrency ARSessionDelegate {
//    let arView = ARSCNView()
//    var colorBlindnessType: String = "Normal"
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupARView()
//    }
//
//    private func setupARView() {
//        arView.frame = view.bounds
//        arView.session.delegate = self
//        arView.automaticallyUpdatesLighting = true
//        view.addSubview(arView)
//
//        let config = ARWorldTrackingConfiguration()
//        config.sceneReconstruction = .mesh
//        arView.session.run(config)
//    }
//
//    func session(_ session: ARSession, didUpdate frame: ARFrame) {
//        let pixelBuffer = frame.capturedImage
//        if let color = extractColor(from: pixelBuffer) {
//            let adjustedColor = applyColorBlindnessFilter(to: color)
//            DispatchQueue.main.async {
//                self.displayColorLabel(adjustedColor)
//            }
//        }
//    }
//
//    func extractColor(from buffer: CVPixelBuffer) -> UIColor? {
//        let ciImage = CIImage(cvPixelBuffer: buffer)
//        let context = CIContext()
//        guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else { return nil }
//        let uiImage = UIImage(cgImage: cgImage)
//        return detectColor(from: uiImage)
//    }
//
//    func detectColor(from image: UIImage) -> UIColor {
//        guard let pixelData = image.cgImage?.dataProvider?.data else { return .clear }
//        let data = CFDataGetBytePtr(pixelData)
//        let width = image.cgImage!.width
//        let height = image.cgImage!.height
//        let bytesPerPixel = 4
//        let x = width / 2
//        let y = height / 2
//        let pixelIndex = ((y * width) + x) * bytesPerPixel
//        
//        let red = CGFloat(data?[pixelIndex] ?? 0) / 255.0
//        let green = CGFloat(data?[pixelIndex + 1] ?? 0) / 255.0
//        let blue = CGFloat(data?[pixelIndex + 2] ?? 0) / 255.0
//        
//        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
//    }
//
//    func applyColorBlindnessFilter(to color: UIColor) -> UIColor {
//        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
//        color.getRed(&r, green: &g, blue: &b, alpha: &a)
//        
//        switch colorBlindnessType {
//        case "Protanopia":
//            return UIColor(red: (r * 0.567) + (g * 0.433),
//                           green: (r * 0.558) + (g * 0.442),
//                           blue: (b * 0.758), alpha: a)
//        case "Deuteranopia":
//            return UIColor(red: (r * 0.625) + (g * 0.375),
//                           green: (r * 0.7) + (g * 0.3),
//                           blue: (b * 0.7), alpha: a)
//        case "Tritanopia":
//            return UIColor(red: (r * 0.95),
//                           green: (g * 0.433) + (b * 0.567),
//                           blue: (g * 0.475) + (b * 0.525), alpha: a)
//        default:
//            return color
//        }
//    }
//
//    func displayColorLabel(_ color: UIColor) {
//        let node = SCNNode()
//        let textGeometry = SCNText(string: "Color", extrusionDepth: 0.5)
//        textGeometry.firstMaterial?.diffuse.contents = color
//        node.geometry = textGeometry
//        node.position = SCNVector3(0, 0, -0.5)
//
//        arView.scene.rootNode.addChildNode(node)
//    }
//}


import SwiftUI
import ARKit
import UIKit

struct ARColorIdentifierView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        #if targetEnvironment(simulator)
        return SimulatorPlaceholderViewController() // Use a static image in the simulator
        #else
        return ARViewController() // Use ARKit on real devices
        #endif
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

// MARK: - ARKit View for Real Devices
class ARViewController: UIViewController, ARSessionDelegate {
    let arView = ARSCNView()
    let colorLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupARView()
        setupColorLabel()
    }

    private func setupARView() {
        arView.frame = view.bounds
        arView.session.delegate = self
        view.addSubview(arView)

        let config = ARWorldTrackingConfiguration()
        arView.session.run(config)
    }

    private func setupColorLabel() {
        colorLabel.frame = CGRect(x: 20, y: 50, width: 300, height: 50)
        colorLabel.backgroundColor = .black
        colorLabel.textColor = .white
        colorLabel.textAlignment = .center
        view.addSubview(colorLabel)
    }
}

// MARK: - Placeholder for Simulator
class SimulatorPlaceholderViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = UIImageView(image: UIImage(named: "sample_image")) // Use a test image
        imageView.contentMode = .scaleAspectFit
        imageView.frame = view.bounds
        view.addSubview(imageView)

        let label = UILabel()
        label.frame = CGRect(x: 20, y: 50, width: 300, height: 50)
        label.text = "Simulator Mode (No AR)"
        label.textColor = .white
        label.backgroundColor = .black
        label.textAlignment = .center
        view.addSubview(label)
    }
}
