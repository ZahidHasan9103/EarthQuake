//
//  QuakeMagnitude.swift
//  EarthQuake
//
//  Created by ZEUS on 4/11/24.
//

import SwiftUI

struct QuakeMagnitude: View {
    
    var quake: Quake
    
    var body: some View {
        
        RoundedRectangle(cornerRadius: 8)
            .fill(.black)
            .frame(width: 80, height: 60)
            .overlay {
                Text("\(quake.magnitude.formatted(.number.precision(.fractionLength(1))))")
                    .foregroundStyle(quake.color)
                    .font(.title)
                    .bold()
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
    
    return QuakeMagnitude(quake: sampleQuake)
}
