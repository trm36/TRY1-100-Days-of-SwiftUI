//
//  ContentView.swift
//  WeSplit
//
//  Created by Taylor on 17 June 2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var peopleIndex = 2
    @State private var tipSelection = 20
    
    @FocusState private var amountIsFocused: Bool
    
    let tipOptions = [0, 10, 15, 20, 25]
    
    var tipAmount: Double {
        let tipPercentage = Double(tipSelection) / 100.0
        return checkAmount * tipPercentage
    }
    
    var grandTotal: Double {
        return checkAmount + tipAmount
    }
    
    var amountPerPerson: Double {
        let peopleCount = Double(peopleIndex + 2)
        return grandTotal / peopleCount
    }
    
    
    var body: some View {
        
        
        NavigationView {
            Form {
                let currencyCode = Locale.current.currencyCode ?? "USD"
                
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: currencyCode))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $peopleIndex) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipSelection) {
                        ForEach(tipOptions, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(tipAmount, format: .currency(code: currencyCode))
                } header: {
                    Text("TIP AMOUNT")
                }
                
                Section {
                    Text(grandTotal, format: .currency(code: currencyCode))
                } header: {
                    Text("GRAND TOTAL")
                }
                
                Section {
                    Text(amountPerPerson, format: .currency(code: currencyCode))
                } header: {
                    Text("AMOUNT PER PERSON")
                }
            }
            .navigationTitle("🧾 WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
