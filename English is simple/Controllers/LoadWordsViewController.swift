//
//  LoadWordsViewController.swift
//  English is simple
//
//  Created by Руслан on 27.11.2021.
//

import UIKit
import SnapKit

final class LoadWordsViewController: WordsViewController {

    // MARK: - UI
    lazy private var loadedWordsTableView = createWordsTableView()
    
    // MARK: - Life cycle
    override func loadView() {
        super.loadView()
        
        configureLayout(for: loadedWordsTableView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadedWordsTableView.delegate = self
        loadedWordsTableView.dataSource = self
        
        navigationItem.title = "New words"
    }
    
    // MARK: - Private methods
    private func getNewWordInfo(named wordName: String) {
        if wordName.isEmpty {
            words = []
            loadedWordsTableView.reloadData()
            return
        }
        interactor.getNewWordInfo(named: wordName) { [weak self] words in
            if let words = words, let self = self {
                self.words = words
                self.loadedWordsTableView.reloadData()
            }
        }
    }

}

// MARK: - Table view delegate methods
extension LoadWordsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let alertDescription = "Do you really want to add this word to favourites?"
        showConfirmationAlert(title: "Add word",
                              description: alertDescription) { alertAction in
            self.interactor.saveNewWord(word: self.words[indexPath.row])
        }
    }

}

// MARK: - Search bar delegate methods
extension LoadWordsViewController {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        getNewWordInfo(named: searchText)
    }

}
