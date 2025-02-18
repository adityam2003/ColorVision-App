import SwiftUI





struct ContentView: View {
    @AppStorage("colorBlindnessType") private var colorBlindnessType: String?
    @AppStorage("testTaken") private var testTaken: Bool = false

    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
               
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

                VStack(spacing: 15) {
                    if !testTaken || colorBlindnessType == "Normal" {
                        NavigationLink(destination: IshiharaTestView(onTestCompletion: {
                            testTaken = true
                        })) {
                            Text("Start Ishihara Test")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }

                    if testTaken, let blindnessType = colorBlindnessType, blindnessType != "Normal" {
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
                }
                .padding(.horizontal)

                Spacer()
            }
            .padding()
            .navigationTitle("Home")
        }
    }
}
