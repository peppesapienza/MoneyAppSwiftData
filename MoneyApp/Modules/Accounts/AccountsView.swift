import SwiftUI
import SwiftData

struct AccountsView: View {
    
    @Environment(\.modelContext) private var context
    
    @Query private var accounts: [Account]
    
    @State private var isAccountEditorOpen: Bool = false
    @State private var selectedAccount: Account?
    
    private var totalAmount: Decimal {
        accounts.reduce(0) { $0 + $1.balance }
    }
    
    var body: some View {
        NavigationStack {
            List {
                if accounts.isEmpty {
                    Text("Add an account to get started.")
                        .listRowBackground(Color.clear)
                } else {
                    balanceSection
                }
                
                ForEach(accounts) { account in
                    accountRow(account)
                }
            }
            .navigationDestination(for: Account.self, destination: { account in
                AccountDetailsView(account)
            })
            .toolbar {
                Button("Add") {
                    isAccountEditorOpen.toggle()
                }
            }
            .sheet(isPresented: $isAccountEditorOpen) {
                AccountEditor(nil)
                    .presentationDetents([.medium])
            }
            .sheet(item: $selectedAccount) { account in
                AccountEditor(account)
                    .presentationDetents([.medium])
            }
        }
    }
    
    private var balanceSection: some View {
        Section {
            HStack {
                Text("Balance")
                Spacer()
                CurrencyText(amount: totalAmount)
            }
        } header: {
            Text("Total balance")
        }
    }
    
    private func accountRow(_ account: Account) -> some View {
        NavigationLink(value: account) {
            HStack {
                Text(account.name)
                Spacer()
                CurrencyText(amount: account.balance)
            }
            .swipeActions {
                Button("Delete", role: .destructive) {
                    withAnimation {
                        delete(account)
                    }
                }
                
                Button("Edit") {
                    selectedAccount = account
                }
                .tint(.orange)
            }
        }
    }
    
    private func delete(_ account: Account) {
        context.delete(account)
    }
}

#Preview(traits: .modifier(PreviewContainer())) {
    AccountsView()
}
