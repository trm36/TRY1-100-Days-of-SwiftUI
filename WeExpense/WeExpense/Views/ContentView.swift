//
//  ContentView.swift
//  WeExpense
//
//  Created by Taylor on 08 October 2022.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var expenseController = ExpenseController()
    
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenseController.expenseItems) { expenseItem in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(expenseItem.item)
                                .font(.headline)
                            Text(expenseItem.merchant)
                        }
                        
                        Spacer()
                        
                        let amount = expenseItem.amount
                        
                        if amount < 10.0 {
                            Text(expenseItem.amount, format: .currency(code: ExpenseController.currencyCode))
                                .fontWeight(.regular)
                        } else if amount < 100.0 {
                            Text(expenseItem.amount, format: .currency(code: ExpenseController.currencyCode))
                                .fontWeight(.medium)
                        } else {
                            Text(expenseItem.amount, format: .currency(code: ExpenseController.currencyCode))
                                .fontWeight(.semibold)
                        }
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("WeExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddExpense) {
            AddExpenseView(expenseController: expenseController)
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenseController.expenseItems.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
