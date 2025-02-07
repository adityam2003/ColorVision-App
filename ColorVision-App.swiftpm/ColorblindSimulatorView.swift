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
//import PhotosUI
//
//struct ColorblindSimulatorView: View {
//    @State private var inputImage: UIImage?
//    @State private var filteredImage: UIImage?
//    @State private var selectedItem: PhotosPickerItem?
//    @AppStorage("colorBlindnessType") private var colorBlindnessType: String = "Normal"
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
//            PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
//                Text("Choose Image")
//                    .padding()
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }
//            .onChange(of: selectedItem) { newItem in
//                loadImage(from: newItem)
//            }
//            
//            Button("Apply Simulation") {
//                applyFilter()
//            }
//            .buttonStyle(.borderedProminent)
//            .tint(.orange)
//        }
//        .padding()
//    }
//    
//    func loadImage(from item: PhotosPickerItem?) {
//        guard let item = item else { return }
//        Task {
//            if let data = try? await item.loadTransferable(type: Data.self),
//               let uiImage = UIImage(data: data) {
//                inputImage = uiImage
//                filteredImage = nil
//            }
//        }
//    }
//    
//   
//    func applyFilter() {
//        guard let inputImage = inputImage else { return }
//        
//        let ciImage = CIImage(image: inputImage)
//        
//        let filter = CIFilter.colorMatrix()
//        switch colorBlindnessType {
//        case "Protanopia":
//            filter.rVector = CIVector(x: 0.567, y: 0.433, z: 0, w: 0)
//            filter.gVector = CIVector(x: 0.558, y: 0.442, z: 0, w: 0)
//            filter.bVector = CIVector(x: 0, y: 0.242, z: 0.758, w: 0)
//        case "Possible Deficiency-(Protanopia)":
//            filter.rVector = CIVector(x: 0.567, y: 0.433, z: 0, w: 0)
//            filter.gVector = CIVector(x: 0.558, y: 0.442, z: 0, w: 0)
//            filter.bVector = CIVector(x: 0, y: 0.242, z: 0.758, w: 0)
//        case "Deuteranopia":
//            filter.rVector = CIVector(x: 0.625, y: 0.375, z: 0, w: 0)
//            filter.gVector = CIVector(x: 0.7, y: 0.3, z: 0, w: 0)
//            filter.bVector = CIVector(x: 0, y: 0.3, z: 0.7, w: 0)
//        case "Possible Deficiency-(Deuteranopia)":
//            filter.rVector = CIVector(x: 0.625, y: 0.375, z: 0, w: 0)
//            filter.gVector = CIVector(x: 0.7, y: 0.3, z: 0, w: 0)
//            filter.bVector = CIVector(x: 0, y: 0.3, z: 0.7, w: 0)
//        default:
//            return
//        }
//        
//        filter.inputImage = ciImage
//        if let output = filter.outputImage, let cgimg = context.createCGImage(output, from: output.extent) {
//            let fixedImage = UIImage(cgImage: cgimg, scale: inputImage.scale, orientation: inputImage.imageOrientation)
//            filteredImage = fixedImage
//        }
//    }
//}

