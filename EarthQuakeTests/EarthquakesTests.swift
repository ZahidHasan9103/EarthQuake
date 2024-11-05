//
//  EarthquakesTests.swift
//  EarthQuakeTests
//
//  Created by ZEUS on 4/11/24.
//

import XCTest
@testable import EarthQuake

final class EarthquakesTests: XCTestCase {
    
    func test_GeoJSONDecoder_DecodesQuake() throws{
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970
        let quake = try decoder.decode(Quake.self, from: testFeature_nc73649170)
        
        XCTAssertEqual(quake.code, "73649170")
        
        let expectedSeconds = TimeInterval(1636129710550) / 1000
        let decodedSeconds = quake.time.timeIntervalSince1970
        
        XCTAssertEqual(expectedSeconds, decodedSeconds, accuracy: 0.00001)
    }
    
    func test_GeoJSONDecoder_DecodesGeoJSON() throws{
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970
        let decoded = try decoder.decode(GeoJSON.self, from: testQuakesData)
        
        XCTAssertEqual(decoded.quakes.count, 6)
        XCTAssertEqual(decoded.quakes[0].code, "73649170")
        
        let expectedSeconds = TimeInterval(1636129710550) / 1000
        let decodedSeconds = decoded.quakes[0].time.timeIntervalSince1970
        
        XCTAssertEqual(expectedSeconds, decodedSeconds, accuracy: 0.00001)
    }
    
    func test_QuakeDetailsDecoder() throws{
        let decoded = try JSONDecoder().decode(QuakeLocation.self, from: testDetail_hv72783692)
        XCTAssertEqual(decoded.latitude, 19.2189998626709, accuracy: 0.00000000001)
    }
    
}
