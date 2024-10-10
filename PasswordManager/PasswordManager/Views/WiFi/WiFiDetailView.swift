import SwiftUI

struct WiFiDetailView: View {
    @Binding var wifi: WiFiPassword
    @EnvironmentObject var store: PasswordStore
    @Environment(\.presentationMode) var presentationMode
    @State private var isEditing = false
    @State private var showingSaveAlert = false
    @State private var showPassword = false
    
    var passwordStrength: PasswordStrength {
        PasswordEvaluator.evaluateStrength(of: wifi.password)
    }
    
    var body: some View {
        Form {
            Section(header: Text("Dettagli WiFi")) {
                if isEditing {
                    TextField("Nome Rete", text: $wifi.networkName)
                    HStack {
                        if showPassword {
                            TextField("Password", text: $wifi.password)
                        } else {
                            SecureField("Password", text: $wifi.password)
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
                            wifi.password = PasswordGenerator.generate()
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
                        if showPassword {
                            Text(wifi.password)
                                .foregroundColor(.gray)
                        } else {
                            SecureField("Password", text: .constant(wifi.password))
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
