import SwiftUI

struct OtherDetailView: View {
    @Binding var other: OtherPassword
    @EnvironmentObject var store: PasswordStore
    @Environment(\.presentationMode) var presentationMode
    @State private var isEditing = false
    @State private var showingSaveAlert = false
    
    var body: some View {
        Form {
            Section(header: Text("Dettagli")) {
                if isEditing {
                    TextField("Nome", text: $other.name)
                    SecureField("Password", text: $other.password)
                } else {
                    HStack {
                        Text("Nome")
                        Spacer()
                        Text(other.name)
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Text("Password")
                        Spacer()
                        SecureField("Password", text: .constant(other.password))
                            .disabled(true)
                    }
                }
            }
        }
        .navigationTitle(other.name)
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
