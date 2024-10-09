import SwiftUI

struct AddWebsiteView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var store: PasswordStore
    
    @State private var siteName = ""
    @State private var usernameOrEmail = ""
    @State private var password = ""
    @State private var url = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Dettagli Sito")) {
                    TextField("Nome Sito", text: $siteName)
                    TextField("Username/Email", text: $usernameOrEmail)
                    SecureField("Password", text: $password)
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
