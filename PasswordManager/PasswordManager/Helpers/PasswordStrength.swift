import SwiftUI

enum PasswordStrength: String {
    case veryWeak = "Molto Debole"
    case weak = "Debole"
    case medium = "Media"
    case strong = "Forte"
    case veryStrong = "Molto Forte"
    
    var color: Color {
        switch self {
        case .veryWeak:
            return .red
        case .weak:
            return .orange
        case .medium:
            return .yellow
        case .strong:
            return .green
        case .veryStrong:
            return .blue
        }
    }
}
