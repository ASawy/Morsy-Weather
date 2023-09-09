//
//  NetworkError.swift
//  Morsy-Weather
//
//  Created by Abdelsalam Morsy on 09.09.23.
//

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case invalidResponse
    case parsingError
    // Add more error cases when needed
}
