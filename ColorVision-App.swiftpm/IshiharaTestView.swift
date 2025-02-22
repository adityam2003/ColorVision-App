//
//  File.swift
//  ColorVision-App
//
//  Created by Aditya on 06/02/25.
//

import SwiftUI

struct IshiharaTestView: View {
    @State private var currentIndex = 0
    @State private var protanopiaCount = 0
    @State private var deuteranopiaCount = 0
    @State private var showFinalResult = false
    @State private var finalMessage = ""
    
    @AppStorage("colorBlindnessType") private var colorBlindnessType: String = "Normal"
    @AppStorage("testTaken") private var testTaken: Bool = false

    var onTestCompletion: (() -> Void)?
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.white]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    if showFinalResult {
                        ResultView(finalMessage: finalMessage, restartTest: restartTest)
                    } else {
                        VStack {
                            Text("Ishihara Test")
                                .font(.title)
                                .fontWeight(.bold)
                            Image(ishiharaPlates[currentIndex].imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 250, height: 250)
                                    .padding()
                            
                            Text("Select the number you see")
                                .font(.headline)
                                .foregroundColor(.gray)

                            ForEach(ishiharaPlates[currentIndex].displayOptions, id: \.self) { option in
                                Button(action: {
                                    evaluateAnswer(selectedAnswer: option)
                                    moveToNextQuestion()
                                }) {
                                    Text(option)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                }
                            }
                            Spacer()
                        }
                        .padding()
//                        .navigationTitle("Ishihara Test")
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarBackButtonHidden(false)
                    }
                }
            }
        }
    }
    
    private func evaluateAnswer(selectedAnswer: String) {
        let currentPlate = ishiharaPlates[currentIndex]

        if selectedAnswer == currentPlate.correctAnswer {
            return
        } else if selectedAnswer == currentPlate.protanopiaAnswer && selectedAnswer == currentPlate.deuteranopiaAnswer {
            
            protanopiaCount += 1
            deuteranopiaCount += 1
        } else if selectedAnswer == currentPlate.protanopiaAnswer {
            protanopiaCount += 1
        } else if selectedAnswer == currentPlate.deuteranopiaAnswer {
            deuteranopiaCount += 1
        }
    }

    private func moveToNextQuestion() {
        if currentIndex < ishiharaPlates.count - 1 {
            currentIndex += 1
        } else {
            detectDeficiency()
            showFinalResult = true
            testTaken = true
            onTestCompletion?()
        }
    }
    
    private func detectDeficiency() {
        let significantThreshold = 4
        
        if protanopiaCount >= significantThreshold {
            colorBlindnessType = "Protanopia"
            finalMessage = "Diagnosis: Protanopia (Red-Blind)\n\nYou may have difficulty distinguishing red shades.\n\nYou should Consult a Doctor for further evaluation."
        } else if deuteranopiaCount >= significantThreshold {
            colorBlindnessType = "Deuteranopia"
            finalMessage = "Diagnosis: Deuteranopia (Green-Blind)\n\nYou may struggle to differentiate green from red. \n\nYou should Consult a Doctor for further evaluation"
        } else {
            colorBlindnessType = "Normal"
            finalMessage = "Diagnosis: Normal Color Vision\n\nYour responses suggest no significant color vision deficiency."
        }
    }
    
    private func restartTest() {
        currentIndex = 0
        protanopiaCount = 0
        deuteranopiaCount = 0
        showFinalResult = false
        finalMessage = ""
        colorBlindnessType = "Normal"
        testTaken = false
    }
}

func getOption(from tuple: (String, String, String), at index: Int) -> String {
    switch index {
    case 0: return tuple.0
    case 1: return tuple.1
    case 2: return tuple.2
    default: return ""
    }
}

struct ResultView: View {
    let finalMessage: String
    var restartTest: () -> Void

    var body: some View {
        VStack {
            Text("Test Results")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            Text(finalMessage)
                .padding()
                .multilineTextAlignment(.center)

            Button("Restart Test") {
                restartTest()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
        .navigationBarBackButtonHidden(true)
    }
}
