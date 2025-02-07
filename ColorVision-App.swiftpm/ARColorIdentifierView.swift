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

//
//import SwiftUI
//import ARKit
//import UIKit
//
//struct ARColorIdentifierView: UIViewControllerRepresentable {
//    func makeUIViewController(context: Context) -> UIViewController {
//        #if targetEnvironment(simulator)
//        return SimulatorPlaceholderViewController() // Use a static image in the simulator
//        #else
//        return ARViewController() // Use ARKit on real devices
//        #endif
//    }
//
//    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
//}
//
//// MARK: - ARKit View for Real Devices
//class ARViewController: UIViewController, ARSessionDelegate {
//    let arView = ARSCNView()
//    let colorLabel = UILabel()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupARView()
//        setupColorLabel()
//    }
//
//    private func setupARView() {
//        arView.frame = view.bounds
//        arView.session.delegate = self
//        view.addSubview(arView)
//
//        let config = ARWorldTrackingConfiguration()
//        arView.session.run(config)
//    }
//
//    private func setupColorLabel() {
//        colorLabel.frame = CGRect(x: 20, y: 50, width: 300, height: 50)
//        colorLabel.backgroundColor = .black
//        colorLabel.textColor = .white
//        colorLabel.textAlignment = .center
//        view.addSubview(colorLabel)
//    }
//}
//
//// MARK: - Placeholder for Simulator
//class SimulatorPlaceholderViewController: UIViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        let imageView = UIImageView(image: UIImage(named: "sample_image")) // Use a test image
//        imageView.contentMode = .scaleAspectFit
//        imageView.frame = view.bounds
//        view.addSubview(imageView)
//
//        let label = UILabel()
//        label.frame = CGRect(x: 20, y: 50, width: 300, height: 50)
//        label.text = "Simulator Mode (No AR)"
//        label.textColor = .white
//        label.backgroundColor = .black
//        label.textAlignment = .center
//        view.addSubview(label)
//    }
//}


import SwiftUI
import ARKit
import UIKit
import CoreImage

struct ARColorIdentifierView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        #if targetEnvironment(simulator)
        return SimulatorPlaceholderViewController()
        #else
        return ARViewController()
        #endif
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

// MARK: - ARKit View for Real Devices
class ARViewController: UIViewController, @preconcurrency ARSessionDelegate {
    let arView = ARSCNView()
    let colorLabel = UILabel()
    let contrastLabel = UILabel()
    let ciContext = CIContext()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupARView()
        setupColorLabels()
    }
    
    private func setupARView() {
        arView.frame = view.bounds
        arView.session.delegate = self
        view.addSubview(arView)
        
        let config = ARWorldTrackingConfiguration()
        arView.session.run(config)
    }
    
    private func setupColorLabels() {
        colorLabel.frame = CGRect(x: 20, y: 50, width: 300, height: 50)
        colorLabel.backgroundColor = .black
        colorLabel.textColor = .white
        colorLabel.textAlignment = .center
        view.addSubview(colorLabel)
        
        contrastLabel.frame = CGRect(x: 20, y: 110, width: 300, height: 50)
        contrastLabel.backgroundColor = .white
        contrastLabel.textColor = .black
        contrastLabel.textAlignment = .center
        view.addSubview(contrastLabel)
    }
    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        detectColor(from: frame)
    }
    
    private func detectColor(from frame: ARFrame) {
        let pixelBuffer = frame.capturedImage
        let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
        let uiImage = UIImage(ciImage: ciImage)
        
        guard let centerColor = getCenterPixelColor(from: uiImage) else { return }
        
        DispatchQueue.main.async {
            self.colorLabel.text = "Detected: \(centerColor.name)"
            self.colorLabel.backgroundColor = centerColor.uiColor
            
            let contrastTextColor = centerColor.uiColor.isLight() ? UIColor.black : UIColor.white
            self.contrastLabel.text = "Contrast: \(centerColor.name)"
            self.contrastLabel.backgroundColor = contrastTextColor
            self.contrastLabel.textColor = centerColor.uiColor
        }
    }
    
    private func getCenterPixelColor(from image: UIImage) -> (name: String, uiColor: UIColor)? {
        guard let cgImage = image.cgImage else { return nil }
        let width = cgImage.width
        let height = cgImage.height
        let x = width / 2
        let y = height / 2
        
        guard let data = cgImage.dataProvider?.data,
              let ptr = CFDataGetBytePtr(data) else { return nil }
        
        let bytesPerPixel = 4
        let pixelIndex = (y * width + x) * bytesPerPixel
        let red = CGFloat(ptr[pixelIndex]) / 255.0
        let green = CGFloat(ptr[pixelIndex + 1]) / 255.0
        let blue = CGFloat(ptr[pixelIndex + 2]) / 255.0
        
        let detectedColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        let colorName = closestColorName(for: detectedColor)
        
        return (colorName, detectedColor)
    }
    
    private func closestColorName(for color: UIColor) -> String {
        let colors: [(name: String, uiColor: UIColor)] = [
            ("Red", .red), ("Green", .green), ("Blue", .blue), ("Yellow", .yellow),
            ("Cyan", .cyan), ("Magenta", .magenta), ("Black", .black), ("White", .white),
            ("Gray", .gray), ("Orange", .orange), ("Purple", .purple)
        ]
        
        return colors.min(by: { color.distance(to: $0.uiColor) < color.distance(to: $1.uiColor) })?.name ?? "Unknown"
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
    
    func isLight() -> Bool {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return (r * 299 + g * 587 + b * 114) / 1000 > 0.5
    }
}

// MARK: - Placeholder for Simulator
class SimulatorPlaceholderViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = UIImageView(image: UIImage(named: "sample_image"))
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
