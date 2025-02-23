import SwiftUI

@main
struct MyApp: App {
    init() {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
            UINavigationBar.appearance().tintColor = UIColor.blue
        }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
