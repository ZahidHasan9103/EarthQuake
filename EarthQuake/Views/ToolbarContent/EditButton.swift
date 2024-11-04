//
//  EditButton.swift
//  EarthQuake
//
//  Created by ZEUS on 4/11/24.
//

import SwiftUI

struct EditButton: View {
    @Binding var editMode: EditMode
    var action: () -> Void = {}
    var body: some View {
        Button{
            withAnimation {
                if editMode == .active{
                    action()
                    editMode = .inactive
                }else{
                    editMode = .active
                }
            }
        } label: {
            if editMode == .active{
                Text("Cancel").bold()
            } else{
                Text("Edit")
            }
        }
    }
}

#Preview {
    EditButton(editMode: .constant(.inactive))
}
