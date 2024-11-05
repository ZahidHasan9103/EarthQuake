//
//  Quakes+Toolbar.swift
//  EarthQuake
//
//  Created by ZEUS on 4/11/24.
//

import SwiftUI

extension Quakes{
    @ToolbarContentBuilder
    func toolbarContent() -> some ToolbarContent{
        ToolbarItem(placement: .topBarLeading) {
            if editMode == .active{
                SelectButton(mode: $selectMode) {
                    if selectMode == .active{
                        selection = Set(provider.quakes.map { $0.code })
                    }else{
                        selection = []
                    }
                }
            }
        }
    
    ToolbarItem(placement: .topBarTrailing) {
        EditButton(editMode: $editMode) {
            selection.removeAll()
            editMode = .inactive
            selectMode = .inactive
        }
    }
    
    ToolbarItemGroup(placement: .bottomBar) {
        RefreshButton {
            Task{
                await fetchQuakes()
            }
        }
        Spacer()
        ToolbarStatus(
            isLoading: isLoading,
            lastUpdated: lastUpdated,
            quakesCount: provider.quakes.count)
        Spacer()
        
        if editMode == .active{
            DeleteButton {
                deleteQuakes(for: selection)
            }
            .disabled(isLoading || selection.isEmpty)
        }
    }
}
}