//import SwiftUI
//import CoreImage
//import CoreImage.CIFilterBuiltins
//import PhotosUI
//
//struct ColorblindEnhancerView: View {
//    @State private var inputImage: UIImage?
//    @State private var enhancedImage: UIImage?
//    @State private var selectedItem: PhotosPickerItem?
//    @AppStorage("colorBlindnessType") private var colorBlindnessType: String = "Normal"
//    
//    let context = CIContext()
//
//    var body: some View {
//        VStack {
//            if let image = enhancedImage ?? inputImage {
//                Image(uiImage: image)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(height: 300)
//                    .cornerRadius(10)
//                    .shadow(radius: 5)
//            } else {
//                Text("Upload an image to enhance colors for better visibility")
//                    .foregroundColor(.gray)
//                    .padding()
//            }
//            
//            PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
//                Text("Choose Image")
//                    .padding()
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }
//            .onChange(of: selectedItem) { newItem in
//                loadImage(from: newItem)
//            }
//            
//            Button("Enhance Colors") {
//                applyColorCorrection()
//            }
//            .buttonStyle(.borderedProminent)
//            .tint(.green)
//        }
//        .padding()
//    }
//
//    func loadImage(from item: PhotosPickerItem?) {
//        guard let item = item else { return }
//        Task {
//            if let data = try? await item.loadTransferable(type: Data.self),
//               let uiImage = UIImage(data: data) {
//                inputImage = uiImage
//                enhancedImage = nil
//            }
//        }
//    }
//
//    // ✅ Color Remapping: Adjusts colors for better differentiation
//    func applyColorCorrection() {
//        guard let inputImage = inputImage else { return }
//        let ciImage = CIImage(image: inputImage)
//        
//        let filter = CIFilter.colorMatrix()
//        switch colorBlindnessType {
//        case "Protanopia":
//            // Adjust red-green to improve differentiation
//            filter.rVector = CIVector(x: 1.0, y: -0.1, z: 0, w: 0)
//            filter.gVector = CIVector(x: 0, y: 1.2, z: 0, w: 0)
//            filter.bVector = CIVector(x: 0, y: 0, z: 1.0, w: 0)
//        case "Deuteranopia":
//            // Convert red-green confusion into blue-yellow contrast
//            filter.rVector = CIVector(x: 1.0, y: 0, z: 0, w: 0)
//            filter.gVector = CIVector(x: 0, y: 0.8, z: 0.2, w: 0)
//            filter.bVector = CIVector(x: 0, y: 0.2, z: 0.8, w: 0)
//        default:
//            return
//        }
//
//        filter.inputImage = ciImage
//        processImage(filter)
//    }
//
//    // 🛠 Applies filter and updates the UI
//    func processImage(_ filter: CIFilter) {
//        if let output = filter.outputImage, let cgimg = context.createCGImage(output, from: output.extent) {
//            let fixedImage = UIImage(cgImage: cgimg, scale: inputImage!.scale, orientation: inputImage!.imageOrientation)
//            enhancedImage = fixedImage
//        }
//    }
//}

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI

struct ColorRemapView: View {
    @State private var inputImage: UIImage?
    @State private var remappedImage: UIImage?
    @State private var selectedItem: PhotosPickerItem?
    @AppStorage("colorBlindnessType") private var colorBlindnessType: String = "Normal"
    
    let context = CIContext()
    
    var body: some View {
        VStack {
            if let image = remappedImage ?? inputImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            } else {
                Text("Upload an image for color remapping")
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
            
            Button("Apply Color Remapping") {
                applyColorRemap()
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
                remappedImage = nil
            }
        }
    }
    
    func applyColorRemap() {
        guard let inputImage = inputImage else { return }
        
        let ciImage = CIImage(image: inputImage)
        let filter = CIFilter.colorMatrix()
        
        switch colorBlindnessType {
        case "Protanopia":
            filter.rVector = CIVector(x: 0.8, y: 0.2, z: 0, w: 0) // Shift reds to orange/yellow
            filter.gVector = CIVector(x: 0.3, y: 0.7, z: 0, w: 0) // Boost greens to be more cyan
            filter.bVector = CIVector(x: 0, y: 0.1, z: 0.9, w: 0) // Keep blues normal
        
        case "Deuteranopia":
            filter.rVector = CIVector(x: 0.6, y: 0.4, z: 0, w: 0) // Make reds less dominant
            filter.gVector = CIVector(x: 0.3, y: 0.7, z: 0, w: 0) // Shift greens to cyan
            filter.bVector = CIVector(x: 0, y: 0.2, z: 0.8, w: 0) // Adjust blues slightly
        
        default:
            return
        }
        
        filter.inputImage = ciImage
        if let output = filter.outputImage, let cgimg = context.createCGImage(output, from: output.extent) {
            let fixedImage = UIImage(cgImage: cgimg, scale: inputImage.scale, orientation: inputImage.imageOrientation)
            remappedImage = fixedImage
        }
    }
}
