import SwiftUI

struct AddWiFiView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var store: PasswordStore
    
    @State private var networkName = ""
    @State private var password = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Dettagli WiFi")) {
                    TextField("Nome Rete", text: $networkName)
                    SecureField("Password", text: $password)
                }
            }
            .navigationTitle("Aggiungi WiFi")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Salva") {
                        let newWiFi = WiFiPassword(networkName: networkName, password: password)
                        store.wifiPasswords.append(newWiFi)
                        store.saveAll()
                        presentationMode.wrappedValue.dismiss()
                    }
                    .disabled(networkName.isEmpty || password.isEmpty)
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Annulla") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}
