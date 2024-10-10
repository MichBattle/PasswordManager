import SwiftUI

struct AddOtherView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var store: PasswordStore
    
    @State private var name = ""
    @State private var password = ""
    @State private var showPasswordField = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Dettagli")) {
                    TextField("Nome", text: $name)
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
            .navigationTitle("Aggiungi Altro")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Salva") {
                        let newOther = OtherPassword(name: name, password: password)
                        store.otherPasswords.append(newOther)
                        store.saveAll()
                        presentationMode.wrappedValue.dismiss()
                    }
                    .disabled(name.isEmpty || password.isEmpty)
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
