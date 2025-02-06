//
//  File.swift
//  ColorVision-App
//
//  Created by Aditya on 06/02/25.
//


//
//import SwiftUI
//
//struct IshiharaTestView: View {
//    @State private var userInput = ""
//    @State private var currentIndex = 0
//    @State private var protanopiaCount = 0
//    @State private var deuteranopiaCount = 0
//    @State private var tritanopiaCount = 0
//    @State private var showFinalResult = false
//    @State private var finalMessage = ""
//    
//    @AppStorage("colorBlindnessType") private var colorBlindnessType: String = "Normal"
//    
//    let plates = [
//        ("ishihara_1", "12", "12", "12", "12"),
//        ("ishihara_2", "8", "3", "3", "8"),
//        ("ishihara_3", "6", "5", "5", "6"),
//        ("ishihara_4", "29", "70", "70", "29"),
//        ("ishihara_5", "57", "35", "35", "57"),
//        ("ishihara_6", "5", "2", "2", "5"),
//        ("ishihara_7", "3", "5", "5", "3"),
//        ("ishihara_8", "15", "17", "17", "15"),
//        ("ishihara_9", "74", "21", "21", "74"),
//        ("ishihara_10", "2", "4", "4", "2")
//    ]
//    
//    
//    var body: some View {
//        NavigationStack {
//            VStack {
//                if showFinalResult {
//                    ResultView(finalMessage: finalMessage)
//                } else {
//                    VStack {
//                        Image(plates[currentIndex].0)
//                            .resizable()
//                            .scaledToFit()
//                            .frame(height: 300)
//                            .padding(.bottom)
//                        
//                        TextField("Enter the number", text: $userInput)
//                            .textFieldStyle(RoundedBorderTextFieldStyle())
//                            .padding()
//                            .keyboardType(.numberPad)
//                            .onChange(of: userInput) { newValue in
//                                userInput = newValue.filter { $0.isNumber }
//                            }
//                        
//                        if currentIndex < plates.count - 1 {
//                            Button("Next Question") {
//                                evaluateAnswer()
//                                moveToNextQuestion()
//                            }
//                            .buttonStyle(.bordered)
//                            .tint(.blue)
//                            .disabled(userInput.trimmingCharacters(in: .whitespaces).isEmpty)
//                        } else {
//                            Button("Show Final Results") {
//                                evaluateAnswer()
//                                detectDeficiency()
//                                showFinalResult = true
//                            }
//                            .buttonStyle(.borderedProminent)
//                            .tint(.orange)
//                            .disabled(userInput.trimmingCharacters(in: .whitespaces).isEmpty)
//                        }
//                        
//                        Spacer()
//                    }
//                    .padding()
//                    .navigationTitle("Ishihara Test")
//                    .navigationBarTitleDisplayMode(.inline)
//                }
//            }
//        }
//    }
//    
//    private func evaluateAnswer() {
//        guard !userInput.isEmpty else { return }
//        
//        let normalAnswer = plates[currentIndex].1
//        let protanopiaAnswer = plates[currentIndex].2
//        let deuteranopiaAnswer = plates[currentIndex].3
//        let tritanopiaAnswer = plates[currentIndex].4
//        
//        if userInput == normalAnswer {
//            return
//        } else if userInput == protanopiaAnswer {
//            protanopiaCount += 1
//        } else if userInput == deuteranopiaAnswer {
//            deuteranopiaCount += 1
//        } else if userInput == tritanopiaAnswer {
//            tritanopiaCount += 1
//        }
//    }
//    
//    private func moveToNextQuestion() {
//        userInput = ""
//        currentIndex += 1
//    }
//    
//    private func detectDeficiency() {
//        let maxCount = max(protanopiaCount, deuteranopiaCount, tritanopiaCount)
//        
//        switch maxCount {
//        case protanopiaCount where maxCount > 0:
//            colorBlindnessType = "Protanopia"
//            finalMessage = """
//            Diagnosis: Protanopia (Red-Blind)
//            
//            You may have difficulty distinguishing red shades. Reds may appear brown, beige, or gray.
//            """
//        case deuteranopiaCount where maxCount > 0:
//            colorBlindnessType = "Deuteranopia"
//            finalMessage = """
//            Diagnosis: Deuteranopia (Green-Blind)
//            
//            You may struggle to differentiate green from red. Greens may appear more yellow or beige.
//            """
//        case tritanopiaCount where maxCount > 0:
//            colorBlindnessType = "Tritanopia"
//            finalMessage = """
//            Diagnosis: Tritanopia (Blue-Blind)
//            
//            Blues may appear green, and you may struggle to tell purple from pink.
//            """
//        default:
//            colorBlindnessType = "Normal"
//            finalMessage = """
//            Diagnosis: Normal Color Vision
//            
//            You have passed the Ishihara test, indicating no major color vision deficiencies.
//            """
//        }
//    }
//}
//
//struct ResultView: View {
//    let finalMessage: String
//
//    var body: some View {
//        VStack {
//            Text("Test Results")
//                .font(.largeTitle)
//                .fontWeight(.bold)
//                .padding()
//
//            Text(finalMessage)
//                .padding()
//                .multilineTextAlignment(.center)
//
//            NavigationLink(destination: IshiharaTestView().navigationBarBackButtonHidden(true)) {
//                Text("Restart Test")
//                    .padding()
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }
//        }
//        .padding()
//        .navigationBarBackButtonHidden(true)
//    }
//}


