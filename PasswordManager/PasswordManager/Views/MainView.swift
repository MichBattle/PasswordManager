import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            WiFiView()
                .tabItem {
                    Label("WiFi", systemImage: "wifi")
                }
            
            WebsitesView()
                .tabItem {
                    Label("Siti Web", systemImage: "globe")
                }
            
            OthersView()
                .tabItem {
                    Label("Altro", systemImage: "lock.shield")
                }
        }
    }
}
