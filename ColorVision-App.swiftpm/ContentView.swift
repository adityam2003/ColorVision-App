import SwiftUI

struct ContentView: View {
    @AppStorage("colorBlindnessType") private var colorBlindnessType: String?
    @AppStorage("testTaken") private var testTaken: Bool = false
    @AppStorage("arFirstTime") private var arFirstTime: Bool = true
    @AppStorage("ciFirstTime") private var ciFirstTime: Bool = true
    @State private var showAlert = false
    @State private var navigateToAR = false
    @State private var showAlertCI = false
    @State private var navigateToCI = false

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
                                
                                ZStack {
                                    Button(action: {
                                        if arFirstTime {
                                            showAlert = true
                                        } else {
                                            navigateToAR = true
                                        }
                                    }) {
                                        featureButton(title: "AR Color Identifier", icon: "arkit", color: .purple)
                                    }
                                    .alert(isPresented: $showAlert) {
                                        Alert(
                                            title: Text("Important Information"),
                                            message: Text("The AR color identifier is limited to detecting colors that are affected by the type of color blindness and may give incorrect results for others. To get more info click on the info icon"),
                                            dismissButton: .default(Text("Continue"), action: {
                                                arFirstTime = false
                                                navigateToAR = true
                                            })
                                        )
                                    }
                                    
                                    NavigationLink(destination: ARViewContainer(), isActive: $navigateToAR) {
                                        EmptyView()
                                    }
                                    .hidden()
                                }
                                
                                if testTaken, let blindnessType = colorBlindnessType, blindnessType != "Normal" {
                                    
                                    ZStack {
                                        Button(action: {
                                            if ciFirstTime {
                                                showAlertCI = true
                                            } else {
                                                navigateToCI = true
                                            }
                                        }) {
                                            featureButton(title: "Photo-Based Color Identification", icon: "photo", color: .pink)
                                        }
                                        .alert(isPresented: $showAlertCI) {
                                            Alert(
                                                title: Text("Important Information"),
                                                message: Text("For best results, use Photo-Based Color Identification on simple images with clear, distinct colors."),
                                                dismissButton: .default(Text("Continue"), action: {
                                                    ciFirstTime = false
                                                    navigateToCI = true
                                                })
                                            )
                                        }
                                        
                                        NavigationLink(destination: PhotoColorIdentifierView(), isActive: $navigateToCI) {
                                            EmptyView()
                                        }
                                        .hidden()
                                    }
                                    
                                    //                                NavigationLink(destination: PhotoColorIdentifierView()) {
                                    //                                    featureButton(title: "Photo-Based Color Identification", icon: "photo", color: .pink)
                                    //
                                    //                                }
                                    
                                    
                                }}
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

