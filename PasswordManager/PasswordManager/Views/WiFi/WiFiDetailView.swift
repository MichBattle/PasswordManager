import SwiftUI

struct WiFiDetailView: View {
    @Binding var wifi: WiFiPassword
    @EnvironmentObject var store: PasswordStore
    @Environment(\.presentationMode) var presentationMode
    @State private var isEditing = false
    @State private var showingSaveAlert = false
    
    var body: some View {
        Form {
            Section(header: Text("Dettagli WiFi")) {
                if isEditing {
                    TextField("Nome Rete", text: $wifi.networkName)
                    SecureField("Password", text: $wifi.password)
                } else {
                    HStack {
                        Text("Nome Rete")
                        Spacer()
                        Text(wifi.networkName)
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Text("Password")
                        Spacer()
                        SecureField("Password", text: .constant(wifi.password))
                            .disabled(true)
                    }
                }
            }
        }
        .navigationTitle(wifi.networkName)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(isEditing ? "Salva" : "Modifica") {
                    if isEditing {
                        // Salva le modifiche
                        store.saveAll()
                        showingSaveAlert = true
                    }
                    isEditing.toggle()
                }
            }
        }
        .alert(isPresented: $showingSaveAlert) {
            Alert(title: Text("Salvataggio"),
                  message: Text("Le modifiche sono state salvate con successo."),
                  dismissButton: .default(Text("OK")))
        }
    }
}
