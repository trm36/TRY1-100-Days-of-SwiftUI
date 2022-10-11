//
//  Partition.swift
//  WeMoon
//
//  Created by Taylor on 11 October 2022.
//

import SwiftUI

struct Partition: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundColor(.lightBackground)
            .padding(.vertical)
    }
}

struct Partition_Previews: PreviewProvider {
    static var previews: some View {
        Partition()
            .preferredColorScheme(.dark)
    }
}
