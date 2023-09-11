//
//  TemperatureViewController.swift
//  Morsy-Weather
//
//  Created by Abdelsalam Morsy on 09.09.23.
//

import UIKit

class TemperatureViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var headerLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var feelsLikeLabel: UILabel!
    @IBOutlet private weak var pressureLabel: UILabel!
    @IBOutlet private weak var humidityLabel: UILabel!
    @IBOutlet private weak var visibilityLabel: UILabel!
    @IBOutlet private weak var cloudsLabel: UILabel!
    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!
    
    // MARK: Properties
    private let presenter: TemperaturePresenter

    // MARK: Initalization
    init(presenter: TemperaturePresenter) {
        self.presenter = presenter

        super.init(nibName: "TemperatureViewController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        assertionFailure("init(coder:) has not been implemented")
        return nil
    }

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.configure(with: self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.getWeatherForCurrentLocation()
    }

    // MARK: User Actions
    @IBAction private func selectDifferentLocation(_ sender: Any) {
        presenter.selectDifferentLocation()
    }
}

// MARK: - TemperatureViewDelegate
extension TemperatureViewController: TemperatureViewDelegate {
    func updateView() {
        DispatchQueue.main.async {
            self.headerLabel.text = self.presenter.header
            self.descriptionLabel.text = self.presenter.description
            self.temperatureLabel.text = self.presenter.temperature
            self.feelsLikeLabel.text = self.presenter.feelsLike
            self.pressureLabel.text = self.presenter.pressure
            self.humidityLabel.text = self.presenter.humidity
            self.visibilityLabel.text = self.presenter.visibility
            self.cloudsLabel.text = self.presenter.clouds
        }
    }

    func showLoadingIndicator() {
        loadingIndicator.isHidden = false
    }

    func hideLoadingIndicator() {
        DispatchQueue.main.async {
            self.loadingIndicator.isHidden = true
        }
    }

    func showErrorView() {
        DispatchQueue.main.async {
            self.errorLabel.isHidden = false
        }
    }

    func hideErrorView() {
        errorLabel.isHidden = true
    }
}
