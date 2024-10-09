import Foundation

struct WebsitePassword: Identifiable, Codable {
    var id = UUID()
    var siteName: String
    var usernameOrEmail: String
    var password: String
    var url: String
}
