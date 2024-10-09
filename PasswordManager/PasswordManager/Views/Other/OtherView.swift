import SwiftUI

struct OtherView: View {
    @EnvironmentObject var store: PasswordStore
    @State private var searchText = ""
    @State private var showingAddSheet = false
    
    var filteredOthers: [OtherPassword] {
        if searchText.isEmpty {
            return store.otherPasswords
        } else {
            return store.otherPasswords.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach($store.otherPasswords) { $other in
                    NavigationLink(destination: OtherDetailView(other: $other)) {
                        VStack(alignment: .leading) {
                            Text(other.name)
                                .font(.headline)
                            Text(other.password)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .onDelete(perform: delete)
            }
            .navigationTitle("Altro")
            .searchable(text: $searchText, prompt: "Cerca")
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
                AddOtherView()
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        store.otherPasswords.remove(atOffsets: offsets)
        store.saveAll()
    }
}
