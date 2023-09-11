//
//  SearchForLocationPresenter.swift
//  Morsy-Weather
//
//  Created by Abdelsalam Morsy on 10.09.23.
//

import Foundation

protocol SearchForLocationPresenterCoordinator: AnyObject {
    func popViewController(with location: Location)
}

protocol SearchForLocationViewDelegate: AnyObject {
    func updateView()
}

final class SearchForLocationPresenter {
    // MARK: Constant
    private let searchCount = 10

    // MARK: Properties
    private unowned let coordinator: SearchForLocationPresenterCoordinator
    private weak var viewDelegate: SearchForLocationViewDelegate?
    private let locationService: LocationServiceDelegate
    private var locations: [Location] = []

    // MARK: Public Properties
    var locationsCount: Int {
        return locations.count
    }

    // MARK: Initalization
    init(coordinator: SearchForLocationPresenterCoordinator,
         locationService: LocationServiceDelegate) {

        self.coordinator = coordinator
        self.locationService = locationService
    }

    // MARK: Configure
    func configure(with viewDelegate: SearchForLocationViewDelegate) {
        self.viewDelegate = viewDelegate
    }

    // MARK: Function
    func search(with text: String) {
        if text.count > 2 { // call location service if text is 3 or more characters
            locationService.searchForLocations(keyword: text, limit: searchCount) { [weak self] result in
                guard let self = self else { return }

                switch result {
                    case let .failure(error):
                        print(error.localizedDescription)

                    case let .success(locations):
                        self.locations = locations
                        self.viewDelegate?.updateView()
                }
            }
        }
    }

    func getLocation(at index: Int) -> Location? {
        guard index < locationsCount else {
            return nil
        }

        return locations[index]
    }

    // MARK: User Actions
    func selectLocation(at index: Int) {
        guard index < locationsCount else { return }

        let location = locations[index]
        coordinator.popViewController(with: location)
    }
}
