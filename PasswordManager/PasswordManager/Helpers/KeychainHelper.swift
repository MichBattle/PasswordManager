import Security
import Foundation

class KeychainHelper {
    static let standard = KeychainHelper()
    
    private init() {}
    
    func save(_ data: Data, service: String, account: String) {
        // Crea una query per il salvataggio
        let query: [String: Any] = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrService as String : service,
            kSecAttrAccount as String : account,
            kSecValueData as String   : data
        ]
        
        // Elimina eventuali elementi duplicati
        SecItemDelete(query as CFDictionary)
        
        // Aggiungi il nuovo elemento
        let status = SecItemAdd(query as CFDictionary, nil)
        if status != errSecSuccess {
            print("Errore nel salvataggio su Keychain: \(status)")
        }
    }
    
    func read(service: String, account: String) -> Data? {
        // Crea una query per la lettura
        let query: [String: Any] = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrService as String : service,
            kSecAttrAccount as String : account,
            kSecReturnData as String  : true,
            kSecMatchLimit as String  : kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject? = nil
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == errSecSuccess {
            return dataTypeRef as? Data
        } else {
            print("Errore nella lettura da Keychain: \(status)")
            return nil
        }
    }
    
    func delete(service: String, account: String) {
        // Crea una query per la cancellazione
        let query: [String: Any] = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrService as String : service,
            kSecAttrAccount as String : account
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        if status != errSecSuccess {
            print("Errore nella cancellazione da Keychain: \(status)")
        }
    }
}
