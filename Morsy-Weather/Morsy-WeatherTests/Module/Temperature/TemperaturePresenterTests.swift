//
//  TemperaturePresenterTests.swift
//  Morsy-WeatherTests
//
//  Created by Abdelsalam Morsy on 11.09.23.
//

import XCTest
@testable import Morsy_Weather

final class TemperaturePresenterTests: XCTestCase {
    // MARK: getWeatherForCurrentLocation tests
    func testGetWeatherForCurrentLocationSuccessfully() {
        // given
        let presenter = TemperaturePresenter(coordinator: TemperaturePresenterCoordinatorMock(),
                                             locationService: LocationServiceSuccessMock(),
                                             weatherService: WeatherServiceSuccessMock())
        presenter.configure(with: self)

        // when
        presenter.getWeatherForCurrentLocation()

        // then
        XCTAssertEqual(Self.updateViewCount, 1)
    }

    func testGetWeatherForCurrentLocationWhenLocationServiceFail() {
        // given
        let presenter = TemperaturePresenter(coordinator: TemperaturePresenterCoordinatorMock(),
                                             locationService: LocationServiceFailureMock(),
                                             weatherService: WeatherServiceSuccessMock())
        presenter.configure(with: self)

        // when
        presenter.getWeatherForCurrentLocation()

        // then
        XCTAssertEqual(Self.showErrorViewCount, 1)
    }

    func testGetWeatherForCurrentLocationWhenWeatherServiceFail() {
        // given
        let presenter = TemperaturePresenter(coordinator: TemperaturePresenterCoordinatorMock(),
                                             locationService: LocationServiceSuccessMock(),
                                             weatherService: WeatherServiceFailureMock())
        presenter.configure(with: self)

        // when
        presenter.getWeatherForCurrentLocation()

        // then
        XCTAssertEqual(Self.showErrorViewCount, 1)
    }

    // MARK: getWeatherForLocation tests
    func testGetWeatherForLocation() {
        // given
        let presenter = TemperaturePresenter(coordinator: TemperaturePresenterCoordinatorMock(),
                                             locationService: LocationServiceSuccessMock(),
                                             weatherService: WeatherServiceSuccessMock())
        presenter.configure(with: self)

        let location = Location(name: "", lat: 44.34, lon: 10.99, country: "", state: "")

        // when
        presenter.getWeatherForLocation(location)

        // then
        XCTAssertEqual(Self.updateViewCount, 1)
    }
}

extension TemperaturePresenterTests: TemperatureViewDelegate {
    static var updateViewCount = 0
    func updateView() {
        Self.updateViewCount = 1
    }

    static var showErrorViewCount = 0
    func showErrorView() {
        Self.showErrorViewCount = 1
    }

    func showLoadingIndicator() {
        // no implementation needed
    }

    func hideLoadingIndicator() {
        // no implementation needed
    }

    func hideErrorView() {
        // no implementation needed
    }
}

class TemperaturePresenterCoordinatorMock: TemperaturePresenterCoordinator {
    func navigateToSearchForLocationView() {
        // no implementation needed
    }
}
