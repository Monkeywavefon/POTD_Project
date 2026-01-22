//
//  sturct.swift
//  POTDProject
//
//  Created by Dev3 on 22/1/2569 BE.
//
enum APIError: Error {
    case invalidResponse
    case serverError(String)
    case decodingError
    case urlError
}

struct NASAErrorResponse {
    let code: Int
    let msg: String
    let service_version: String
}

nonisolated extension NASAErrorResponse: Decodable {}
