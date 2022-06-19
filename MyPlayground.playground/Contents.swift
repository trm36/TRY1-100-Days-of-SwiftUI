import UIKit
import Foundation

let unit = UnitTemperature.celsius

let mf = MeasurementFormatter()
mf.unitStyle = .short
let unitString = mf.string(from: unit)
