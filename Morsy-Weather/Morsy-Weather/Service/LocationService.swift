//
//  LocationService.swift
//  Morsy-Weather
//
//  Created by Abdelsalam Morsy on 09.09.23.
//

import CoreLocation

typealias CompletionBlock = (Result<CLLocationCoordinate2D?, Error>) -> Void

protocol LocationServiceDelegate {
    func getCurrentLocation(completion: @escaping CompletionBlock)
    func searchForLocations(keyword: String,
                            limit: Int,
                            completion: @escaping (Result<[Location], Error>) -> Void)
}

class LocationService: NSObject, LocationServiceDelegate {
    // MARK: Properties
    private let locationManager = CLLocationManager()
    private var completion: CompletionBlock?
    private var previousDataTask: URLSessionDataTask?

    // MARK: Functions
    func getCurrentLocation(completion: @escaping CompletionBlock) {
        self.completion = completion
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()

        locationManager.requestLocation()
    }

    func searchForLocations(keyword: String,
                            limit: Int,
                            completion: @escaping (Result<[Location], Error>) -> Void) {

        previousDataTask?.cancel() // cancel previous call if it exists
        previousDataTask = NetworkClient.request(.searchForLocations(keyword: keyword, limit: limit)) { (result: Result<[Location], Error>) in
            switch result {
                case let .failure(error):
                    // Handle network error at service layer if needed
                    completion(.failure(error))

                case let .success(locations):
                    completion(.success(locations))
            }
        }
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            completion?(.success(location.coordinate))
        } else {
            completion?(.success(nil))
        }

        locationManager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        completion?(.failure(error))
    }
}
