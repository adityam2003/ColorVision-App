//
//  File.swift
//  ColorVision-App
//
//  Created by Aditya Mathur on 18/02/25.
//

import Foundation

struct IshiharaPlate {
    let correctAnswer: String
    let protanopiaAnswer: String
    let deuteranopiaAnswer: String
    let displayOptions: [String]
}

let ishiharaPlates: [IshiharaPlate] = [
    IshiharaPlate(correctAnswer: "12", protanopiaAnswer: "12", deuteranopiaAnswer: "12", displayOptions: ["12", "other Number", "Plate cannot be seen"]),
    IshiharaPlate(correctAnswer: "8", protanopiaAnswer: "3", deuteranopiaAnswer: "3", displayOptions: ["8", "3", "other Number"]),
    IshiharaPlate(correctAnswer: "6", protanopiaAnswer: "5", deuteranopiaAnswer: "5", displayOptions: ["6", "5", "other Number"]),
    IshiharaPlate(correctAnswer: "29", protanopiaAnswer: "70", deuteranopiaAnswer: "70", displayOptions: ["29", "70", "other Number"]),
    IshiharaPlate(correctAnswer: "57", protanopiaAnswer: "35", deuteranopiaAnswer: "35", displayOptions: ["57", "35", "other Number"]),
    IshiharaPlate(correctAnswer: "5", protanopiaAnswer: "2", deuteranopiaAnswer: "2", displayOptions: ["5", "2", "other Number"]),
    IshiharaPlate(correctAnswer: "15", protanopiaAnswer: "17", deuteranopiaAnswer: "17", displayOptions: ["15", "17", "other Number"]),
    IshiharaPlate(correctAnswer: "74", protanopiaAnswer: "21", deuteranopiaAnswer: "21", displayOptions: ["74", "21", "other Number"]),
    IshiharaPlate(correctAnswer: "2", protanopiaAnswer: "4", deuteranopiaAnswer: "4", displayOptions: ["2", "4", "other Number"]),
    IshiharaPlate(correctAnswer: "nothing", protanopiaAnswer: "5", deuteranopiaAnswer: "5", displayOptions: ["nothing", "5", "other Number"]),
    IshiharaPlate(correctAnswer: "nothing", protanopiaAnswer: "2", deuteranopiaAnswer: "2", displayOptions: ["nothing", "2", "other Number"]),
    IshiharaPlate(correctAnswer: "nothing", protanopiaAnswer: "45", deuteranopiaAnswer: "45", displayOptions: ["nothing", "45", "other Number"]),
    IshiharaPlate(correctAnswer: "nothing", protanopiaAnswer: "73", deuteranopiaAnswer: "73", displayOptions: ["nothing", "73", "other Number"]),
    IshiharaPlate(correctAnswer: "purple and red spots", protanopiaAnswer: "only purple line", deuteranopiaAnswer: "only red line", displayOptions: ["purple and red spots", "only purple line", "only red line"]),
    IshiharaPlate(correctAnswer: "nothing", protanopiaAnswer: "a line", deuteranopiaAnswer: "a line", displayOptions: ["nothing", "a line", "Plate cannot be seen"]),
    IshiharaPlate(correctAnswer: "blue-green line", protanopiaAnswer: "nothing", deuteranopiaAnswer: "nothing", displayOptions: ["blue-green line", "nothing", "Plate cannot be seen"]),
    IshiharaPlate(correctAnswer: "26", protanopiaAnswer: "6", deuteranopiaAnswer: "2", displayOptions: ["26", "6", "2"]),
    IshiharaPlate(correctAnswer: "42", protanopiaAnswer: "2", deuteranopiaAnswer: "4", displayOptions: ["42", "2", "4"]),
    IshiharaPlate(correctAnswer: "35", protanopiaAnswer: "5", deuteranopiaAnswer: "3", displayOptions: ["35", "5", "3"]),
    IshiharaPlate(correctAnswer: "96", protanopiaAnswer: "6", deuteranopiaAnswer: "9", displayOptions: ["96", "6", "9"])
   
]
