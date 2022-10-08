//
//  ExpenseItem.swift
//  WeExpense
//
//  Created by Taylor on 08 October 2022.
//

import Foundation

class ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let merchant: String
    let item: String
    let amount: Double
    let type: String
    let date: Date
    
    init(merchant: String, item: String, amount: Double, type: String, date: Date) {
        self.merchant = merchant
        self.item = item
        self.amount = amount
        self.type = type
        self.date = date
    }
    
//    enum ExpenseType: String, CaseIterable, Identifiable {
//        case business = "business"
//        case personal = "personal"
//
//        var id: String {
//            return rawValue
//        }
//
//        var displayString: String {
//            switch self {
//            case .personal:
//                return "Personal"
//            case .business:
//                return "Business"
//            }
//        }
//    }
}
