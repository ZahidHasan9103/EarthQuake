//
//  QuakeDetail.swift
//  EarthQuake
//
//  Created by ZEUS on 6/11/24.
//

import SwiftUI

struct QuakeDetail: View {
    @EnvironmentObject private var quakesProvider: QuakesProvider
    
    @State private var location: QuakeLocation? = nil
    
    var selection: Set<String> = []
    
    var quake: Quake
    
    var body: some View {
        VStack{
            QuakeMagnitude(quake: quake)
            Text(quake.place)
                .font(.title)
                .bold()
            Text("\(quake.time.formatted(date: .abbreviated, time: .shortened))")
                .foregroundStyle(Color.secondary)
            if let location = self.location{
                Text("Latitude: \(location.latitude.formatted(.number.precision(.fractionLength(3))))")
                Text("Longitude: \(location.longitude.formatted(.number.precision(.fractionLength(3))))")
            }
        }
        .task {
            if self.location == nil{
                if let quakeLocation = quake.location{
                    self.location = quakeLocation
                }else{
                    self.location = try? await quakesProvider.location(for: quake)
                }
            }
        }
    }
}

#Preview {
    QuakeDetail(quake: Quake.preview)
}
