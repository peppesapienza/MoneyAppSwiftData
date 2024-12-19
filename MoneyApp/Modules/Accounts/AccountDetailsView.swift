import SwiftUI

struct AccountDetailsView: View {
    
    @State private var isAddingNewTransaction = false
    private let account: Account
    
    init(_ account: Account) {
        self.account = account
    }
    
    var body: some View {
        List {
            
            ForEach(account.transactions) { transaction in
                transactionRow(transaction)
            }
        }
        .navigationTitle(account.name)
        .toolbar {
            Button("Add") {
                isAddingNewTransaction.toggle()
            }
        }
        .sheet(isPresented: $isAddingNewTransaction) {
            TransactionEditor(nil, account: account)
                .presentationDetents([.medium])
        }
    }
    
    private func transactionRow(_ transaction: Transaction) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(transaction.title)
                    .font(.headline)
                Text(transaction.createdAt, style: .date)
                    .font(.footnote)
            }
            Spacer()
            CurrencyText(amount: transaction.amount)
        }
        .swipeActions {
            Button("Edit") {
                
            }
            .tint(.orange)
            
            Button("Delete", role: .destructive) {
                account.transactions.remove(
                    at: account.transactions.firstIndex(of: transaction)!
                )
            }
        }
    }
}

struct CurrencyText: View {
    
    let amount: Decimal
    
    private var color: Color {
        if amount == 0 {
            .primary
        } else if amount > 0 {
            .green
        } else {
            .red
        }
    }
    
    var body: some View {
        Text(amount, format: .currency(code: "AUD"))
            .font(.subheadline)
            .fontWeight(.medium)
            .foregroundStyle(color)
            .padding(4)
            .background(color.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 4))
    }
    
}

#Preview {
    NavigationStack {
        AccountDetailsView(.revolutPreview)
    }
}
