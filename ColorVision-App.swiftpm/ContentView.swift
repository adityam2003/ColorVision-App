import SwiftUI



import SwiftUI

//struct ContentView: View {
//    
//    @AppStorage("colorBlindnessType") private var colorBlindnessType: String?
//
//    var body: some View {
//        NavigationView {
//            VStack(spacing: 10) {
//                VStack {
//                    Text("Detected Condition")
//                        .font(.headline)
//                        .foregroundColor(.white)
//                    
//                    if let blindnessType = colorBlindnessType {
//                        Text(blindnessType)
//                            .font(.title)
//                            .bold()
//                            .foregroundColor(.white)
//                    } else {
//                        Text("No condition detected yet")
//                            .font(.title2)
//                            .foregroundColor(.white)
//                    }
//                }
//                .padding()
//                .frame(maxWidth: .infinity)
//                .background(Color.blue)
//                .cornerRadius(12)
//                .padding(.horizontal)
//                .padding(.top,20)
//
//                Spacer()
//                
//                VStack(spacing: 15) {
//                    
//                    if colorBlindnessType == nil {
//                        NavigationLink(destination: IshiharaTestView()) {
//                            Text(" Start Ishihara Test")
//                                .padding()
//                                .frame(maxWidth: .infinity)
//                                .background(Color.green)
//                                .foregroundColor(.white)
//                                .cornerRadius(10)
//                        }
//                    }
//                    
//                    NavigationLink(destination: IshiharaTestView()) {
//                        Text("Ishihara Color Blindness Test")
//                            .padding()
//                            .frame(maxWidth: .infinity)
//                            .background(Color(red: 224/255, green: 220/255, blue: 211/255))
//                            .foregroundColor(.black)
//                            .cornerRadius(10)
//                    }
//                    
//                    NavigationLink(destination: ARColorIdentifierView()) {
//                        Text("AR Color Identifier")
//                            .padding()
//                            .frame(maxWidth: .infinity)
//                            .background(Color(red: 224/255, green: 220/255, blue: 211/255))
//                            .foregroundColor(.black)
//                            .cornerRadius(10)
//                    }
//                    
//                    NavigationLink(destination: ColorblindSimulatorView()) {
//                        Text("Colorblind Image Simulator")
//                            .padding()
//                            .frame(maxWidth: .infinity)
//                            .background(Color(red: 224/255, green: 220/255, blue: 211/255))
//                            .foregroundColor(.black)
//                            .cornerRadius(10)
//                    }
//                }
//                
//                .padding(.horizontal)
//
//                Spacer()
//                
//            }
//            .padding()
//            .navigationTitle("Home")
//        }
//    }
//}


//
//struct ContentView: View {
//    @State private var colorBlindnessType: String? = "Protanopia" // Replace with actual detection logic
//    
//    var body: some View {
//        NavigationView {
//            VStack(alignment: .leading, spacing: 20) { // Main VStack with spacing control
//                
//
//                
//                // Detected Condition Box
//                VStack {
//                    Text("Detected Condition")
//                        .font(.headline)
//                        .foregroundColor(.white)
//                    
//                    if let blindnessType = colorBlindnessType {
//                        Text(blindnessType)
//                            .font(.title)
//                            .bold()
//                            .foregroundColor(.white)
//                    } else {
//                        Text("No condition detected yet")
//                            .font(.title2)
//                            .foregroundColor(.white)
//                    }
//                }
//                .padding()
//                .frame(maxWidth: .infinity)
//                .background(Color.blue)
//                .cornerRadius(12)
//                .padding(.horizontal)
//                .padding(.top, 15)  // Moves detected result down
//                
//                // Buttons Section
//                VStack(spacing: 10) { // Adjusts space between buttons
//                    NavigationLink(destination: IshiharaTestView()) {
//                        Text("Ishihara Color Blindness Test")
//                            .padding()
//                            .frame(maxWidth: .infinity)
//                            .background(Color(red: 224/255, green: 220/255, blue: 211/255))
//                            .foregroundColor(.black)
//                            .cornerRadius(10)
//                    }
//
//                    NavigationLink(destination: ARColorIdentifierView()) {
//                        Text("AR Color Identifier")
//                            .padding()
//                            .frame(maxWidth: .infinity)
//                            .background(Color(red: 224/255, green: 220/255, blue: 211/255))
//                            .foregroundColor(.black)
//                            .cornerRadius(10)
//                    }
//
//                    NavigationLink(destination: ColorblindSimulatorView()) {
//                        Text("Colorblind Image Simulator")
//                            .padding()
//                            .frame(maxWidth: .infinity)
//                            .background(Color(red: 224/255, green: 220/255, blue: 211/255))
//                            .foregroundColor(.black)
//                            .cornerRadius(10)
//                    }
//                }
//                .padding(.horizontal)
//                .padding(.top, 40)  // Moves buttons downward
//                
//                Spacer() // Pushes content to the top and allows scrolling if needed
//            }
//            .padding()
//            .navigationTitle("Home")
//        }
//    }
//}

struct ContentView: View {
@AppStorage("colorBlindnessType") private var colorBlindnessType: String?

var body: some View {
    NavigationView {
        VStack(spacing: 10) {
            // Condition Display Section
            VStack {
                Text("Detected Condition")
                    .font(.headline)
                    .foregroundColor(.white)
                
                if let blindnessType = colorBlindnessType {
                    Text(blindnessType)
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                } else {
                    Text("No condition detected yet")
                        .font(.title2)
                        .foregroundColor(.white)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .cornerRadius(12)
            .padding(.horizontal)
            .padding(.top, 20)

            Spacer()
            
            // Navigation Links Section
            VStack(spacing: 15) {
                // Show "Start Ishihara Test" only if no condition is detected
                if colorBlindnessType == nil {
                    NavigationLink(destination: IshiharaTestView()) {
                        Text("Start Ishihara Test")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                
                // Other Navigation Links
                NavigationLink(destination: IshiharaTestView()) {
                    Text("Ishihara Color Blindness Test")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(red: 224/255, green: 220/255, blue: 211/255))
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }

                NavigationLink(destination: ARColorIdentifierView()) {
                    Text("AR Color Identifier")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(red: 224/255, green: 220/255, blue: 211/255))
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }

                NavigationLink(destination: ColorRemapView()) {
                    Text("Color Remapping")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(red: 224/255, green: 220/255, blue: 211/255))
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding()
        .navigationTitle("Home")
    }
}
}
