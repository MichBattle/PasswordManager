import SwiftUI
import Combine

class PasswordStore: ObservableObject {
    @Published var wifiPasswords: [WiFiPassword] = []
    @Published var websitePasswords: [WebsitePassword] = []
    @Published var otherPasswords: [OtherPassword] = []
    
    private let keychain = KeychainHelper.standard
    
    private let wifiService = "wifiPasswords"
    private let websiteService = "websitePasswords"
    private let otherService = "otherPasswords"
    private let account = "user" // Puoi personalizzare l'account se necessario
    
    init() {
        loadWiFiPasswords()
        loadWebsitePasswords()
        loadOtherPasswords()
    }
    
    // MARK: - WiFi Passwords
    func saveWiFiPasswords() {
        if let data = try? JSONEncoder().encode(wifiPasswords) {
            keychain.save(data, service: wifiService, account: account)
        }
    }
    
    func loadWiFiPasswords() {
        if let data = keychain.read(service: wifiService, account: account),
           let decoded = try? JSONDecoder().decode([WiFiPassword].self, from: data) {
            wifiPasswords = decoded
        }
    }
    
    // MARK: - Website Passwords
    func saveWebsitePasswords() {
        if let data = try? JSONEncoder().encode(websitePasswords) {
            keychain.save(data, service: websiteService, account: account)
        }
    }
    
    func loadWebsitePasswords() {
        if let data = keychain.read(service: websiteService, account: account),
           let decoded = try? JSONDecoder().decode([WebsitePassword].self, from: data) {
            websitePasswords = decoded
        }
    }
    
    // MARK: - Other Passwords
    func saveOtherPasswords() {
        if let data = try? JSONEncoder().encode(otherPasswords) {
            keychain.save(data, service: otherService, account: account)
        }
    }
    
    func loadOtherPasswords() {
        if let data = keychain.read(service: otherService, account: account),
           let decoded = try? JSONDecoder().decode([OtherPassword].self, from: data) {
            otherPasswords = decoded
        }
    }
    
    // MARK: - Save All
    func saveAll() {
        saveWiFiPasswords()
        saveWebsitePasswords()
        saveOtherPasswords()
    }
}
