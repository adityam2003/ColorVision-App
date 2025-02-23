import SwiftUI

struct ContentView: View {
    @AppStorage("colorBlindnessType") private var colorBlindnessType: String?
    @AppStorage("testTaken") private var testTaken: Bool = false
    @AppStorage("arFirstTime") private var arFirstTime: Bool = true
    @AppStorage("ciFirstTime") private var ciFirstTime: Bool = true
    @State private var showAlert = false
    @State private var navigateToAR = false
    @State private var showInfoAlert = false
    @State private var showAlertCI = false
    @State private var navigateToCI = false
    @State private var showDetectedConditionSheet = false

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.blue.opacity(0.3)]),
                               startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                    .onAppear() {
                        testTaken = true
                        colorBlindnessType = "Protanopia"
                    }

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
                            HStack {
                                Text("Detected Condition")
                                    .font(.headline)
                                    .foregroundColor(.gray)
                                
                                Spacer()
                                
                                Button(action: {
                                    showDetectedConditionSheet = true
                                }){
                                    Image(systemName: "info.circle")
                                        .font(.system(size: 14))
                                        .foregroundColor(.gray)
                                }
                                .buttonStyle(PlainButtonStyle())
                                .padding(.trailing, 4)
                            }
                            
                            Text(colorBlindnessType ?? "No condition detected yet")
                                .font(.title3)
                                .bold()
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(radius: 4)
                        .padding(.horizontal)
                        .sheet(isPresented: $showDetectedConditionSheet) {
                            DetectedConditionView(isPresented: $showDetectedConditionSheet)
                            
                        }

                        Spacer()
                        Spacer()

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
                                            message: Text("""
The AR color identifier is limited to detecting colors that are affected by the type of color blindness and may give incorrect results for others.For more info click on the info.\n
 **For best results,** 
•use on simple objects 
•Ensure clear, distinct colors.
"""),
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

struct DetectedConditionView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Detected Condition")
                .font(.title3).bold()
                .padding(.top)
            
            VStack(alignment: .leading, spacing: 8) {
                ScrollView{
                    Text("**PROTANOPIA (RED-BLINDNESS)**")
                    Text("• Reds appear much darker or blackish\n• Oranges look yellowish/brownish\n• Purples look more blue")
                    
                    Text("**DEUTERANOPIA (GREEN-BLINDNESS)**")
                    Text("• Greens appear as yellow or beige\n• Reds are dull but visible (unlike protanopia)")
                    
                    Divider().padding(.vertical, 5)
                    
                    Text("**AR-Color Identifier Colors Detection**").font(.headline)
                    Text("**For best results, use on simple objects with clear, distinct colors.**").font(.subheadline)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("🔴 **RED COLORS**")
                        Text("• Red\n• Dark Red\n• Light Red\n• Maroon\n• Yellow-Green")
                        
                        Text("🟢 **GREEN COLORS**")
                        Text("• Green\n• Dark Green\n• Olive")
                        
                        Text("🟡 **ORANGE/YELLOW**")
                        Text("• Orange\n• Yellow\n• Golden Yellow")
                        
                        Text("🔵 **BLUE COLORS**")
                        Text("• Blue\n• Dark Blue\n• Light Blue")
                        
                        Text("🟣 **OTHER COLORS**")
                        Text("• Cyan\n• Teal\n• Magenta\n• Pink\n• Purple\n• Brown")
                        
                        Text("⚫ **NEUTRAL COLORS**")
                        Text("• Black\n• White\n• Gray\n• Dark Gray\n• Light Gray\n• Dark Brown\n• Beige")
                    }
                    .padding(.leading, 10)
                }}
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            
            Button(action: {
                isPresented = false
            }) {
                Text("OK")
                    .font(.headline)
                    .frame(maxWidth: .infinity, minHeight: 44)  
                    .contentShape(Rectangle())
            }
            .padding()
            .background(Color.blue.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, minHeight: 400)
        .background(LinearGradient(colors: [Color.blue.opacity(0.2), Color.white], startPoint: .top, endPoint: .bottom))
        .cornerRadius(20)
        .padding()
    }
}
