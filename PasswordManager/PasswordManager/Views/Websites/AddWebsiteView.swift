import SwiftUI

struct AddWebsiteView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var store: PasswordStore
    
    @State private var siteName = ""
    @State private var usernameOrEmail = ""
    @State private var password = ""
    @State private var url = ""
    @State private var showPasswordField = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Dettagli Sito")) {
                    TextField("Nome Sito", text: $siteName)
                    TextField("Username/Email", text: $usernameOrEmail)
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
                    TextField("URL", text: $url)
                        .keyboardType(.URL)
                        .autocapitalization(.none)
                }
            }
            .navigationTitle("Aggiungi Sito")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Salva") {
                        let newWebsite = WebsitePassword(
                            siteName: siteName,
                            usernameOrEmail: usernameOrEmail,
                            password: password,
                            url: url
                        )
                        store.websitePasswords.append(newWebsite)
                        store.saveAll()
                        presentationMode.wrappedValue.dismiss()
                    }
                    .disabled(siteName.isEmpty || usernameOrEmail.isEmpty || password.isEmpty || url.isEmpty)
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
