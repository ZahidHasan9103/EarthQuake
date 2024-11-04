//
//  SelectButton.swift
//  EarthQuake
//
//  Created by ZEUS on 4/11/24.
//

import SwiftUI

enum SelectMode{
    case active, inactive
    
    var isActive: Bool{
        self == .active
    }
    
    mutating func toogle(){
        switch self {
        case .active:
            self = .inactive
        case .inactive:
            self = .active
        }
    }
    
}

struct SelectButton: View {
    
    @Binding var mode: SelectMode
    var action: () -> Void = {}
    
    var body: some View {
        Button(action: {
            withAnimation{
                mode.toogle()
                action()
            }
        }, label: {
            Text(mode.isActive ? "Deselect All" : "Select All")
        })
    }
}

#Preview {
    SelectButton(mode: .constant(.active))
}
