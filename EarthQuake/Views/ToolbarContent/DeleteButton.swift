//
//  DeleteButton.swift
//  EarthQuake
//
//  Created by ZEUS on 4/11/24.
//

import SwiftUI

struct DeleteButton: View {
    var action: () -> Void = {}
    var body: some View {
        Button(action: action, label: {
            Label("Delete", systemImage: "trash")
        })
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    DeleteButton()
}
