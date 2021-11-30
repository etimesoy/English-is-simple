//
//  SavedWordsViewController.swift
//  English is simple
//
//  Created by Руслан on 27.11.2021.
//

import UIKit
import SnapKit

final class SavedWordsViewController: WordsViewController {

    // MARK: - Views
    lazy private var savedWordsTableView = createWordsTableView()

    // MARK: - Life cycle
    override func loadView() {
        super.loadView()
        
        configureLayout(for: savedWordsTableView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        savedWordsTableView.delegate = self
        savedWordsTableView.dataSource = self
        
        navigationItem.title = "Saved words"
        obtainSavedWords(wordPart: nil)
        
        if interactor.onboardingShouldBeShown {
            // TODO: показать онбординг
            print("show onboarding")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        interactor.getSavedWords(startWith: nil) { [weak self] words in
            guard let self = self else { return }
            self.words = words
        }
        savedWordsTableView.reloadData()
    }
    
    // MARK: - Private methods
    private func obtainSavedWords(wordPart: String?) {
        interactor.getSavedWords(startWith: wordPart) { [weak self] words in
            guard let self = self else { return }
            
            self.words = words
            self.savedWordsTableView.reloadData()
        }
    }

}

// MARK: - Table view delegate methods
extension SavedWordsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive,
                                              title: "Delete") { [weak self] (contextualAction, view, nil) in
            guard let self = self else { return }
            self.interactor.deleteSavedWord(
                named: self.words[indexPath.row].word
            ) { deletedSuccessfully in
                if deletedSuccessfully {
                    tableView.performBatchUpdates {
                        self.words.remove(at: indexPath.row)
                        self.savedWordsTableView.deleteRows(at: [indexPath], with: .automatic)
                    }
                }
            }
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

}

// MARK: - Search bar delegate methods
extension SavedWordsViewController {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let wordPart = searchText.isEmpty ? nil : searchText
        obtainSavedWords(wordPart: wordPart)
    }

}
