//
//  NetworkClient.swift
//  Morsy-Weather
//
//  Created by Abdelsalam Morsy on 09.09.23.
//

import Foundation

typealias CompletionHandler<T: Decodable> = (Result<T, Error>) -> Void

class NetworkClient {
    class func request<T: Decodable>(_ config: RequestConfiguration, completion: @escaping CompletionHandler<T>) {
        guard let url = URL(string: config.baseURL + config.path) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = config.method.rawValue

        // Set headers if provided
        config.headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }

        // Add JSON data if provided
        if let parameters = config.parameters {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                completion(.failure(NetworkError.requestFailed))
                return
            }
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }

            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(NetworkError.parsingError))
            }
        }

        task.resume()
    }
}
