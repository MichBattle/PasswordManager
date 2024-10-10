import SwiftUI

struct OtherDetailView: View {
    @Binding var other: OtherPassword
    @EnvironmentObject var store: PasswordStore
    @Environment(\.presentationMode) var presentationMode
    @State private var isEditing = false
    @State private var showingSaveAlert = false
    @State private var showPassword = false
    
    var passwordStrength: PasswordStrength {
        PasswordEvaluator.evaluateStrength(of: other.password)
    }
    
    var body: some View {
        Form {
            Section(header: Text("Dettagli")) {
                if isEditing {
                    TextField("Nome", text: $other.name)
                    HStack {
                        if showPassword {
                            TextField("Password", text: $other.password)
                        } else {
                            SecureField("Password", text: $other.password)
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
                            other.password = PasswordGenerator.generate()
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
                        Text("Nome")
                        Spacer()
                        Text(other.name)
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Text("Password")
                        Spacer()
                        if showPassword {
                            Text(other.password)
                                .foregroundColor(.gray)
                        } else {
                            SecureField("Password", text: .constant(other.password))
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
