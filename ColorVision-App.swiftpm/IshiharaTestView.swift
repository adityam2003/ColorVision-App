//
//  File.swift
//  ColorVision-App
//
//  Created by Aditya on 06/02/25.
//




import SwiftUI
//struct IshiharaPalette {
//    static let backgroundColors: [Color] = [
//        Color(red: 100/255, green: 200/255, blue: 100/255),
//        Color(red: 110/255, green: 180/255, blue: 110/255),
//        Color(red: 90/255, green: 210/255, blue: 120/255)
//    ]
//    
//    static let numberColors: [Color] = [
//        Color(red: 200/255, green: 100/255, blue: 100/255),
//        Color(red: 190/255, green: 90/255, blue: 90/255),
//        Color(red: 220/255, green: 120/255, blue: 120/255)
//    ]
//}
//
//// MARK: - Ishihara Plate Generator View
//struct IshiharaPlateView: View {
//    let number: String
//    let dotCount = 1000
//    
//    var body: some View {
//        ZStack {
//            ForEach(0..<dotCount, id: \ .self) { _ in
//                Circle()
//                    .fill(Bool.random() ? IshiharaPalette.backgroundColors.randomElement()! : IshiharaPalette.numberColors.randomElement()!)
//                    .frame(width: CGFloat.random(in: 5...15), height: CGFloat.random(in: 5...15))
//                    .position(randomPosition())
//            }
//            Text(number)
//                .font(.system(size: 80, weight: .bold))
//                .foregroundColor(IshiharaPalette.numberColors.randomElement()!)
//                .opacity(0.5)
//        }
//        .frame(width: 300, height: 300)
//    }
//    
//    private func randomPosition() -> CGPoint {
//        return CGPoint(x: CGFloat.random(in: 0...300), y: CGFloat.random(in: 0...300))
//    }
//}



// MARK: - Updated Ishihara Test View
struct IshiharaTestView: View {
    @State private var userInput = ""
    @State private var currentIndex = 0
    @State private var protanopiaCount = 0
    @State private var deuteranopiaCount = 0
    @State private var showFinalResult = false
    @State private var finalMessage = ""
    @State private var check = 1
    
    @AppStorage("colorBlindnessType") private var colorBlindnessType: String = "Normal"
    
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
        
        // MARK: - Hello
        ("26","6","2"),
        ("42","2","4"),
        ("35","5","3"),
        ("96","6","9")
        
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                if showFinalResult {
                    ResultView(finalMessage: finalMessage)
                } else {
                    VStack {
                        //                        IshiharaPlateView(number: plates[currentIndex].0)
                        //                            .padding(.bottom)
                        
                        TextField("Enter the number\(check)", text: $userInput)
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
        self.check += 1
        
        let normalAnswer = plates[currentIndex].0
        let protanopiaAnswer = plates[currentIndex].1
        let deuteranopiaAnswer = plates[currentIndex].2
        
        if userInput == normalAnswer {
            return
        } else if userInput == protanopiaAnswer && userInput == deuteranopiaAnswer  {
            protanopiaCount += 1
            deuteranopiaCount += 1
        }else if userInput == protanopiaAnswer {
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
        let significantThreshold = 4  // Clinical studies suggest 4+ errors indicate deficiency
        
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
        } else if protanopiaCount >= 2  {
            colorBlindnessType = "Possible Deficiency-(Protanopia)"
            finalMessage = """
            Diagnosis: Possible Color Deficiency
            
            You made some errors that may indicate mild color vision issues(Protanopia).
            This test is not a medical diagnosis—consider seeing a professional.
            """
        }else if deuteranopiaCount >= 2 {
            colorBlindnessType = "Possible Deficiency-(Deuteranopia)"
            finalMessage = """
            Diagnosis: Possible Color Deficiency
            
            You made some errors that may indicate mild color vision issues(Deuteranopia).
            This test is not a medical diagnosis—consider seeing a professional.
            """
        } else {
            colorBlindnessType = "Normal"
            finalMessage = """
            Diagnosis: Normal Color Vision
            
            Your responses suggest no significant color vision deficiency.
            """
        }
    }}


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
