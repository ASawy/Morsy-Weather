//
//  ApplicationCoordinator.swift
//  Morsy-Weather
//
//  Created by Abdelsalam Morsy on 10.09.23.
//

import UIKit

class ApplicationCoordinator {
    private(set) var window: UIWindow?

    func start(windowScene: UIWindowScene) {
        window = UIWindow(windowScene: windowScene)
        window?.backgroundColor = .white
        window?.rootViewController = rootNavigationController
        window?.makeKeyAndVisible()
    }

    private lazy var rootNavigationController: UINavigationController = {
        let locationService = LocationService()
        let weatherService = WeatherService()
        let presenter = TemperaturePresenter(coordinator: self,
                                             locationService: locationService,
                                             weatherService: weatherService)
        let viewController = TemperatureViewController(presenter: presenter)
        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }()
}

extension ApplicationCoordinator: TemperaturePresenterCoordinator {
}

//extension ApplicationCoordinator: QuestionsPresenterCoordinator {
//    func backToMainMenu() {
//        rootNavigationController.popViewController(animated: true)
//    }
//}

