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
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
        self.setupTableView()
        self.setupSearchController()
        
        self.initData()
    }
    
    private func setupViews() {
        self.topLabel.text = NSLocalizedString("main.title", comment: "")
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
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func initData() {
        self.mainPresenter?.mainView = self
        self.mainPresenter?.getComics()
    }
}

extension MainViewController: UITableViewDelegate {
    
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ComicBookTableViewCell.reuseIdentifier(), for: indexPath) as? ComicBookTableViewCell else { return UITableViewCell() }
        
        return cell
    }
}

extension MainViewController: MainView {
    func updateTableView() {
        
    }
    
    func displayError() {
        
    }
    
    func emptyResults() {
        
    }
}

extension MainViewController: UISearchControllerDelegate {
    
}

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
