import Foundation

struct OtherPassword: Identifiable, Codable {
    var id = UUID()
    var name: String
    var password: String
}
