//
//  FlagImage.swift
//  WeGuess
//
//  Created by Taylor on 25 June 2022.
//

import Foundation
import SwiftUI

struct FlagImage: View {
    var imageName: String
    
    var body: some View {
        Image(imageName)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}
