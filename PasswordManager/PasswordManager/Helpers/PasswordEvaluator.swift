import Foundation

struct PasswordEvaluator {
    static func evaluateStrength(of password: String) -> PasswordStrength {
        let length = password.count
        
        var strengthPoints = 0
        
        // Controlla la lunghezza
        if length >= 8 { strengthPoints += 1 }
        if length >= 12 { strengthPoints += 1 }
        if length >= 16 { strengthPoints += 1 }
        
        // Controlla la presenza di lettere maiuscole
        let uppercasePattern = ".*[A-Z]+.*"
        if NSPredicate(format:"SELF MATCHES %@", uppercasePattern).evaluate(with: password) {
            strengthPoints += 1
        }
        
        // Controlla la presenza di lettere minuscole
        let lowercasePattern = ".*[a-z]+.*"
        if NSPredicate(format:"SELF MATCHES %@", lowercasePattern).evaluate(with: password) {
            strengthPoints += 1
        }
        
        // Controlla la presenza di numeri
        let numberPattern = ".*[0-9]+.*"
        if NSPredicate(format:"SELF MATCHES %@", numberPattern).evaluate(with: password) {
            strengthPoints += 1
        }
        
        // Controlla la presenza di caratteri speciali
        let specialCharacterPattern = ".*[!@#$%^&*()-_=+\\[\\]{}|;:',.<>?]+.*"
        if NSPredicate(format:"SELF MATCHES %@", specialCharacterPattern).evaluate(with: password) {
            strengthPoints += 1
        }
        
        switch strengthPoints {
        case 0...1:
            return .veryWeak
        case 2:
            return .weak
        case 3:
            return .medium
        case 4:
            return .strong
        default:
            return .veryStrong
        }
    }
}
