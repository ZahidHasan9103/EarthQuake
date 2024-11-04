//
//  Quakes.swift
//  EarthQuake
//
//  Created by ZEUS on 4/11/24.
//

import SwiftUI


struct Quakes: View {
    
    @State var quakes = staticData
    @State var isLoading = false
    @State var editMode: EditMode = .inactive
    @State var selectMode: SelectMode = .inactive
    @State var selection: Set<String> = []
    
    @AppStorage("lastUpdated") var lastUpdated = Date.distantFuture.timeIntervalSince1970

    
    var body: some View {
        NavigationStack{
            List(selection: $selection) {
                ForEach(quakes) { quake in
                    QuakeRow(quake: quake)
                }
                .onDelete(perform: deleteQuakes)
                
            }
            .listStyle(.inset)
            .navigationTitle("EarthQuake")
            .refreshable {
                fetchQuakes()
            }
            
            .toolbar(content: toolbarContent)
            .environment(\.editMode, $editMode)
        }
    }
}

#Preview {
    Quakes()
}


//MARK: - Static Data
let staticData: [Quake] = [
    Quake(magnitude: 0.8,
          place: "Shakey Acres",
          time: Date(timeIntervalSinceNow: -1000),
          code: "nc73649170",
          detail: URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/detail/nc73649170.geojson")!),
    Quake(magnitude: 2.2,
          place: "Rumble Alley",
          time: Date(timeIntervalSinceNow: -5000),
          code: "hv72783692",
          detail: URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/detail/hv72783692")!)
    ]

//MARK: -
extension Quakes{
    
    func fetchQuakes(){
        isLoading = true
        self.quakes = staticData
        lastUpdated = Date().timeIntervalSince1970
        isLoading = false
    }
    
    func deleteQuakes(at offset: IndexSet){
        quakes.remove(atOffsets: offset)
    }
    
    func deleteQuakes(for codes: Set<String>){
        var offsetsToDelete: IndexSet = []
        for (index, element) in quakes.enumerated(){
            if codes.contains(element.code){
                offsetsToDelete.insert(index)
            }
        }
        deleteQuakes(at: offsetsToDelete)
        selection.removeAll()
    }
}
