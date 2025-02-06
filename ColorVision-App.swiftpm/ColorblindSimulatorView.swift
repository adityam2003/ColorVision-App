//
//  File.swift
//  ColorVision-App
//
//  Created by Aditya on 06/02/25.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ColorblindSimulatorView: View {
    @State private var inputImage: UIImage?
    @State private var filteredImage: UIImage?

    let context = CIContext()
    let filter = CIFilter.colorMonochrome()

    var body: some View {
        VStack {
            if let image = filteredImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                Text("Upload an image to simulate color blindness")
            }

            Button("Choose Image") {
                selectImage()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)

            Button("Apply Protanopia Filter") {
                applyFilter()
            }
            .padding()
            .background(Color.orange)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }

    func selectImage() {
        inputImage = UIImage(named: "sample") // Replace with real picker logic
        filteredImage = inputImage
    }

    func applyFilter() {
        guard let inputImage = inputImage else { return }
        let ciImage = CIImage(image: inputImage)
        filter.inputImage = ciImage
        filter.color = CIColor(red: 0.8, green: 0.1, blue: 0.1) // Simulate Protanopia

        if let output = filter.outputImage, let cgimg = context.createCGImage(output, from: output.extent) {
            filteredImage = UIImage(cgImage: cgimg)
        }
    }
}

