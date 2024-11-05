//
//  QuakeError.swift
//  EarthQuake
//
//  Created by ZEUS on 4/11/24.
//

import Foundation

enum QuakeError: Error{
    case missingData
    case networkError
    case unexpectedError(error: Error)
}

extension QuakeError: LocalizedError{
    var errorDescription: String?{
        switch self {
        case .missingData:
            return NSLocalizedString(
                "Found and will discard a quake missing a valid code, magnitude, place, or time.",
                comment: ""
            )
        case .networkError:
            return NSLocalizedString(
                "Error fetching quake data over the network.", comment: ""
            )
        case .unexpectedError(error: let error):
            return NSLocalizedString(
                "Received unexpected error. \(error)",
                comment: ""
            )
        }
    }
}
