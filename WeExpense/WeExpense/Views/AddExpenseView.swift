//
//  AddExpenseView.swift
//  WeExpense
//
//  Created by Taylor on 08 October 2022.
//

import SwiftUI

struct AddExpenseView: View {
    
    @ObservedObject var expenseController: ExpenseController
    @Environment(\.dismiss) var dismiss
    
    @State private var merchant = ""
    @State private var item = ""
    @State private var amount = 0.0
    @State private var type = "Business"
    
    let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Merchant", text: $merchant)
                
                TextField("Item", text: $item)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: ExpenseController.currencyCode))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add New Expense")
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(merchant: merchant, item: item, amount: amount, type: type, date: Date())
                    expenseController.expenseItems.append(item)
                    dismiss()
                }
            }
        }
    }
}

struct AddExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExpenseView(expenseController: ExpenseController())
    }
}
