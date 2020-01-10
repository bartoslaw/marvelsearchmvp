//
//  ViewController.swift
//  MarvelApp
//
//  Created by Bartłomiej Smektała on 09/01/2020.
//  Copyright © 2020 Bartłomiej Smektała. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    var mainPresenter: MainPresenter?
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var emptyViewTitle: UILabel!
    @IBOutlet weak var emptyView: UIStackView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.overrideUserInterfaceStyle = .light
        
        self.setupViews()
        self.setupTableView()
        self.setupSearchController()
        
        self.initData()
    }
    
    private func setupViews() {
        self.topLabel.text = NSLocalizedString("main.title", comment: "")
        
        self.emptyView.isHidden = true
        self.emptyViewTitle.text = NSLocalizedString("empty.results", comment: "")
        
        self.activityIndicator.isHidden = true
    }
    
    private func setupTableView() {
        self.tableView.register(UINib.init(nibName: ComicBookTableViewCell.reuseIdentifier(), bundle: nil), forCellReuseIdentifier: ComicBookTableViewCell.reuseIdentifier())
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func setupSearchController() {
        self.searchController.delegate = self
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = NSLocalizedString("search.placeholder", comment: "")
        
        self.navigationItem.searchController = self.searchController
        definesPresentationContext = true
    }
    
    private func initData() {
        self.mainPresenter?.mainView = self
        self.mainPresenter?.getComics()
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let scrollingOffset = 2
        guard let itemCount = self.mainPresenter?.getItemsCount() else { return }
        
        if indexPath.row == itemCount - scrollingOffset {
            guard let query = self.searchController.searchBar.text else { return }
            
            if query.isEmpty {
                self.mainPresenter?.getComics()
            } else {
                self.mainPresenter?.searchComics(query: query)
            }
        }
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mainPresenter?.getItemsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: ComicBookTableViewCell.reuseIdentifier(), for: indexPath) as? ComicBookTableViewCell,
            let model = self.mainPresenter?.getItemAtPosition(index: indexPath.row)
        else { return UITableViewCell() }
        
        cell.setupCell(model: model)
        
        return cell
    }
}

extension MainViewController: MainView {
    func updateTableView() {
        self.emptyView.isHidden = true
        self.tableView.isHidden = false
        self.tableView.reloadData()
    }
    
    func displayError() {
        let alertController = UIAlertController(title: "", message: NSLocalizedString("error.message", comment: ""), preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default, handler: { (alert) in
            alertController.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func emptyResults() {
        self.emptyView.isHidden = false
        self.tableView.isHidden = true
    }
    
    func showLoader() {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
    }
    
    func hideLoader() {
        self.activityIndicator.isHidden = true
        self.activityIndicator.stopAnimating()
    }
}

extension MainViewController: UISearchControllerDelegate {
    
}

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text else { return }
        self.mainPresenter?.searchComics(query: query)
    }
}
