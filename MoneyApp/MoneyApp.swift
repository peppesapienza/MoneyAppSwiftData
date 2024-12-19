import SwiftUI
import SwiftData

@main
struct MoneyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Account.self)
        }
    }
}
