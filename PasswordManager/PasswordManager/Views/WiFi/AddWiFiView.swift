import SwiftUI

struct AddWiFiView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var store: PasswordStore
    
    @State private var networkName = ""
    @State private var password = ""
    @State private var showPasswordField = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Dettagli WiFi")) {
                    TextField("Nome Rete", text: $networkName)
                    HStack {
                        if showPasswordField {
                            TextField("Password", text: $password)
                        } else {
                            SecureField("Password", text: $password)
                        }
                        Button(action: {
                            showPasswordField.toggle()
                        }) {
                            Image(systemName: showPasswordField ? "eye.slash" : "eye")
                        }
                        .buttonStyle(BorderlessButtonStyle())
                        .padding(.leading, 8)
                        .accessibilityLabel(showPasswordField ? "Nascondi Password" : "Mostra Password")
                        
                        // Pulsante per generare la password
                        Button(action: {
                            password = PasswordGenerator.generate()
                        }) {
                            Image(systemName: "wand.and.stars")
                        }
                        .buttonStyle(BorderlessButtonStyle())
                        .padding(.leading, 8)
                        .accessibilityLabel("Genera Password")
                    }
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
