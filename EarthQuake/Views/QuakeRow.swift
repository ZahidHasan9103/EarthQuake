//
//  QuakeRow.swift
//  EarthQuake
//
//  Created by ZEUS on 4/11/24.
//

import SwiftUI

struct QuakeRow: View {
    var quake: Quake
    var body: some View {
        HStack {
            QuakeMagnitude(quake: quake)
            VStack(alignment: .leading){
                Text(quake.place)
                    .font(.title3)
                Text(quake.time.formatted(.relative(presentation: .named)))
                    .foregroundStyle(.secondary)
                
            }
        }
    }
}

#Preview {
    let sampleQuake = Quake(
        magnitude: 1.0,
        place: "Shakey Acred",
        time: Date(timeIntervalSinceNow: -1000),
        code: "nc73649170",
        detail: URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/detail/nc73649170.geojson")!
    )
    
   return QuakeRow(quake: sampleQuake)
}
