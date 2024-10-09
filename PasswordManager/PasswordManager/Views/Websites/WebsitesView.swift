import SwiftUI

struct WebsitesView: View {
    @EnvironmentObject var store: PasswordStore
    @State private var searchText = ""
    @State private var showingAddSheet = false
    
    var filteredWebsites: [WebsitePassword] {
        if searchText.isEmpty {
            return store.websitePasswords
        } else {
            return store.websitePasswords.filter { $0.siteName.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach($store.websitePasswords) { $website in
                    NavigationLink(destination: WebsiteDetailView(website: $website)) {
                        VStack(alignment: .leading) {
                            Text(website.siteName)
                                .font(.headline)
                            Text(website.usernameOrEmail)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .onDelete(perform: delete)
            }
            .navigationTitle("Siti Web")
            .searchable(text: $searchText, prompt: "Cerca sito")
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
                AddWebsiteView()
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        store.websitePasswords.remove(atOffsets: offsets)
        store.saveAll()
    }
}
