//
//  LocationServiceMock.swift
//  Morsy-WeatherTests
//
//  Created by Abdelsalam Morsy on 11.09.23.
//

import CoreLocation
@testable import Morsy_Weather

final class LocationServiceSuccessMock: LocationServiceDelegate {
    func getCurrentLocation(completion: @escaping CompletionBlock) {

        let locationCoordinate = CLLocationCoordinate2D(latitude: 44.34,
                                                        longitude: 10.99)
        completion(.success(locationCoordinate))
    }

    func searchForLocations(keyword: String,
                            limit: Int,
                            completion: @escaping (Result<[Location], Error>) -> Void) {

        let location = Location(name: "",
                                lat: 44.34,
                                lon: 10.99,
                                country: "",
                                state: "")

        completion(.success([location]))
    }
}

final class LocationServiceFailureMock: LocationServiceDelegate {
    func getCurrentLocation(completion: @escaping CompletionBlock) {
        let error = NetworkError.parsingError
        completion(.failure(error))
    }

    func searchForLocations(keyword: String,
                            limit: Int,
                            completion: @escaping (Result<[Location], Error>) -> Void) {

        let error = NetworkError.parsingError
        completion(.failure(error))
    }
}
