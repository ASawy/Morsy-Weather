//
//  WeatherService.swift
//  Morsy-Weather
//
//  Created by Abdelsalam Morsy on 09.09.23.
//

import Foundation

protocol WeatherServiceDelegate {
    func getWeatherForLocation(lat: Double,
                               lon: Double,
                               completion: @escaping (Result<Weather, Error>) -> Void)
}

class WeatherService: WeatherServiceDelegate {
    func getWeatherForLocation(lat: Double,
                               lon: Double,
                               completion: @escaping (Result<Weather, Error>) -> Void) {
        NetworkClient.request(.weatherForLocation(lat: lat, lon: lon)) { (result: Result<Weather, Error>) in
            switch result {
                case let .failure(error):
                    // Handle network error at service layer if needed
                    completion(.failure(error))

                case let .success(organizations):
                    completion(.success(organizations))
            }
        }
    }
}
