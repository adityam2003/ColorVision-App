import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("ColorVision ")
                    .font(.largeTitle)
                    .bold()

                NavigationLink(destination: IshiharaTestView()) {
                    Text("🟢 Ishihara Color Blindness Test")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

//                NavigationLink(destination: ARColorIdentifierView()) {
//                    Text("📷 AR Color Identifier")
//                        .padding()
//                        .frame(maxWidth: .infinity)
//                        .background(Color.green)
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                }

                NavigationLink(destination: ColorblindSimulatorView()) {
                    Text("🎨 Colorblind Image Simulator")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
            .navigationTitle("Home")
        }
    }
}
