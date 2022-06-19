//
//  ContentView.swift
//  WeConvert
//
//  Created by Taylor on 18 June 2022.
//

import SwiftUI

struct ContentView: View {
    private var units: [UnitTemperature] = [.celsius, .fahrenheit, .kelvin]

    @State private var inputValue = 0.0
    @State private var inputUnit: UnitTemperature = .celsius
    @State private var outputUnit: UnitTemperature = .fahrenheit

    @FocusState private var inputIsFocused: Bool

    private var result: Double {
        let input = Measurement(value: inputValue, unit: inputUnit)
        let conversion = input.converted(to: outputUnit)

        return conversion.value
    }

    private var formatter: MeasurementFormatter {
        let mf = MeasurementFormatter()
        mf.unitStyle = .short
        return mf
    }

    private func unitStringView(unit: UnitTemperature) -> some View {
        return Text(formatter.string(from: unit))
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Input Temperature", value: $inputValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)
                    
                    Picker("Input Unit", selection: $inputUnit) {
                        ForEach(units, id: \.self) {
                            unitStringView(unit: $0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Input temperature")
                }
                
                Section {
                    Picker("Output Unit", selection: $outputUnit) {
                        ForEach(units, id: \.self) {
                            unitStringView(unit: $0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header : {
                    Text("Output unit")
                }
                
                Section {
                    Text(result, format: .number)
                } header: {
                    Text("Result")
                }
            }
            .navigationTitle("🔀 WeConvert")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
