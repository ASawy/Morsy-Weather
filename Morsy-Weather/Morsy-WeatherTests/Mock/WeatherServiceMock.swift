//
//  WeatherServiceMock.swift
//  Morsy-WeatherTests
//
//  Created by Abdelsalam Morsy on 11.09.23.
//

@testable import Morsy_Weather

final class WeatherServiceSuccessMock: WeatherServiceDelegate {
    func getWeatherForLocation(lat: Double,
                               lon: Double,
                               unit: MeasurementUnits,
                               completion: @escaping (Result<Weather, Error>) -> Void) {

        let weather = Weather(coord: nil,
                              weather: nil,
                              base: nil,
                              main: nil,
                              visibility: nil,
                              wind: nil,
                              rain: nil,
                              clouds: nil,
                              dt: nil,
                              sys: nil,
                              timezone: nil,
                              id: nil,
                              name: nil,
                              cod: nil)

        completion(.success(weather))
    }
}

final class WeatherServiceFailureMock: WeatherServiceDelegate {
    func getWeatherForLocation(lat: Double,
                               lon: Double,
                               unit: MeasurementUnits,
                               completion: @escaping (Result<Weather, Error>) -> Void) {

        let error = NetworkError.parsingError
        completion(.failure(error))
    }
}
