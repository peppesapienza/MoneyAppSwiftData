import Foundation
import SwiftData
import SwiftUI

struct PreviewContainer: PreviewModifier {
    static func makeSharedContext() async throws -> ModelContainer {
        do {
            let container = try ModelContainer(
                for: Account.self,
                configurations: ModelConfiguration(isStoredInMemoryOnly: true)
            )
            
            container.mainContext.insert(Account.revolutPreview)
            container.mainContext.insert(Account.americanExpressPreview)
            
            return container
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func body(content: Content, context: ModelContainer) -> some View {
        content
            .modelContainer(context)
    }
}
