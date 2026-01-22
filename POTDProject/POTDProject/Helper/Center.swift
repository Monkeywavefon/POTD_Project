//
//  Center.swift
//  POTDProject
//
//  Created by Dev3 on 22/1/2569 BE.
//

import Foundation

enum APIError: LocalizedError {
    case invalidURL
    case invalidResponse
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid server response"
        }
    }
}
