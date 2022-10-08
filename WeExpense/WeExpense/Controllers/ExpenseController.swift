//
//  ExpenseController.swift
//  WeExpense
//
//  Created by Taylor on 08 October 2022.
//

import Foundation

class ExpenseController: ObservableObject {
    
    private static let key = "expenses"
    static let currencyCode = Locale.current.currency?.identifier ?? "USD"
    
    
    @Published var expenseItems = [ExpenseItem]() {
        didSet {
            guard let encoded = try? JSONEncoder().encode(expenseItems) else { return }
            UserDefaults.standard.set(encoded, forKey: ExpenseController.key)
        }
    }
    
    init() {
        guard let savedItemsData = UserDefaults.standard.data(forKey: ExpenseController.key),
              let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItemsData) else {
            expenseItems = []
            return
        }
        
        expenseItems = decodedItems
    }
}
