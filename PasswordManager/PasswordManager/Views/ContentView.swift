import SwiftUI

struct ContentView: View {
    @State private var isUnlocked = false
    @State private var showErrorAlert = false
    @State private var errorMessage = ""
    
    var body: some View {
        Group {
            if isUnlocked {
                MainView()
            } else {
                AuthenticationView(isUnlocked: $isUnlocked, showErrorAlert: $showErrorAlert, errorMessage: $errorMessage)
            }
        }
        .alert(isPresented: $showErrorAlert) {
            Alert(title: Text("Errore di Autenticazione"),
                  message: Text(errorMessage),
                  dismissButton: .default(Text("OK")))
        }
    }
}
