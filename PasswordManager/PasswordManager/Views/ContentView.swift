import SwiftUI
import LocalAuthentication

struct ContentView: View {
    @State private var isUnlocked = false
    
    var body: some View {
        Group {
            if isUnlocked {
                MainView()
            } else {
                AuthenticationView(isUnlocked: $isUnlocked)
            }
        }
        .onAppear(perform: authenticate)
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        // Verifica se l'autenticazione biometrica è disponibile
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            let reason = "Accedi per gestire le tue password"
            
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        isUnlocked = true
                    } else {
                        // Autenticazione fallita
                        // Puoi gestire l'errore qui se necessario
                    }
                }
            }
        } else {
            // Autenticazione non disponibile
            // Puoi gestire l'errore qui se necessario
        }
    }
}
