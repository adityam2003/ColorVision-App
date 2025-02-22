



import SwiftUI

struct ContentView: View {
    @AppStorage("colorBlindnessType") private var colorBlindnessType: String?
    @AppStorage("testTaken") private var testTaken: Bool = false

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.blue.opacity(0.3)]),
                               startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 25) {
                        Text("Color Vision Assistant")
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                            .padding(.top, 20)

                        Image(systemName: "eye.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .foregroundColor(.white.opacity(0.9))

                        VStack(spacing: 8) {
                            Text("Detected Condition")
                                .font(.headline)
                                .foregroundColor(.gray)

                            Text(colorBlindnessType ?? "No condition detected yet")
                                .font(.title3)
                                .bold()
                                .foregroundColor(.black)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(radius: 4)
                        .padding(.horizontal)
                        Spacer()
                        Spacer()

                        // Feature Buttons
                        VStack(spacing: 15) {
                            NavigationLink(destination: IshiharaTestView(onTestCompletion: {
                                testTaken = true
                            })) {
                                featureButton(title: "Take Ishihara Test", icon: "eye", color: .blue)
                            }

                            if testTaken, let blindnessType = colorBlindnessType, blindnessType != "Normal" {
                                NavigationLink(destination: ARViewContainer()) {
                                    featureButton(title: "AR Color Identifier", icon: "arkit", color: .purple)
                                }

                                NavigationLink(destination: PhotoColorIdentifierView()) {
                                    featureButton(title: "Photo-Based Color Identification", icon: "photo", color: .pink)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.bottom, 30)
                }
            }
        }
    }

    private func featureButton(title: String, icon: String, color: Color) -> some View {
        HStack {
            Image(systemName: icon)
                .font(.headline)
                .foregroundColor(.white)
            Text(title)
                .font(.headline)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(color)
        .foregroundColor(.white)
        .cornerRadius(12)
        .shadow(radius: 3)
    }
}

