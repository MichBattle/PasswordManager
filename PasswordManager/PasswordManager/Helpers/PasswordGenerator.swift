import Foundation

struct PasswordGenerator {
    static func generate(length: Int = 16) -> String {
        let uppercaseLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let lowercaseLetters = "abcdefghijklmnopqrstuvwxyz"
        let numbers = "0123456789"
        let specialCharacters = "!@#$%^&*()-_=+[]{}|;:',.<>?/"
        
        let allCharacters = uppercaseLetters + lowercaseLetters + numbers + specialCharacters
        
        return String((0..<length).compactMap { _ in allCharacters.randomElement() })
    }
}
