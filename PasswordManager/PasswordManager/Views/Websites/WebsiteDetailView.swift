import SwiftUI

struct WebsiteDetailView: View {
    @Binding var website: WebsitePassword
    @EnvironmentObject var store: PasswordStore
    @Environment(\.presentationMode) var presentationMode
    @State private var isEditing = false
    @State private var showingSaveAlert = false
    
    var body: some View {
        Form {
            Section(header: Text("Dettagli Sito")) {
                if isEditing {
                    TextField("Nome Sito", text: $website.siteName)
                    TextField("Username/Email", text: $website.usernameOrEmail)
                    SecureField("Password", text: $website.password)
                    TextField("URL", text: $website.url)
                        .keyboardType(.URL)
                        .autocapitalization(.none)
                } else {
                    HStack {
                        Text("Nome Sito")
                        Spacer()
                        Text(website.siteName)
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Text("Username/Email")
                        Spacer()
                        Text(website.usernameOrEmail)
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Text("Password")
                        Spacer()
                        SecureField("Password", text: .constant(website.password))
                            .disabled(true)
                    }
                    HStack {
                        Text("URL")
                        Spacer()
                        if let url = URL(string: website.url) {
                            Link(destination: url) {
                                Text(website.url)
                                    .foregroundColor(.blue)
                            }
                        } else {
                            Text(website.url)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
        }
        .navigationTitle(website.siteName)
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
