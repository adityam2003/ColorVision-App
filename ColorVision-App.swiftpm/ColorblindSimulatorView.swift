//
//  File.swift
//  ColorVision-App
//
//  Created by Aditya on 06/02/25.
//
//
//import SwiftUI
//import CoreImage
//import CoreImage.CIFilterBuiltins
//
//struct ColorblindSimulatorView: View {
//    @State private var inputImage: UIImage?
//    @State private var filteredImage: UIImage?
//
//    let context = CIContext()
//    let filter = CIFilter.colorMonochrome()
//
//    var body: some View {
//        VStack {
//            if let image = filteredImage {
//                Image(uiImage: image)
//                    .resizable()
//                    .scaledToFit()
//            } else {
//                Text("Upload an image to simulate color blindness")
//            }
//
//            Button("Choose Image") {
//                selectImage()
//            }
//            .padding()
//            .background(Color.blue)
//            .foregroundColor(.white)
//            .cornerRadius(10)
//
//            Button("Apply Protanopia Filter") {
//                applyFilter()
//            }
//            .padding()
//            .background(Color.orange)
//            .foregroundColor(.white)
//            .cornerRadius(10)
//        }
//        .padding()
//    }
//
//    func selectImage() {
//        inputImage = UIImage(named: "sample") // Replace with real picker logic
//        filteredImage = inputImage
//    }
//
//    func applyFilter() {
//        guard let inputImage = inputImage else { return }
//        let ciImage = CIImage(image: inputImage)
//        filter.inputImage = ciImage
//        filter.color = CIColor(red: 0.8, green: 0.1, blue: 0.1) // Simulate Protanopia
//
//        if let output = filter.outputImage, let cgimg = context.createCGImage(output, from: output.extent) {
//            filteredImage = UIImage(cgImage: cgimg)
//        }
//    }
//}
//



