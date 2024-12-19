import Foundation
import SwiftData

@Model
final class Transaction {
    var title: String
    var amount: Decimal
    var createdAt: Date
    
    init(title: String, amount: Decimal, createdAt: Date) {
        self.title = title
        self.amount = amount
        self.createdAt = createdAt
    }
}

