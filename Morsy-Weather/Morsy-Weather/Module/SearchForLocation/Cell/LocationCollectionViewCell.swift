//
//  LocationCollectionViewCell.swift
//  Morsy-Weather
//
//  Created by Abdelsalam Morsy on 11.09.23.
//

import UIKit

final class LocationCollectionViewCell: UICollectionViewCell {
    // MARK: Properties
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 9
        return stackView
    }()

    private let locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()

    private let separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .separator
        view.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        return view
    }()

    // MARK: Initalization
    override init(frame: CGRect) {
        super.init(frame: frame)

        stackView.addArrangedSubview(locationLabel)
        stackView.addArrangedSubview(separatorView)

        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 9),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -9),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 9),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Configure
    func configure(with location: Location) {
        locationLabel.text = "\(location.name ?? ""), \(location.state ?? ""), \(location.country ?? "")"
    }
}
