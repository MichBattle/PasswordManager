import SwiftUI
import LocalAuthentication

struct AuthenticationView: View {
    @Binding var isUnlocked: Bool
    
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "lock.shield")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding()
            Text("Autenticazione")
                .font(.largeTitle)
                .padding()
            Spacer()
            Button(action: {
                authenticate()
            }) {
                Text("Autenticati")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding([.leading, .trailing], 40)
            }
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
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
