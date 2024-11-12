//
//  Quakes.swift
//  EarthQuake
//
//  Created by ZEUS on 4/11/24.
//

import SwiftUI


struct Quakes: View {
    
    @AppStorage("lastUpdated") var lastUpdated = Date.distantFuture.timeIntervalSince1970
    
    @EnvironmentObject var provider: QuakesProvider
    
    @State var isLoading = false
    @State var editMode: EditMode = .inactive
    @State var selectMode: SelectMode = .inactive
    @State var selection: Set<String> = []
    
    @State private var error: QuakeError?
    @State private var hasError = false
    
    
    var body: some View {
        NavigationStack{
            List(selection: $selection) {
                ForEach(provider.quakes) { quake in
                    NavigationLink(destination: QuakeDetail(selection: selection, quake: quake)){
                        QuakeRow(quake: quake)
                    }
                }
                .onDelete(perform: deleteQuakes)
            }
            .listStyle(.inset)
            .navigationTitle("EarthQuake")
            .toolbar(content: toolbarContent)
            .refreshable {
                await fetchQuakes()
            }
            .alert(isPresented: $hasError, error: error) {}
            .onAppear{
                selection.removeAll()
            }
            .environment(\.editMode, $editMode)
        }
        .task {
            await fetchQuakes()
        }
    }
}

#Preview {
    Quakes()
        .environmentObject(
            QuakesProvider(client: QuakeClient(downloader: TestDownloader())))
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
    
    var title: String{
        if selectMode.isActive || selection.isEmpty{
            return "Earthquakes"
        }else{
            return "\(selection.count) Selected"
        }
    }
    
    func fetchQuakes() async {
        isLoading = true
        do{
            try await provider.fetchQuakes()
            lastUpdated = Date().timeIntervalSince1970

        }catch{
            self.error = error as? QuakeError ?? .unexpectedError(error: error)
            self.hasError = true
        }
            
        isLoading = false
    }
    
    func deleteQuakes(at offset: IndexSet){
        provider.deleteQuakes(atOffsets: offset)
    }
    
    func deleteQuakes(for codes: Set<String>){
        var offsetsToDelete: IndexSet = []
        for (index, element) in provider.quakes.enumerated(){
            if codes.contains(element.code){
                offsetsToDelete.insert(index)
            }
        }
        deleteQuakes(at: offsetsToDelete)
        selection.removeAll()
    }
}
