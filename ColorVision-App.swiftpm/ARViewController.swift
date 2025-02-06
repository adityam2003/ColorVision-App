//import UIKit
//import ARKit
//import CoreImage
//
//class ARViewController: UIViewController, ARSessionDelegate {
//    
//    // MARK: - Properties
//    
//    var sceneView: ARSCNView!
//    var colorLabel: UILabel!
//    
//    // CIContext for image processing
//    let ciContext = CIContext(options: nil)
//    
//    // MARK: - Lifecycle Methods
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .black
//        
//        // Set up ARSCNView
//        sceneView = ARSCNView(frame: view.bounds)
//        sceneView.session.delegate = self  // Receive ARFrame updates
//        sceneView.automaticallyUpdatesLighting = true
//        view.addSubview(sceneView)
//        
//        // Set up overlay label to display color information
//        colorLabel = UILabel(frame: CGRect(x: 20,
//                                           y: view.bounds.height - 80,
//                                           width: view.bounds.width - 40,
//                                           height: 60))
//        colorLabel.backgroundColor = UIColor.black.withAlphaComponent(0.5)
//        colorLabel.textColor = .white
//        colorLabel.font = UIFont.boldSystemFont(ofSize: 24)
//        colorLabel.textAlignment = .center
//        colorLabel.layer.cornerRadius = 8
//        colorLabel.clipsToBounds = true
//        colorLabel.text = "Detecting..."
//        view.addSubview(colorLabel)
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        // Configure and run the AR session
//        let configuration = ARWorldTrackingConfiguration()
//        sceneView.session.run(configuration, options: [])
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        sceneView.session.pause()
//    }
//    
//    // MARK: - ARSessionDelegate Method
//    
//    nonisolated func session(_ session: ARSession, didUpdate frame: ARFrame) {
//        // Process the captured image to extract the average color from the center region.
//        let pixelBuffer = frame.capturedImage
//        let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
//        
//        // Define a small region at the center of the image.
//        let extent = ciImage.extent
//        let regionSize: CGFloat = 20
//        let centerX = extent.midX
//        let centerY = extent.midY
//        let region = CGRect(x: centerX - regionSize/2,
//                            y: centerY - regionSize/2,
//                            width: regionSize,
//                            height: regionSize)
//        
//        if let avgColor = self.averageColor(in: ciImage, region: region) {
//            // Map the detected color to a simulated colorblind-friendly label.
//            let labelText = self.colorBlindFriendlyLabel(for: avgColor)
//            
//            // Update the label on the main thread.
//            DispatchQueue.main.async {
//                self.colorLabel.text = labelText
//            }
//        }
//    }
//    
//    // MARK: - Image Processing Helper
//    
//    /// Returns the average color (as a UIColor) in the given region of a CIImage.
//    func averageColor(in image: CIImage, region: CGRect) -> UIColor? {
//        // Create the CIAreaAverage filter.
//        guard let filter = CIFilter(name: "CIAreaAverage") else { return nil }
//        filter.setValue(image, forKey: kCIInputImageKey)
//        filter.setValue(CIVector(cgRect: region), forKey: kCIInputExtentKey)
//        guard let outputImage = filter.outputImage else { return nil }
//        
//        // Render the 1x1 output image into a bitmap array.
//        var bitmap = [UInt8](repeating: 0, count: 4)
//        let outputExtent = CGRect(x: 0, y: 0, width: 1, height: 1)
//        ciContext.render(outputImage,
//                         toBitmap: &bitmap,
//                         rowBytes: 4,
//                         bounds: outputExtent,
//                         format: .RGBA8,
//                         colorSpace: CGColorSpaceCreateDeviceRGB())
//        
//        // Convert the pixel values to CGFloat values between 0 and 1.
//        let red = CGFloat(bitmap[0]) / 255.0
//        let green = CGFloat(bitmap[1]) / 255.0
//        let blue = CGFloat(bitmap[2]) / 255.0
//        let alpha = CGFloat(bitmap[3]) / 255.0
//        
//        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
//    }
//    
//    // MARK: - Color Mapping
//    
//    /// Maps a UIColor (detected from the camera) to a colorblind-friendly label.
//    func colorBlindFriendlyLabel(for color: UIColor) -> String {
//        var redComponent: CGFloat = 0
//        var greenComponent: CGFloat = 0
//        var blueComponent: CGFloat = 0
//        var alphaComponent: CGFloat = 0
//        color.getRed(&redComponent, green: &greenComponent, blue: &blueComponent, alpha: &alphaComponent)
//        
//        // Basic logic: determine the dominant channel.
//        // In a real app, you’d have more advanced color detection.
//        if redComponent > greenComponent && redComponent > blueComponent {
//            // Simulate a red object as seen by a Protanopia user.
//            return "Brown (Red)"
//        } else if greenComponent > redComponent && greenComponent > blueComponent {
//            // Simulate a green object as seen by a Deuteranopia user.
//            return "Yellow (Green)"
//        } else if blueComponent > redComponent && blueComponent > greenComponent {
//            return "Blue"
//        } else {
//            return "Mixed/Neutral"
//        }
//    }
//}
