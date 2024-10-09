import SwiftUI

struct WiFiView: View {
    @EnvironmentObject var store: PasswordStore
    @State private var searchText = ""
    @State private var showingAddSheet = false
    
    var filteredWiFi: [WiFiPassword] {
        if searchText.isEmpty {
            return store.wifiPasswords
        } else {
            return store.wifiPasswords.filter { $0.networkName.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach($store.wifiPasswords) { $wifi in
                    NavigationLink(destination: WiFiDetailView(wifi: $wifi)) {
                        VStack(alignment: .leading) {
                            Text(wifi.networkName)
                                .font(.headline)
                            Text(wifi.password)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .onDelete(perform: delete)
            }
            .navigationTitle("WiFi")
            .searchable(text: $searchText, prompt: "Cerca rete")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddSheet = true }) {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddSheet) {
                AddWiFiView()
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        store.wifiPasswords.remove(atOffsets: offsets)
        store.saveAll()
    }
}
