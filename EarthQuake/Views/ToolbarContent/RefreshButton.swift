//
//  RefreshButton.swift
//  EarthQuake
//
//  Created by ZEUS on 4/11/24.
//

import SwiftUI

struct RefreshButton: View {
    var action: () -> Void = {}
    var body: some View {
        Button(action: action, label: {
            Label("Refresh", systemImage: "arrow.clockwise")
        })
    }
}

#Preview {
    RefreshButton()
}