import SwiftUI
struct IshiharaPalette {
    static let backgroundColors: [Color] = [
        Color(red: 100/255, green: 200/255, blue: 100/255),
        Color(red: 110/255, green: 180/255, blue: 110/255),
        Color(red: 90/255, green: 210/255, blue: 120/255)
    ]
    
    static let numberColors: [Color] = [
        Color(red: 200/255, green: 100/255, blue: 100/255),
        Color(red: 190/255, green: 90/255, blue: 90/255),
        Color(red: 220/255, green: 120/255, blue: 120/255)
    ]
}

// MARK: - Ishihara Plate Generator View
struct IshiharaPlateView: View {
    let number: String
    let dotCount = 1000
    
    var body: some View {
        ZStack {
            ForEach(0..<dotCount, id: \ .self) { _ in
                Circle()
                    .fill(Bool.random() ? IshiharaPalette.backgroundColors.randomElement()! : IshiharaPalette.numberColors.randomElement()!)
                    .frame(width: CGFloat.random(in: 5...15), height: CGFloat.random(in: 5...15))
                    .position(randomPosition())
            }
            Text(number)
                .font(.system(size: 80, weight: .bold))
                .foregroundColor(IshiharaPalette.numberColors.randomElement()!)
                .opacity(0.5)
        }
        .frame(width: 300, height: 300)
    }
    
    private func randomPosition() -> CGPoint {
        return CGPoint(x: CGFloat.random(in: 0...300), y: CGFloat.random(in: 0...300))
    }
}

// MARK: - Example Usage in Preview

// MARK: - Ishihara Palette Generator
//struct IshiharaPalette {
//    static let backgroundColors: [Color] = [
//        Color(red: 100/255, green: 200/255, blue: 100/255), // Greenish tone
//        Color(red: 110/255, green: 180/255, blue: 110/255),
//        Color(red: 90/255, green: 210/255, blue: 120/255)
//    ]
//    
//    static let numberColors: [Color] = [
//        Color(red: 200/255, green: 100/255, blue: 100/255), // Reddish tone
//        Color(red: 190/255, green: 90/255, blue: 90/255),
//        Color(red: 220/255, green: 120/255, blue: 120/255)
//    ]
//}
//
//// MARK: - Ishihara Plate View
//struct IshiharaPlateView: View {
//    let number: String
//    let dotCount = 500
//    
//    var body: some View {
//        Canvas { context, size in
//            for _ in 0..<dotCount {
//                let x = CGFloat.random(in: 0..<size.width)
//                let y = CGFloat.random(in: 0..<size.height)
//                let radius = CGFloat.random(in: 5...15)
//                let color = Bool.random() ? IshiharaPalette.backgroundColors.randomElement()! : IshiharaPalette.numberColors.randomElement()!
//                
//                context.fill(Circle().path(in: CGRect(x: x, y: y, width: radius, height: radius)), with: .color(color))
//            }
//        }
//        .frame(width: 300, height: 300)
//        .overlay(
//            Text(number)
//                .font(.system(size: 80, weight: .bold))
//                .foregroundColor(IshiharaPalette.numberColors.randomElement()!)
//        )
//    }
//}

