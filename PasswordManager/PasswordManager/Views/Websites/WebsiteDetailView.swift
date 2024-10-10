import SwiftUI

struct WebsiteDetailView: View {
    @Binding var website: WebsitePassword
    @EnvironmentObject var store: PasswordStore
    @Environment(\.presentationMode) var presentationMode
    @State private var isEditing = false
    @State private var showingSaveAlert = false
    @State private var showPassword = false
    
    var passwordStrength: PasswordStrength {
        PasswordEvaluator.evaluateStrength(of: website.password)
    }
    
    var body: some View {
        Form {
            Section(header: Text("Dettagli Sito")) {
                if isEditing {
                    TextField("Nome Sito", text: $website.siteName)
                    TextField("Username/Email", text: $website.usernameOrEmail)
                    HStack {
                        if showPassword {
                            TextField("Password", text: $website.password)
                        } else {
                            SecureField("Password", text: $website.password)
                        }
                        Button(action: {
                            showPassword.toggle()
                        }) {
                            Image(systemName: showPassword ? "eye.slash" : "eye")
                        }
                        .buttonStyle(BorderlessButtonStyle())
                        .padding(.leading, 8)
                        .accessibilityLabel(showPassword ? "Nascondi Password" : "Mostra Password")
                        
                        // Pulsante per generare la password
                        Button(action: {
                            website.password = PasswordGenerator.generate()
                        }) {
                            Image(systemName: "wand.and.stars")
                        }
                        .buttonStyle(BorderlessButtonStyle())
                        .padding(.leading, 8)
                        .accessibilityLabel("Genera Password")
                    }
                    HStack {
                        Text("Forza Password")
                        Spacer()
                        Text(passwordStrength.rawValue)
                            .foregroundColor(passwordStrength.color)
                            .fontWeight(.bold)
                    }
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
                        if showPassword {
                            Text(website.password)
                                .foregroundColor(.gray)
                        } else {
                            SecureField("Password", text: .constant(website.password))
                                .disabled(true)
                        }
                        Button(action: {
                            showPassword.toggle()
                        }) {
                            Image(systemName: showPassword ? "eye.slash" : "eye")
                        }
                        .buttonStyle(BorderlessButtonStyle())
                        .padding(.leading, 8)
                        .accessibilityLabel(showPassword ? "Nascondi Password" : "Mostra Password")
                    }
                    HStack {
                        Text("Forza Password")
                        Spacer()
                        Text(passwordStrength.rawValue)
                            .foregroundColor(passwordStrength.color)
                            .fontWeight(.bold)
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
