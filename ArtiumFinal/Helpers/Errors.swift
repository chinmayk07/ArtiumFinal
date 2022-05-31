//
//  Errors.swift
//  ArtiumFinal
//
//  Created by Chinmay Khot on 29/05/22.
//

import Foundation

enum ProjectError: LocalizedError, Equatable {
    
    case invalidResponseModel
    case invalidRequestURLStringError
    case failedRequest(description: String)
    
    var errorDescription: String? {
        switch self {
        case .failedRequest(let description):
            return description
        case .invalidResponseModel:
            return ""
        case .invalidRequestURLStringError:
            return ""
        }
    }
    
}