//
//import SwiftUI
//import CoreImage
//import CoreImage.CIFilterBuiltins
//import PhotosUI
//
//struct ColorblindSimulatorView: View {
//    @State private var inputImage: UIImage?
//    @State private var filteredImage: UIImage?
//    @State private var showImagePicker = false
//
//    let context = CIContext()
//
//    var body: some View {
//        VStack {
//            if let image = filteredImage ?? inputImage {
//                Image(uiImage: image)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(height: 300)
//                    .cornerRadius(10)
//                    .shadow(radius: 5)
//            } else {
//                Text("Upload an image to simulate color blindness")
//                    .foregroundColor(.gray)
//                    .padding()
//            }
//
//            HStack {
//                Button("Choose Image") {
//                    showImagePicker = true
//                }
//                .buttonStyle(CustomButtonStyle(color: .blue))
//
//                Button("Protanopia") {
//                    applyFilter(type: .protanopia)
//                }
//                .buttonStyle(CustomButtonStyle(color: .orange))
//
//                Button("Deuteranopia") {
//                    applyFilter(type: .deuteranopia)
//                }
//                .buttonStyle(CustomButtonStyle(color: .green))
//
//                Button("Tritanopia") {
//                    applyFilter(type: .tritanopia)
//                }
//                .buttonStyle(CustomButtonStyle(color: .red))
//            }
//            .padding()
//
//        }
//        .padding()
//        .sheet(isPresented: $showImagePicker) {
//            ImagePicker(image: $inputImage)
//        }
//    }
//
//    func applyFilter(type: ColorBlindType) {
//        guard let inputImage = inputImage else { return }
//        let ciImage = CIImage(image: inputImage)
//        
//        let filter = CIFilter.colorMatrix()
//        switch type {
//        case .protanopia:
//            filter.rVector = CIVector(x: 0.567, y: 0.433, z: 0, w: 0)
//            filter.gVector = CIVector(x: 0.558, y: 0.442, z: 0, w: 0)
//            filter.bVector = CIVector(x: 0, y: 0.242, z: 0.758, w: 0)
//        case .deuteranopia:
//            filter.rVector = CIVector(x: 0.625, y: 0.375, z: 0, w: 0)
//            filter.gVector = CIVector(x: 0.7, y: 0.3, z: 0, w: 0)
//            filter.bVector = CIVector(x: 0, y: 0.3, z: 0.7, w: 0)
//        case .tritanopia:
//            filter.rVector = CIVector(x: 0.95, y: 0.05, z: 0, w: 0)
//            filter.gVector = CIVector(x: 0, y: 0.433, z: 0.567, w: 0)
//            filter.bVector = CIVector(x: 0, y: 0.475, z: 0.525, w: 0)
//        }
//        
//        filter.inputImage = ciImage
//        if let output = filter.outputImage, let cgimg = context.createCGImage(output, from: output.extent) {
//            filteredImage = UIImage(cgImage: cgimg)
//        }
//    }
//}
//
//// Enum for different colorblind types
//enum ColorBlindType {
//    case protanopia, deuteranopia, tritanopia
//}
//
//// Custom button style for consistent UI
//struct CustomButtonStyle: ButtonStyle {
//    var color: Color
//    
//    func makeBody(configuration: Configuration) -> some View {
//        configuration.label
//            .padding()
//            .background(color)
//            .foregroundColor(.white)
//            .cornerRadius(10)
//            .shadow(radius: configuration.isPressed ? 2 : 5)
//    }
//}
//
//// Image Picker to allow users to select an image
//struct ImagePicker: UIViewControllerRepresentable {
//    @Binding var image: UIImage?
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    func makeUIViewController(context: Context) -> UIImagePickerController {
//        let picker = UIImagePickerController()
//        picker.delegate = context.coordinator
//        picker.sourceType = .photoLibrary
//        return picker
//    }
//
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
//
//    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
//        let parent: ImagePicker
//
//        init(_ parent: ImagePicker) {
//            self.parent = parent
//        }
//
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
//            if let uiImage = info[.originalImage] as? UIImage {
//                parent.image = uiImage
//            }
//            picker.dismiss(animated: true)
//        }
//    }
//}

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI

struct ColorblindSimulatorView: View {
    @State private var inputImage: UIImage?
    @State private var filteredImage: UIImage?
    @State private var selectedItem: PhotosPickerItem?
    @AppStorage("colorBlindnessType") private var colorBlindnessType: String = "Normal"
    
    let context = CIContext()
    
    var body: some View {
        VStack {
            if let image = filteredImage ?? inputImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            } else {
                Text("Upload an image to simulate color blindness")
                    .foregroundColor(.gray)
                    .padding()
            }
            
            PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
                Text("Choose Image")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .onChange(of: selectedItem) { newItem in
                loadImage(from: newItem)
            }
            
            Button("Apply Simulation") {
                applyFilter()
            }
            .buttonStyle(.borderedProminent)
            .tint(.orange)
        }
        .padding()
    }
    
    func loadImage(from item: PhotosPickerItem?) {
        guard let item = item else { return }
        Task {
            if let data = try? await item.loadTransferable(type: Data.self),
               let uiImage = UIImage(data: data) {
                inputImage = uiImage
                filteredImage = nil
            }
        }
    }
    
   
    func applyFilter() {
        guard let inputImage = inputImage else { return }
        
        let ciImage = CIImage(image: inputImage)
        
        let filter = CIFilter.colorMatrix()
        switch colorBlindnessType {
        case "Protanopia":
            filter.rVector = CIVector(x: 0.567, y: 0.433, z: 0, w: 0)
            filter.gVector = CIVector(x: 0.558, y: 0.442, z: 0, w: 0)
            filter.bVector = CIVector(x: 0, y: 0.242, z: 0.758, w: 0)
        case "Deuteranopia":
            filter.rVector = CIVector(x: 0.625, y: 0.375, z: 0, w: 0)
            filter.gVector = CIVector(x: 0.7, y: 0.3, z: 0, w: 0)
            filter.bVector = CIVector(x: 0, y: 0.3, z: 0.7, w: 0)
        case "Tritanopia":
            filter.rVector = CIVector(x: 0.95, y: 0.05, z: 0, w: 0)
            filter.gVector = CIVector(x: 0, y: 0.433, z: 0.567, w: 0)
            filter.bVector = CIVector(x: 0, y: 0.475, z: 0.525, w: 0)
        default:
            return
        }
        
        filter.inputImage = ciImage
        if let output = filter.outputImage, let cgimg = context.createCGImage(output, from: output.extent) {
            let fixedImage = UIImage(cgImage: cgimg, scale: inputImage.scale, orientation: inputImage.imageOrientation)
            filteredImage = fixedImage
        }
    }
}
