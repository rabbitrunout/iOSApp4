import SwiftUI
import FirebaseCore

@main
struct FirebaseGalleryAppApp: App {
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
