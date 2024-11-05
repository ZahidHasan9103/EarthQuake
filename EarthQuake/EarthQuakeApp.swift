//
//  EarthQuakeApp.swift
//  EarthQuake
//
//  Created by ZEUS on 4/11/24.
//

import SwiftUI

@main
struct EarthQuakeApp: App {
    @StateObject var quakesProvider = QuakesProvider()
    var body: some Scene {
        WindowGroup {
            Quakes()
                .environmentObject(quakesProvider)
        }
    }
}
