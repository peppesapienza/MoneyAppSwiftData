import Foundation
import SwiftData

@Model
final class Account {
    var name: String
    var type: AccountType
    
    var transactions: [Transaction] = []
    
    var balance: Decimal {
        transactions.reduce(0) { $0 + $1.amount }
    }
        
    init(name: String, type: AccountType) {
        self.name = name
        self.type = type
    }
}

enum AccountType: String, Codable, CaseIterable {
    case checking = "Checking"
    case savings = "Savings"
    case creditCard = "Credit Card"
    case loan = "Loan"
    case investment = "Investment"
    case other = "Other"
}

// MARK: Preview

extension Account {
    static let revolutPreview: Account = {
        let account = Account(name: "Revolut", type: .checking)
        
        account.transactions = [
            Transaction(title: "Amazon Prime", amount: -100, createdAt: .now),
            Transaction(title: "Coffee", amount: -2.5, createdAt: Calendar.current.date(byAdding: .day, value: -5, to: .now)!),
            Transaction(title: "Salary", amount: 1500.0, createdAt: Calendar.current.date(byAdding: .day, value: -10, to: .now)!)
        ]
        
        return account
    }()
    
    static let americanExpressPreview: Account = {
        let account = Account(name: "American Express", type: .creditCard)
        
        account.transactions = [
            Transaction(title: "Netflix Subscription", amount: -15.99, createdAt: .now),
            Transaction(title: "Dinner", amount: -75.0, createdAt: Calendar.current.date(byAdding: .day, value: -2, to: .now)!),
            Transaction(title: "Uber Ride", amount: -20.5, createdAt: Calendar.current.date(byAdding: .day, value: -7, to: .now)!),
            Transaction(title: "Gym Membership", amount: -50.0, createdAt: Calendar.current.date(byAdding: .day, value: -15, to: .now)!)
        ]
        
        return account
    }()
}
