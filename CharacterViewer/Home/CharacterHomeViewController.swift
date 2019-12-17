//
//  HomeViewController.swift
//  SimpsonsViewer
//
//  Created by Sultan Sultan on 12/14/19.
//  Copyright © 2019 Sultan Sultan. All rights reserved.
//

import UIKit

protocol CellSelectionDelegate: class {
    func cellSelected(with data: Character?)
}

enum AppType: String { // TODO:- Fix me
  case wire = "Wire"
  case simpsons = "Simpsons"
}

class CharacterHomeViewController: UITableViewController {
    // Mark: Properties
    let viewModel = CharacterHomeViewModel()
    
    var charactersArray = [Character]()
  
    var filteredData = [String]()
    weak var delegate: CellSelectionDelegate?
    var characterNames: [String] = [] {
          didSet {
              filteredData = characterNames
              self.tableView.reloadData()
          }
      }

     let networkManager = NetworkManager.sharedInstance
    
    fileprivate let searchController = UISearchController(searchResultsController: nil)

    // MARK: - Table View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true

        // TODO:- set the page title based on the scheme
        switch Config.appType {
        case "Wire": self.title = "Wire"
        case "Simpsons" : self.title = "Simpsons"
        default:
            return self.title = "UnKnown"
        }
        
        // Setup the search bar
        setupSearchBar()
      
        tableView.delegate = self
        tableView.dataSource = self
        searchController.obscuresBackgroundDuringPresentation = false
        viewModel.delegate = self
        viewModel.fetchAllCharacters()
        
         }
    
    fileprivate func setupSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
    }
  
}
// MARK: - Table view data source
extension CharacterHomeViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = filteredData[indexPath.row]
        return cell
    }
}

// Mark: - Table View delegate
extension CharacterHomeViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = charactersArray[indexPath.row]
        delegate?.cellSelected(with: selectedCell)
         if
         let detailsViewController = delegate as? CharacterDetailsViewController,
         let detailNavigationController = detailsViewController.navigationController {
           splitViewController?.showDetailViewController(detailNavigationController, sender: nil)
        }
    }
}

// Mark:- SearchBar Delegate Methods
extension CharacterHomeViewController: UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {

         if let searchText = searchController.searchBar.text {
               filteredData = searchText.isEmpty ? characterNames : characterNames.filter({(dataString: String) -> Bool in
                return dataString.range(of: searchText, options: .caseInsensitive) != nil
               })
               tableView.reloadData()
           }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            self.searchController.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.showsCancelButton = false
            searchBar.text = ""
            searchBar.resignFirstResponder()
    }
}

extension CharacterHomeViewController: CharacterViewModelDelegateProtocol {
  func didRecieveData(chararcters: [Character], names: [String]) {
        charactersArray = chararcters
        characterNames  = names
    }
}
