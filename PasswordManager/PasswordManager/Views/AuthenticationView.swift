import SwiftUI
import LocalAuthentication

struct AuthenticationView: View {
    @Binding var isUnlocked: Bool
    @Binding var showErrorAlert: Bool
    @Binding var errorMessage: String
    
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
        var authError: NSError?
        let reason = "Accedi per gestire le tue password"
        
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &authError) {
            print("Il dispositivo supporta l'autenticazione.")
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, evaluateError in
                DispatchQueue.main.async {
                    if success {
                        print("Autenticazione riuscita.")
                        isUnlocked = true
                    } else {
                        // Autenticazione fallita, mostra il messaggio di errore
                        errorMessage = evaluateError?.localizedDescription ?? "Autenticazione fallita."
                        showErrorAlert = true
                        print("Autenticazione fallita: \(errorMessage)")
                    }
                }
            }
        } else {
            // L'autenticazione non è disponibile, mostra il messaggio di errore
            errorMessage = authError?.localizedDescription ?? "L'autenticazione biometrica non è disponibile."
            showErrorAlert = true
            print("Autenticazione biometrica non disponibile: \(errorMessage)")
        }
    }
}
