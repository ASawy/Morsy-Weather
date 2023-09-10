//
//  SceneDelegate.swift
//  Morsy-Weather
//
//  Created by Abdelsalam Morsy on 09.09.23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    // MARK: Properties
    private var window: UIWindow? {
        return coordinator.window
    }

    private let coordinator: ApplicationCoordinator = ApplicationCoordinator()

    // MARK: Functions
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }

        coordinator.start(windowScene: windowScene)
    }
}
