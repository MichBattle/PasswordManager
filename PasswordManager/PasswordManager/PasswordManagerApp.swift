import SwiftUI

@main
struct PasswordManagerApp: App {
    @StateObject private var store = PasswordStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
    }
}
