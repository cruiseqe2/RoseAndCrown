//
//  ScreenError.swift
//  RoseAndCrown
//
//  Created by Mark Oelbaum on 16/08/2024.
//

import Foundation

enum AppError: Error, LocalizedError {
    case decodingError
    case encodingError
    case null
    
    var errorDescription: String? {
        switch self {
        case .decodingError:
            "There was a decoding error"
//            NSLocalizedString("Decoding Error", comment: "")
        case .encodingError:
            "There was an encoding error"
//            NSLocalizedString("Encoding Error", comment: "")
        case .null:
            "You should never get here!!!"
        }
    }
    
    var failureReason: String {
        switch self {
        case .decodingError:
            "Please contact the developer for help with this."
        case .encodingError:
            "Please contact the developer for help with this."
        case .null:
            "You should never get here!!!"
        }
        
    }
}

//struct SystemErrorType: Identifiable {
//    let id = UUID()
//    let error: AppSystemError
//}


