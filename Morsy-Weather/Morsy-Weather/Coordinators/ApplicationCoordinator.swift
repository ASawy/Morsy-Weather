//
//  ApplicationCoordinator.swift
//  Morsy-Weather
//
//  Created by Abdelsalam Morsy on 10.09.23.
//

import UIKit

class ApplicationCoordinator {
    // MARK: Properties
    private(set) var window: UIWindow?

    private lazy var temperaturePresenter: TemperaturePresenter = {
        let locationService = LocationService()
        let weatherService = WeatherService()
        let presenter = TemperaturePresenter(coordinator: self,
                                             locationService: locationService,
                                             weatherService: weatherService)

        return presenter
    }()

    private lazy var rootNavigationController: UINavigationController = {
        let viewController = TemperatureViewController(presenter: temperaturePresenter)
        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }()

    // MARK: Functions
    func start(windowScene: UIWindowScene) {
        window = UIWindow(windowScene: windowScene)
        window?.backgroundColor = .white
        window?.rootViewController = rootNavigationController
        window?.makeKeyAndVisible()
    }
}

// MARK: - TemperaturePresenterCoordinator
extension ApplicationCoordinator: TemperaturePresenterCoordinator {
    func navigateToSearchForLocationView() {
        let locationService = LocationService()
        let presenter = SearchForLocationPresenter(coordinator: self,
                                                   locationService: locationService)
        let viewController = SearchForLocationViewController(presenter: presenter)
        rootNavigationController.pushViewController(viewController, animated: true)
    }
}

// MARK: - SearchForLocationPresenterCoordinator
extension ApplicationCoordinator: SearchForLocationPresenterCoordinator {
    func popViewController(with location: Location) {
        temperaturePresenter.getWeatherForLocation(location)
        rootNavigationController.popViewController(animated: true)
    }
}

