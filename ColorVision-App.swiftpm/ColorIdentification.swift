
//  File.swift
//  ColorVision-App
//
//  Created by Aditya on 06/02/25.


import SwiftUI
import PhotosUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct PhotoColorIdentifierView: View {
    @State private var selectedImage: UIImage?
    @State private var tappedColorName: String = "Tap on the image to identify color"
    @State private var showPhotoPicker = false
    @State private var processedImage: CGImage?
  
private let sampleImage = UIImage(named: "SampleImage")

    let x11Colors: [(name: String, r: Int, g: Int, b: Int)] = [
        ("white", 255, 255, 255),
        ("black", 0, 0, 0),
        ("red", 255, 0, 0),
        
        ("AliceBlue", 240, 248, 255),
        ("AntiqueWhite", 250, 235, 215),
        ("AntiqueWhite1", 255, 239, 219),
        ("AntiqueWhite2", 238, 223, 204),
        ("AntiqueWhite3", 205, 192, 176),
        ("AntiqueWhite4", 139, 131, 120),
        ("aquamarine", 127, 255, 212),
        ("aquamarine1", 127, 255, 212),
        ("aquamarine2", 118, 238, 198),
        ("aquamarine3", 102, 205, 170),
        ("aquamarine4", 69, 139, 116),
        ("azure", 240, 255, 255),
        ("azure1", 240, 255, 255),
        ("azure2", 224, 238, 238),
        ("azure3", 193, 205, 205),
        ("azure4", 131, 139, 139),
        ("beige", 245, 245, 220),
        ("bisque", 255, 228, 196),
        ("bisque1", 255, 228, 196),
        ("bisque2", 238, 213, 183),
        ("bisque3", 205, 183, 158),
        ("bisque4", 139, 125, 107),
        ("black", 0, 0, 0),
        ("blue", 0, 0, 255),
        ("brown", 165, 42, 42),
        ("cadet blue", 95, 158, 160),
        ("chartreuse", 127, 255, 0),
        ("chocolate", 210, 105, 30),
        ("coral", 255, 127, 80),
        ("cyan", 0, 255, 255),
        ("dark blue", 0, 0, 139),
        ("dark cyan", 0, 139, 139),
        ("dark goldenrod", 184, 134, 11),
        ("dark green", 0, 100, 0),
        ("dark magenta", 139, 0, 139),
        ("dark orange", 255, 140, 0),
        ("dark orchid", 153, 50, 204),
        ("dark red", 139, 0, 0),
        ("deep pink", 255, 20, 147),
        ("deep sky blue", 0, 191, 255),
        ("dodger blue", 30, 144, 255),
        ("firebrick", 178, 34, 34),
        ("forest green", 34, 139, 34),
        ("gold", 255, 215, 0),
        ("goldenrod", 218, 165, 32),
        ("gray", 128, 128, 128),
        ("green", 0, 255, 0),
        ("hot pink", 255, 105, 180),
        ("indian red", 205, 92, 92),
        ("khaki", 240, 230, 140),
        ("lavender", 230, 230, 250),
        ("light blue", 173, 216, 230),
        ("light green", 144, 238, 144),
        ("light pink", 255, 182, 193),
        ("lime", 0, 255, 0),
        ("magenta", 255, 0, 255),
        ("maroon", 176, 48, 96),
        ("midnight blue", 25, 25, 112),
        ("navy", 0, 0, 128),
        ("olive", 128, 128, 0),
        ("orange", 255, 165, 0),
        ("orchid", 218, 112, 214),
        ("pale green", 152, 251, 152),
        ("pink", 255, 192, 203),
        ("purple", 160, 32, 240),
        ("red", 255, 0, 0),
        ("royal blue", 65, 105, 225),
        ("salmon", 250, 128, 114),
        ("sienna", 160, 82, 45),
        ("silver", 192, 192, 192),
        ("sky blue", 135, 206, 235),
        ("slate gray", 112, 128, 144),
        ("snow", 255, 250, 250),
        ("spring green", 0, 255, 127),
        ("steel blue", 70, 130, 180),
        ("tan", 210, 180, 140),
        ("teal", 0, 128, 128),
        ("thistle", 216, 191, 216),
        ("tomato", 255, 99, 71),
        ("turquoise", 64, 224, 208),
        ("violet", 238, 130, 238),
        ("wheat", 245, 222, 179),
        ("white", 255, 255, 255),
        ("yellow", 255, 255, 0),
        //Gray
        ("gray0", 0, 0, 0),
        ("gray1", 3, 3, 3),
        ("gray2", 5, 5, 5),
        ("gray3", 8, 8, 8),
        ("gray4", 10, 10, 10),
        ("gray5", 13, 13, 13),
        ("gray6", 15, 15, 15),
        ("gray7", 18, 18, 18),
        ("gray8", 20, 20, 20),
        ("gray9", 23, 23, 23),
        ("gray10", 26, 26, 26),
        ("gray11", 28, 28, 28),
        ("gray12", 31, 31, 31),
        ("gray13", 33, 33, 33),
        ("gray14", 36, 36, 36),
   
        ("DarkGrey", 169, 169, 169),

    ]
    
    var body: some View {
            VStack {
                Text("Photo-Based Color Identifier")
                    .font(.title2)
                    .padding()

                if let image = processedImage {
                    Image(decorative: image, scale: 1.0)
                        .resizable()
                        .scaledToFill()
                        .overlay(
                            GeometryReader { geometry in
                                Color.clear
                                    .contentShape(Rectangle())
                                    .onTapGesture { location in
                                        let imageSize = CGSize(width: image.width, height: image.height)
                                        let tapLocation = CGPoint(
                                            x: location.x * (imageSize.width / geometry.size.width),
                                            y: location.y * (imageSize.height / geometry.size.height)
                                        )

                                        if let tappedColor = getAverageColor(from: image, at: tapLocation) {
                                            tappedColorName = closestColor(to: tappedColor)
                                        }
                                    }
                            }
                        )
                        .border(Color.black, width: 2)
                } else {
                    Text("No image selected")
                        .foregroundColor(.gray)
                        .padding()
                }

                Text(tappedColorName)
                    .font(.headline)
                    .padding()
                    .frame(width: 250)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)

                Button("Select Photo") {
                    showPhotoPicker = true
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                
                .cornerRadius(10)

                Spacer()
            }
            .padding()
            .sheet(isPresented: $showPhotoPicker) {
                PhotoPicker(selectedImage: $selectedImage)
            }
            .onAppear {
                if selectedImage == nil {
                    selectedImage = sampleImage
                }
            }
            .onChange(of: selectedImage) { _ in processImage() }
        }

        func processImage() {
            guard let uiImage = selectedImage else {
                processedImage = nil
                return
            }

            let context = CIContext()
            guard let ciImage = CIImage(image: uiImage),
                  let blurred = CIFilter(name: "CIGaussianBlur", parameters: [kCIInputImageKey: ciImage, "inputRadius": 5.0])?.outputImage,
                  let output = context.createCGImage(blurred.clampedToExtent(), from: ciImage.extent, format: .RGBA8, colorSpace: CGColorSpaceCreateDeviceRGB())
            else {
                processedImage = nil
                return
            }

            processedImage = output
        }

        func getAverageColor(from cgImage: CGImage, at point: CGPoint) -> UIColor? {
            let width = cgImage.width
            let height = cgImage.height
            let radius = 1

            guard let data = cgImage.dataProvider?.data,
                  let pixelData = CFDataGetBytePtr(data) else {
                return nil
            }

            var totalRed: CGFloat = 0
            var totalGreen: CGFloat = 0
            var totalBlue: CGFloat = 0
            var count: CGFloat = 0

            for dx in -radius...radius {
                for dy in -radius...radius {
                    let x = Int(point.x) + dx
                    let y = Int(point.y) + dy

                    if x >= 0, x < width, y >= 0, y < height {
                        let pixelIndex = (y * width + x) * 4
                        totalRed += CGFloat(pixelData[pixelIndex])
                        totalGreen += CGFloat(pixelData[pixelIndex + 1])
                        totalBlue += CGFloat(pixelData[pixelIndex + 2])
                        count += 1
                    }
                }
            }

            guard count > 0 else { return nil }

            return UIColor(
                red: totalRed / (255.0 * count),
                green: totalGreen / (255.0 * count),
                blue: totalBlue / (255.0 * count),
                alpha: 1.0
            )
        }
    func convertTouchPointToImagePoint(touchPoint: CGPoint, imageView: UIImageView, image: UIImage) -> CGPoint? {
        guard let cgImage = image.cgImage else { return nil }

        let imageSize = CGSize(width: cgImage.width, height: cgImage.height)
        let imageViewSize = imageView.bounds.size

        let scaleX = imageSize.width / imageViewSize.width
        let scaleY = imageSize.height / imageViewSize.height

        return CGPoint(x: touchPoint.x * scaleX, y: touchPoint.y * scaleY)
    }

    func getExactPixelColor(from cgImage: CGImage, at point: CGPoint) -> UIColor? {
        let width = cgImage.width
        let height = cgImage.height

        guard let data = cgImage.dataProvider?.data,
              let pixelData = CFDataGetBytePtr(data) else { return nil }

        let x = Int(point.x)
        let y = Int(point.y)

        if x >= 0, x < width, y >= 0, y < height {
            let pixelIndex = (y * width + x) * 4
            let red = CGFloat(pixelData[pixelIndex]) / 255.0
            let green = CGFloat(pixelData[pixelIndex + 1]) / 255.0
            let blue = CGFloat(pixelData[pixelIndex + 2]) / 255.0
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
        return nil
    }

    func closestColor(to color: UIColor) -> String {
        var r1: CGFloat = 0, g1: CGFloat = 0, b1: CGFloat = 0
        color.getRed(&r1, green: &g1, blue: &b1, alpha: nil)

        let lab1 = rgbToLab(r: r1, g: g1, b: b1)
        var minDistance = Double.greatestFiniteMagnitude
        var closest = "Unknown"

        for (name, r, g, b) in x11Colors {
            let lab2 = rgbToLab(r: CGFloat(r)/255.0, g: CGFloat(g)/255.0, b: CGFloat(b)/255.0)
            let distance = deltaE(lab1: lab1, lab2: lab2)
            
            if distance < minDistance {
                minDistance = distance
                closest = name
            }
        }
        return closest
    }

    

        // MARK: - Color Conversion Functions
        func rgbToLab(r: CGFloat, g: CGFloat, b: CGFloat) -> (L: CGFloat, a: CGFloat, b: CGFloat) {
            var R = r > 0.04045 ? pow((r + 0.055)/1.055, 2.4) : r/12.92
            var G = g > 0.04045 ? pow((g + 0.055)/1.055, 2.4) : g/12.92
            var B = b > 0.04045 ? pow((b + 0.055)/1.055, 2.4) : b/12.92

            R *= 100.0
            G *= 100.0
            B *= 100.0

            let X = R * 0.4124 + G * 0.3576 + B * 0.1805
            let Y = R * 0.2126 + G * 0.7152 + B * 0.0722
            let Z = R * 0.0193 + G * 0.1192 + B * 0.9505

            let Xn = 95.047, Yn = 100.0, Zn = 108.883

            func f(_ t: CGFloat) -> CGFloat {
                return t > 0.008856 ? pow(t, 1/3) : (7.787 * t) + (16/116)
            }

            let x = X/Xn, y = Y/Yn, z = Z/Zn
            let L = (116 * f(y)) - 16
            let a = 500 * (f(x) - f(y))
            let bVal = 200 * (f(y) - f(z))

            return (L, a, bVal)
        }

        func deltaE(lab1: (L: CGFloat, a: CGFloat, b: CGFloat), lab2: (L: CGFloat, a: CGFloat, b: CGFloat)) -> Double {
            let dL = lab1.L - lab2.L
            let da = lab1.a - lab2.a
            let db = lab1.b - lab2.b
            return sqrt(Double(dL*dL + da*da + db*db))
        }
    }

    // MARK: - PhotoPicker for Image Selection
struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: PhotoPicker
        
        init(_ parent: PhotoPicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            guard let provider = results.first?.itemProvider else { return }
            
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { [weak self] image, _ in
                    guard let strongSelf = self, let uiImage = image as? UIImage else { return }
                    DispatchQueue.main.async {
                        strongSelf.parent.selectedImage = uiImage
                    }
                }
            }
        }
    }
}


