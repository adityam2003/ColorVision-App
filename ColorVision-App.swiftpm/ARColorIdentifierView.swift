////
////  File.swift
////  ColorVision-App
////
////  Created by Aditya on 06/02/25.
////
//
//import SwiftUI
//import ARKit
//import UIKit
//
//struct ARColorIdentifierView: UIViewControllerRepresentable {
//    func makeUIViewController(context: Context) -> ARViewController {
//        return ARViewController()
//    }
//
//    func updateUIViewController(_ uiViewController: ARViewController, context: Context) {}
//}
//
//class ARViewController: UIViewController, ARSessionDelegate {
//    let arView = ARSCNView()
//    let colorLabel = UILabel()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        arView.frame = view.bounds
//        arView.session.delegate = self
//        view.addSubview(arView)
//
//        colorLabel.frame = CGRect(x: 20, y: 50, width: 300, height: 50)
//        colorLabel.backgroundColor = .black
//        colorLabel.textColor = .white
//        colorLabel.textAlignment = .center
//        view.addSubview(colorLabel)
//
//        let config = ARWorldTrackingConfiguration()
//        arView.session.run(config)
//    }
//
//    func session(_ session: ARSession, didUpdate frame: ARFrame) {
//        let pixelBuffer = frame.capturedImage
//        let color = extractColor(from: pixelBuffer)
//        DispatchQueue.main.async {
//            self.colorLabel.text = color
//        }
//    }
//
//    func extractColor(from buffer: CVPixelBuffer) -> String {
//        return "Red" // Dummy value, implement real color extraction
//    }
//}
//
