import SwiftUI

struct AccountEditor: View {
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var selectedType: AccountType = .checking
    
    private let account: Account?
    
    init(_ account: Account?) {
        self.account = account
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Account Name", text: $name)
                
                Picker("Account Type", selection: $selectedType) {
                    ForEach(AccountType.allCases, id: \.self) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
            } header: {
                Text("Account Details")
            }
            
            Section {
                Button("Save") {
                    withAnimation {
                        save()
                    }
                }
            }
        }
        .onAppear {
            if let account {
                name = account.name
                selectedType = account.type
            }
        }
    }
    
    private func save() {
        if let account {
            account.name = name
            account.type = selectedType
        } else {
            context.insert(Account(name: name, type: selectedType))
        }
        
        dismiss()
    }
}

#Preview {
    AccountEditor(nil)
}
