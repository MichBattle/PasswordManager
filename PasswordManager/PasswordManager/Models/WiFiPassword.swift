import Foundation

struct WiFiPassword: Identifiable, Codable {
    var id = UUID()
    var networkName: String
    var password: String
}
