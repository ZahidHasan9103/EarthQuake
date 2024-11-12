//
//  CacheEntry.swift
//  EarthQuake
//
//  Created by ZEUS on 5/11/24.
//

import Foundation

final class CacheEntryObject{
    let entry: CacheEntry
    
    init(entry: CacheEntry) {
        self.entry = entry
    }
}

enum CacheEntry{
    case inProgress(Task<QuakeLocation, Error>) // inProgress is used to avoid making a second network request
    case ready(QuakeLocation)
}