// MARK: - Updated Ishihara Test View
struct IshiharaTestView: View {
    @State private var userInput = ""
    @State private var currentIndex = 0
    @State private var protanopiaCount = 0
    @State private var deuteranopiaCount = 0
    @State private var tritanopiaCount = 0
    @State private var showFinalResult = false
    @State private var finalMessage = ""
    
    @AppStorage("colorBlindnessType") private var colorBlindnessType: String = "Normal"
    
    let plates = [
        ("12", "12", "12", "12"),
        ("8", "3", "3", "8"),
        ("6", "5", "5", "6"),
        ("29", "70", "70", "29"),
        ("57", "35", "35", "57"),
        ("5", "2", "2", "5"),
        ("3", "5", "5", "3"),
        ("15", "17", "17", "15"),
        ("74", "21", "21", "74"),
        ("2", "4", "4", "2")
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                if showFinalResult {
                    ResultView(finalMessage: finalMessage)
                } else {
                    VStack {
                        IshiharaPlateView(number: plates[currentIndex].0)
                            .padding(.bottom)
                        
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
        let tritanopiaAnswer = plates[currentIndex].3
        
        if userInput == normalAnswer {
            return
        } else if userInput == protanopiaAnswer {
            protanopiaCount += 1
        } else if userInput == deuteranopiaAnswer {
            deuteranopiaCount += 1
        } else if userInput == tritanopiaAnswer {
            tritanopiaCount += 1
        }
    }
    
    private func moveToNextQuestion() {
        userInput = ""
        currentIndex += 1
    }
    
    private func detectDeficiency() {
        let maxCount = max(protanopiaCount, deuteranopiaCount, tritanopiaCount)
        
        switch maxCount {
        case protanopiaCount where maxCount > 0:
            colorBlindnessType = "Protanopia"
            finalMessage = """
            Diagnosis: Protanopia (Red-Blind)
            
            You may have difficulty distinguishing red shades. Reds may appear brown, beige, or gray.
            """
        case deuteranopiaCount where maxCount > 0:
            colorBlindnessType = "Deuteranopia"
            finalMessage = """
            Diagnosis: Deuteranopia (Green-Blind)
            
            You may struggle to differentiate green from red. Greens may appear more yellow or beige.
            """
        case tritanopiaCount where maxCount > 0:
            colorBlindnessType = "Tritanopia"
            finalMessage = """
            Diagnosis: Tritanopia (Blue-Blind)
            
            Blues may appear green, and you may struggle to tell purple from pink.
            """
        default:
            colorBlindnessType = "Normal"
            finalMessage = """
            Diagnosis: Normal Color Vision
            
            You have passed the Ishihara test, indicating no major color vision deficiencies.
            """
        }
    }
}

// MARK: - Result View
struct ResultView: View {
    let finalMessage: String

    var body: some View {
        VStack {
            Text("Test Results")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            Text(finalMessage)
                .padding()
                .multilineTextAlignment(.center)

            NavigationLink(destination: IshiharaTestView().navigationBarBackButtonHidden(true)) {
                Text("Restart Test")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .navigationBarBackButtonHidden(true)
    }
}
