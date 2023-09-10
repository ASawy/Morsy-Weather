//
//  TemperaturePresenter.swift
//  Morsy-Weather
//
//  Created by Abdelsalam Morsy on 10.09.23.
//

import Foundation
import CoreLocation

protocol TemperaturePresenterCoordinator: AnyObject {
}

protocol TemperatureViewDelegate: AnyObject {
    func updateView()
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func showErrorView()
    func hideErrorView()
}

class TemperaturePresenter {
    // MARK: Properties
    private unowned let coordinator: TemperaturePresenterCoordinator
    private weak var viewDelegate: TemperatureViewDelegate?
    private let locationService: LocationServiceDelegate
    private let weatherService: WeatherServiceDelegate
    private var weather: Weather?

    private var measurementUnit: MeasurementUnits = .metric

    // MARK: Initalization
    init(coordinator: TemperaturePresenterCoordinator,
         locationService: LocationServiceDelegate,
         weatherService: WeatherServiceDelegate) {

        self.coordinator = coordinator
        self.locationService = locationService
        self.weatherService = weatherService
    }

    // MARK: Configure
    func configure(with viewDelegate: TemperatureViewDelegate) {
        self.viewDelegate = viewDelegate
    }

    // MARK: Function
    func getWeatherForCurrentLocation() {
        viewDelegate?.hideErrorView()
        viewDelegate?.showLoadingIndicator()
        locationService.getCurrentLocation { [weak self] result in
            guard let self = self else { return }

            switch result {
                case .failure:
                    self.viewDelegate?.showErrorView()
                    self.viewDelegate?.hideLoadingIndicator()

                case let .success(location):
                    if let location = location {
                        self.getWeatherForLocation(location)
                    }
            }
        }
    }
}

// MARK: - Private function
private extension TemperaturePresenter {
    func getWeatherForLocation(_ location: CLLocationCoordinate2D) {
        weatherService.getWeatherForLocation(lat: location.latitude,
                                                  lon: location.longitude,
                                                  unit: measurementUnit) { [weak self] result in
            guard let self = self else { return }

            switch result {
                case .failure:
                    self.viewDelegate?.showErrorView()

                case let .success(weather):
                    self.weather = weather
                    self.viewDelegate?.updateView()
            }

            self.viewDelegate?.hideLoadingIndicator()
        }
    }
}

// MARK: - User interface
extension TemperaturePresenter {
    var header: String {
        return "\(weather?.weather?.first?.main ?? "") in \(weather?.name ?? "")"
    }

    var description: String? {
        return weather?.weather?.first?.description
    }

    var temperature: String {
        guard let temperature = weather?.main?.temp else { return "" }

        let ceilingTemperature = Int(ceil(temperature))
        return "\(ceilingTemperature) \(measurementUnit.displayUnit)"
    }

    var feelsLike: String {
        guard let feelsLike = weather?.main?.feelsLike else { return "" }

        let ceilingFeelsLike = Int(ceil(feelsLike))
        return "\(ceilingFeelsLike) \(measurementUnit.displayUnit)"
    }

    var pressure: String {
        guard let pressure = weather?.main?.pressure else { return "" }
        return "\(pressure) hPa"
    }

    var humidity: String {
        guard let humidity = weather?.main?.humidity else { return "" }
        return "\(humidity) %"
    }

    var visibility: String {
        guard let visibility = weather?.visibility else { return "" }

        let visibilityKM = visibility / 100
        return "\(visibilityKM) KM"
    }

    var clouds: String {
        guard let clouds = weather?.clouds?.all else { return "" }

        return "\(clouds) %"
    }
}
