//
//  File.swift
//  ColorVision-App
//
//  Created by Aditya on 06/02/25.
//
//


import SwiftUI
import PhotosUI
import CoreImage
import CoreImage.CIFilterBuiltins


struct PhotoColorIdentifierView: View {
    @State private var selectedImage: UIImage?
    @State private var tappedColorName: String = "Tap on the image to identify color"
    @State private var showPhotoPicker = false

    let x11Colors: [(name: String, r: Int, g: Int, b: Int)] = [
            ("alice blue", 240, 248, 255),
            ("AliceBlue", 240, 248, 255),
            ("antique white", 250, 235, 215),
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
            ("dark gray", 169, 169, 169),
                ("dark grey", 169, 169, 169),
                ("DarkGray", 169, 169, 169),
                ("DarkGrey", 169, 169, 169),
                ("dim gray", 105, 105, 105),
                ("dim grey", 105, 105, 105),
                ("DimGray", 105, 105, 105),
                ("DimGrey", 105, 105, 105),
                ("gainsboro", 220, 220, 220),
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
                ("gray15", 38, 38, 38),
                ("gray16", 41, 41, 41),
                ("gray17", 43, 43, 43),
                ("gray18", 46, 46, 46),
                ("gray19", 48, 48, 48),
                ("gray20", 51, 51, 51),
                ("gray21", 54, 54, 54),
                ("gray22", 56, 56, 56),
                ("gray23", 59, 59, 59),
                ("gray24", 61, 61, 61),
                ("gray25", 64, 64, 64),
                ("gray26", 66, 66, 66),
                ("gray27", 69, 69, 69),
                ("gray28", 71, 71, 71),
                ("gray29", 74, 74, 74),
                ("gray30", 77, 77, 77),
                ("gray31", 79, 79, 79),
                ("gray32", 82, 82, 82),
                ("gray33", 84, 84, 84),
                ("gray34", 87, 87, 87),
                ("gray35", 89, 89, 89),
                ("gray36", 92, 92, 92),
                ("gray37", 94, 94, 94),
                ("gray38", 97, 97, 97),
                ("gray39", 99, 99, 99),
                ("gray40", 102, 102, 102),
                ("gray41", 105, 105, 105),
                ("gray42", 107, 107, 107),
                ("gray43", 110, 110, 110),
                ("gray44", 112, 112, 112),
                ("gray45", 115, 115, 115),
                ("gray46", 117, 117, 117),
                ("gray47", 120, 120, 120),
                ("gray48", 122, 122, 122),
                ("gray49", 125, 125, 125),
                ("gray50", 127, 127, 127),
                ("gray51", 130, 130, 130),
                ("gray52", 133, 133, 133),
                ("gray53", 135, 135, 135),
                ("gray54", 138, 138, 138),
                ("gray55", 140, 140, 140),
                ("gray56", 143, 143, 143),
                ("gray57", 145, 145, 145),
                ("gray58", 148, 148, 148),
                ("gray59", 150, 150, 150),
                ("gray60", 153, 153, 153),
                ("gray61", 156, 156, 156),
                ("gray62", 158, 158, 158),
                ("gray63", 161, 161, 161),
                ("gray64", 163, 163, 163),
                ("gray65", 166, 166, 166),
                ("gray66", 168, 168, 168),
                ("gray67", 171, 171, 171),
                ("gray68", 173, 173, 173),
                ("gray69", 176, 176, 176),

        
        
    ]

//    var body: some View {
//        VStack {
//            Text("Photo-Based Color Identifier")
//                .font(.title2)
//                .padding()
//
//            if let image = selectedImage {
//                Image(uiImage: image)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 300, height: 300)
//                    .overlay(
//                        GeometryReader { geometry in
//                            Color.clear
//                                .contentShape(Rectangle())
//                                .onTapGesture { location in
//                                    let imageSize = image.size
//                                    let tapLocation = CGPoint(
//                                        x: location.x * (imageSize.width / geometry.size.width),
//                                        y: location.y * (imageSize.height / geometry.size.height)
//                                    )
//
//                                    if let tappedColor = getPixelColor(from: image, at: tapLocation) {
//                                        tappedColorName = closestColor(to: tappedColor)
//                                    }
//                                }
//                        }
//                    )
//                    .border(Color.black, width: 2)
//            } else {
//                Text("No image selected")
//                    .foregroundColor(.gray)
//                    .padding()
//            }
//
//            Text(tappedColorName)
//                .font(.headline)
//                .padding()
//                .frame(width: 250)
//                .background(Color.white)
//                .cornerRadius(10)
//                .shadow(radius: 5)
//
//            Button("Select Photo") {
//                showPhotoPicker = true
//            }
//            .padding()
//            .background(Color.blue)
//            .foregroundColor(.white)
//            .cornerRadius(10)
//
//            Spacer()
//        }
//        .padding()
//        .sheet(isPresented: $showPhotoPicker) {
//            PhotoPicker(selectedImage: $selectedImage)
//        }
//    }
//    func getPixelColor( from image: UIImage, at point: CGPoint) -> UIColor? {
//        guard let cgImage = image.cgImage,
//              let data = cgImage.dataProvider?.data,
//              let pixelData = CFDataGetBytePtr(data) else {
//            return nil
//        }
//
//        let width = cgImage.width
//        let x = Int(point.x)
//        let y = Int(point.y)
//        let bytesPerPixel = 4
//        let pixelIndex = (width * y + x) * bytesPerPixel
//
//        let red = CGFloat(pixelData[pixelIndex]) / 255.0
//        let green = CGFloat(pixelData[pixelIndex + 1]) / 255.0
//        let blue = CGFloat(pixelData[pixelIndex + 2]) / 255.0
//
//        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
//    }
//
//   
//
//    // Function to find the closest color
//    func closestColor(to color: UIColor) -> String {
//        var minDistance = Double.infinity
//        var closestColorName = "Unknown"
//
//        var r1: CGFloat = 0, g1: CGFloat = 0, b1: CGFloat = 0, a: CGFloat = 0
//        color.getRed(&r1, green: &g1, blue: &b1, alpha: &a)
//
//        for (name, r2, g2, b2) in x11Colors {
//            let distance = pow(Double(r1 * 255 - CGFloat(r2)), 2) +
//                           pow(Double(g1 * 255 - CGFloat(g2)), 2) +
//                           pow(Double(b1 * 255 - CGFloat(b2)), 2)
//
//            if distance < minDistance {
//                minDistance = distance
//                closestColorName = name
//            }
//        }
//        return closestColorName
//    }
//}
//
//// MARK: - PhotoPicker for Image Selection
//struct PhotoPicker: UIViewControllerRepresentable {
//    @Binding var selectedImage: UIImage?
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    func makeUIViewController(context: Context) -> PHPickerViewController {
//        var config = PHPickerConfiguration()
//        config.filter = .images
//        config.selectionLimit = 1
//
//        let picker = PHPickerViewController(configuration: config)
//        picker.delegate = context.coordinator
//        return picker
//    }
//
//    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
//
//    class Coordinator: NSObject, PHPickerViewControllerDelegate {
//        let parent: PhotoPicker
//
//        init(_ parent: PhotoPicker) {
//            self.parent = parent
//        }
//
//        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
//            picker.dismiss(animated: true)
//
//            guard let provider = results.first?.itemProvider else { return }
//
//            if provider.canLoadObject(ofClass: UIImage.self) {
//                provider.loadObject(ofClass: UIImage.self) { [weak self] image, _ in
//                    guard let strongSelf = self, let uiImage = image as? UIImage else { return }
//                    DispatchQueue.main.async {
//                        strongSelf.parent.selectedImage = uiImage
//                    }
//                }
//            }
//
//
//
//        }
//    }
//}
//
//  
//        

     
  

        var body: some View {
            VStack {
                Text("Photo-Based Color Identifier")
                    .font(.title2)
                    .padding()

                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                        .overlay(
                            GeometryReader { geometry in
                                Color.clear
                                    .contentShape(Rectangle())
                                    .onTapGesture { location in
                                        let imageSize = image.size
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
        }

        func getAverageColor(from image: UIImage, at point: CGPoint) -> UIColor? {
            guard let cgImage = image.cgImage,
                  let data = cgImage.dataProvider?.data,
                  let pixelData = CFDataGetBytePtr(data) else {
                return nil
            }

            let width = cgImage.width
            let height = cgImage.height
            let bytesPerPixel = 4
            let radius = 3
            var totalRed: CGFloat = 0, totalGreen: CGFloat = 0, totalBlue: CGFloat = 0
            var count: CGFloat = 0

            for dx in -radius...radius {
                for dy in -radius...radius {
                    let x = Int(point.x) + dx
                    let y = Int(point.y) + dy

                    if x >= 0, x < width, y >= 0, y < height {
                        let pixelIndex = (width * y + x) * bytesPerPixel
                        totalRed += CGFloat(pixelData[pixelIndex])
                        totalGreen += CGFloat(pixelData[pixelIndex + 1])
                        totalBlue += CGFloat(pixelData[pixelIndex + 2])
                        count += 1
                    }
                }
            }

            return UIColor(red: totalRed / (255.0 * count),
                           green: totalGreen / (255.0 * count),
                           blue: totalBlue / (255.0 * count),
                           alpha: 1.0)
        }

        func closestColor(to color: UIColor) -> String {
            var minDistance = Double.infinity
            var closestColorName = "Unknown"

            var r1: CGFloat = 0, g1: CGFloat = 0, b1: CGFloat = 0, a: CGFloat = 0
            color.getRed(&r1, green: &g1, blue: &b1, alpha: &a)

            for (name, r2, g2, b2) in x11Colors {
                let distance = pow(Double(r1 * 255 - CGFloat(r2)), 2) +
                               pow(Double(g1 * 255 - CGFloat(g2)), 2) +
                               pow(Double(b1 * 255 - CGFloat(b2)), 2)

                if distance < minDistance {
                    minDistance = distance
                    closestColorName = name
                }
            }
            return closestColorName
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
