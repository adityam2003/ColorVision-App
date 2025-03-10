//
//  File.swift
//  ColorVision-App
//
//  Created by Aditya Mathur on 18/02/25.
//

import Foundation
import UIKit

struct IshiharaPlate {
    let imageName: String
    let correctAnswer: String
    let protanopiaAnswer: String
    let deuteranopiaAnswer: String
    let displayOptions: [String]
}

let ishiharaPlates: [IshiharaPlate] = [
    IshiharaPlate(imageName: "plate1", correctAnswer: "12", protanopiaAnswer: "12", deuteranopiaAnswer: "12", displayOptions: ["12", "other Number", "Plate cannot be seen"]),
    IshiharaPlate(imageName: "plate2", correctAnswer: "8", protanopiaAnswer: "3", deuteranopiaAnswer: "3", displayOptions: ["8", "3", "other Number"]),
    IshiharaPlate(imageName: "plate3", correctAnswer: "6", protanopiaAnswer: "5", deuteranopiaAnswer: "5", displayOptions: ["6", "5", "other Number"]),
    IshiharaPlate(imageName: "plate4", correctAnswer: "29", protanopiaAnswer: "70", deuteranopiaAnswer: "70", displayOptions: ["29", "70", "other Number"]),
    IshiharaPlate(imageName: "plate5", correctAnswer: "57", protanopiaAnswer: "35", deuteranopiaAnswer: "35", displayOptions: ["57", "35", "other Number"]),
    IshiharaPlate(imageName: "plate6", correctAnswer: "5", protanopiaAnswer: "2", deuteranopiaAnswer: "2", displayOptions: ["5", "2", "other Number"]),
    IshiharaPlate(imageName: "plate7", correctAnswer: "15", protanopiaAnswer: "17", deuteranopiaAnswer: "17", displayOptions: ["15", "17", "other Number"]),
    IshiharaPlate(imageName: "plate8", correctAnswer: "74", protanopiaAnswer: "21", deuteranopiaAnswer: "21", displayOptions: ["74", "21", "other Number"]),
    IshiharaPlate(imageName: "plate9", correctAnswer: "2", protanopiaAnswer: "4", deuteranopiaAnswer: "4", displayOptions: ["2", "4", "other Number"]),
    
    IshiharaPlate(imageName: "plate10", correctAnswer: "nothing", protanopiaAnswer: "5", deuteranopiaAnswer: "5", displayOptions: ["nothing", "5", "other Number"]),
    
    IshiharaPlate(imageName: "plate11", correctAnswer: "nothing", protanopiaAnswer: "2", deuteranopiaAnswer: "2", displayOptions: ["nothing", "2", "other Number"]),
    
    IshiharaPlate(imageName: "plate12", correctAnswer: "nothing", protanopiaAnswer: "45", deuteranopiaAnswer: "45", displayOptions: ["nothing", "45", "other Number"]),
    
    IshiharaPlate(imageName: "plate13", correctAnswer: "nothing", protanopiaAnswer: "73", deuteranopiaAnswer: "73", displayOptions: ["nothing", "73", "other Number"]),
    
    IshiharaPlate(imageName: "plate14", correctAnswer: "purple and red spots", protanopiaAnswer: "only line near bottom", deuteranopiaAnswer: "only line near top", displayOptions: ["purple and red spots", "only line near bottom", "only line near top"]),
    
    IshiharaPlate(imageName: "plate15", correctAnswer: "nothing", protanopiaAnswer: "line", deuteranopiaAnswer: "line", displayOptions: ["nothing", " line", "Plate cannot be seen"]),
    
    IshiharaPlate(imageName: "plate16", correctAnswer: "blue-green line", protanopiaAnswer: "nothing", deuteranopiaAnswer: "nothing", displayOptions: ["blue-green line", "nothing", "Plate cannot be seen"]),
    
    IshiharaPlate(imageName: "plate17", correctAnswer: "26", protanopiaAnswer: "6", deuteranopiaAnswer: "2", displayOptions: ["26", "6", "2"]),
    
    IshiharaPlate(imageName: "plate18", correctAnswer: "42", protanopiaAnswer: "2", deuteranopiaAnswer: "4", displayOptions: ["42", "2", "4"]),
    
    IshiharaPlate(imageName: "plate19", correctAnswer: "35", protanopiaAnswer: "5", deuteranopiaAnswer: "3", displayOptions: ["35", "5", "3"]),
    
    IshiharaPlate(imageName: "plate20", correctAnswer: "96", protanopiaAnswer: "6", deuteranopiaAnswer: "9", displayOptions: ["96", "6", "9"])
   
]



extension UIImage {
    static func gradientImage(colors: [UIColor], size: CGSize) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { context in
            let gradient = CGGradient(
                colorsSpace: CGColorSpaceCreateDeviceRGB(),
                colors: colors.map { $0.cgColor } as CFArray,
                locations: nil
            )
            let start = CGPoint(x: 0, y: 0)
            let end = CGPoint(x: size.width, y: size.height)
            context.cgContext.drawLinearGradient(gradient!, start: start, end: end, options: [])
        }
    }
}
