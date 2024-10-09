import SwiftUI

struct AddOtherView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var store: PasswordStore
    
    @State private var name = ""
    @State private var password = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Dettagli")) {
                    TextField("Nome", text: $name)
                    SecureField("Password", text: $password)
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
