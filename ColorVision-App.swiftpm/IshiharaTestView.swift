//
//  File.swift
//  ColorVision-App
//
//  Created by Aditya on 06/02/25.
//

import SwiftUI

struct IshiharaTestView: View {
    @State private var userInput = ""
    @State private var currentIndex = 0
    @State private var protanopiaCount = 0
    @State private var deuteranopiaCount = 0
    @State private var showFinalResult = false
    @State private var finalMessage = ""
    
    @AppStorage("colorBlindnessType") private var colorBlindnessType: String = "Normal"
    @AppStorage("testTaken") private var testTaken: Bool = false

    var onTestCompletion: (() -> Void)?

    let plates = [
        ("12", "12", "12"),
        ("8", "3", "7"),
        ("6", "5", "5"),
        ("29", "70", "70"),
        ("57", "35", "35"),
        ("5", "2", "2"),
        ("3", "5", "5"),
        ("15", "17", "17"),
        ("74", "21", "21"),
        ("2", "4", "4"),
        
        // MARK: - Differentiator plates
        ("26", "6", "2"),
        ("42", "2", "4"),
        ("35", "5", "3"),
        ("96", "6", "9")
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                if showFinalResult {
                    ResultView(finalMessage: finalMessage, restartTest: restartTest)
                } else {
                    VStack {
                        Text("Enter the number")
                            .font(.headline)
                        
                        TextField("Enter the number", text: $userInput)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                            .keyboardType(.numberPad)
                            .onChange(of: userInput) { newValue in
                                userInput = newValue.filter { $0.isNumber }
                            }
                        
                        if currentIndex < plates.count - 1 {
                            Button("Next Question") {
                                evaluateAnswer()
                                moveToNextQuestion()
                            }
                            .buttonStyle(.bordered)
                            .tint(.blue)
                            .disabled(userInput.trimmingCharacters(in: .whitespaces).isEmpty)
                        } else {
                            Button("Show Final Results") {
                                evaluateAnswer()
                                detectDeficiency()
                                showFinalResult = true
                                testTaken = true
                                onTestCompletion?()
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.orange)
                            .disabled(userInput.trimmingCharacters(in: .whitespaces).isEmpty)
                        }
                        
                        Spacer()
                    }
                    .padding()
                    .navigationTitle("Ishihara Test")
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
        }
    }
    
    private func evaluateAnswer() {
        guard !userInput.isEmpty else { return }

        let normalAnswer = plates[currentIndex].0
        let protanopiaAnswer = plates[currentIndex].1
        let deuteranopiaAnswer = plates[currentIndex].2

        if userInput == normalAnswer {
            return
        } else if protanopiaAnswer == deuteranopiaAnswer && userInput == protanopiaAnswer {
            protanopiaCount += 1
            deuteranopiaCount += 1
        } else if userInput == protanopiaAnswer {
            protanopiaCount += 1
        } else if userInput == deuteranopiaAnswer {
            deuteranopiaCount += 1
        }
    }

    
    private func moveToNextQuestion() {
        userInput = ""
        currentIndex += 1
    }
    
    private func detectDeficiency() {
        let significantThreshold = 4
        
        if protanopiaCount >= significantThreshold {
            colorBlindnessType = "Protanopia"
            finalMessage = """
            Diagnosis: Protanopia (Red-Blind)
            
            You may have difficulty distinguishing red shades. Reds may appear brown, beige, or gray.
            Consider a professional color vision test for confirmation.
            """
        } else if deuteranopiaCount >= significantThreshold {
            colorBlindnessType = "Deuteranopia"
            finalMessage = """
            Diagnosis: Deuteranopia (Green-Blind)
            
            You may struggle to differentiate green from red. Greens may appear more yellow or beige.
            Consider consulting an eye specialist for a full assessment.
            """
        } else if protanopiaCount >= 2 {
            colorBlindnessType = "Possible Deficiency (Protanopia)"
            finalMessage = """
            Diagnosis: Possible Color Deficiency
            
            You made some errors that may indicate mild color vision issues (Protanopia).
            This test is not a medical diagnosis—consider seeing a professional.
            """
        } else if deuteranopiaCount >= 2 {
            colorBlindnessType = "Possible Deficiency (Deuteranopia)"
            finalMessage = """
            Diagnosis: Possible Color Deficiency
            
            You made some errors that may indicate mild color vision issues (Deuteranopia).
            This test is not a medical diagnosis—consider seeing a professional.
            """
        } else {
            colorBlindnessType = "Normal"
            finalMessage = """
            Diagnosis: Normal Color Vision
            
            Your responses suggest no significant color vision deficiency.
            """
        }
    }
    
    private func restartTest() {
        userInput = ""
        currentIndex = 0
        protanopiaCount = 0
        deuteranopiaCount = 0
        showFinalResult = false
        finalMessage = ""
        colorBlindnessType = "Normal"
        testTaken = false
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
