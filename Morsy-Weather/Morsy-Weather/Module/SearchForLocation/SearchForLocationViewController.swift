//
//  SearchForLocationViewController.swift
//  Morsy-Weather
//
//  Created by Abdelsalam Morsy on 10.09.23.
//

import UIKit

final class SearchForLocationViewController: UIViewController {
    // MARK: Constant
    private let locationsCollectionViewCellIdentifier = "locationsCollectionViewCell"

    // MARK: Outlets
    @IBOutlet weak var locationsCollectionView: UICollectionView!
    
    // MARK: Properties
    private let presenter: SearchForLocationPresenter

    // MARK: Initalization
    init(presenter: SearchForLocationPresenter) {
        self.presenter = presenter

        super.init(nibName: "SearchForLocationViewController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        assertionFailure("init(coder:) has not been implemented")
        return nil
    }

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.configure(with: self)
        setupNavigationBar()
        configureRecipesCollectionView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

// MARK: - Private functions
private extension SearchForLocationViewController {
    func setupNavigationBar() {
        navigationItem.title = "Search For Location"

        let searchController = UISearchController()
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    func configureRecipesCollectionView() {
        locationsCollectionView.register(LocationCollectionViewCell.self,
                                         forCellWithReuseIdentifier: locationsCollectionViewCellIdentifier)
        locationsCollectionView.dataSource = self
        locationsCollectionView.delegate = self

    }
}

// MARK: - UISearchBarDelegate
extension SearchForLocationViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.search(with: searchText)
    }
}

// MARK: - UICollectionViewDataSource
extension SearchForLocationViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.locationsCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: locationsCollectionViewCellIdentifier,
                                                            for: indexPath) as? LocationCollectionViewCell else {
            return UICollectionViewCell()
        }

        if let location = presenter.getLocation(at: indexPath.row) {
            cell.configure(with: location)
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension SearchForLocationViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.selectLocation(at: indexPath.row)
    }
}

// MARK: - SearchForLocationViewDelegate
extension SearchForLocationViewController: SearchForLocationViewDelegate {
    func updateView() {
        DispatchQueue.main.async {
            self.locationsCollectionView.reloadData()
        }
    }
}
