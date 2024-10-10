import SwiftUI

struct PasswordStrengthView: View {
    var strength: PasswordStrength
    
    var body: some View {
        HStack {
            Text("Forza Password: \(strength.rawValue)")
                .font(.caption)
                .foregroundColor(color)
            Spacer()
            Rectangle()
                .frame(width: 100, height: 5)
                .foregroundColor(color)
                .cornerRadius(2.5)
        }
    }
    
    private var color: Color {
        switch strength {
        case .weak:
            return .red
        case .medium:
            return .yellow
        case .strong:
            return .green
        case .veryWeak:
            return .black
        case .veryStrong:
            return .mint
        }
    }
}
