import SwiftUI

struct TransactionEditor: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String = ""
    @State private var amount: Decimal = 0
    @State private var date: Date = .now
    
    private let transaction: Transaction?
    private let account: Account
    
    init(_ transaction: Transaction?, account: Account) {
        self.transaction = transaction
        self.account = account
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Transaction Name", text: $title)
                HStack {
                    Text("Amount")
                    Spacer()
                    TextField("Amount", value: $amount, format: .number)
                        .frame(width: 100)
                        .multilineTextAlignment(.trailing)
                }
                DatePicker(
                    "Date",
                    selection: $date,
                    displayedComponents: .date
                )
            } header: {
                Text("Transaction Details")
            }
            
            Section {
                Button("Save") {
                    withAnimation {
                        save()
                        dismiss()
                    }
                }
                .disabled(title.isEmpty)
            }
        }
        .onAppear {
            if let transaction {
                title = transaction.title
                amount = transaction.amount
                date = transaction.createdAt
            }
        }
    }
    
    private func save() {
        if let transaction {
            transaction.title = title
            transaction.amount = amount
            transaction.createdAt = date
        } else {
            let transaction = Transaction(
                title: title,
                amount: amount,
                createdAt: date
            )
            
            account.transactions.append(transaction)
        }
    }
}

#Preview {
    TransactionEditor(nil, account: .revolutPreview)
}
