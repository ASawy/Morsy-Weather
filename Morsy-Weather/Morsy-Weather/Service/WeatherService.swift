//
//  WeatherService.swift
//  Morsy-Weather
//
//  Created by Abdelsalam Morsy on 09.09.23.
//

import Foundation

enum MeasurementUnits: String {
    case metric    // For temperature in Celsius
    case imperial  // For temperature in Fahrenheit
    case standard  // For temperature in Kelvin, default value

    var displayUnit: String {
        switch self {
            case .metric:
                return "C"
            case .imperial:
                return "F"
            case .standard:
                return "K"
        }
    }
}

protocol WeatherServiceDelegate {
    func getWeatherForLocation(lat: Double,
                               lon: Double,
                               unit: MeasurementUnits,
                               completion: @escaping (Result<Weather, Error>) -> Void)
}

class WeatherService: WeatherServiceDelegate {
    func getWeatherForLocation(lat: Double,
                               lon: Double,
                               unit: MeasurementUnits,
                               completion: @escaping (Result<Weather, Error>) -> Void) {
        NetworkClient.request(.weatherForLocation(lat: lat,
                                                  lon: lon,
                                                  unit: unit.rawValue)) { (result: Result<Weather, Error>) in
            switch result {
                case let .failure(error):
                    // Handle network error at service layer if needed
                    completion(.failure(error))

                case let .success(weather):
                    completion(.success(weather))
            }
        }
    }
}
