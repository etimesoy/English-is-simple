//
//  WordsViewController.swift
//  English is simple
//
//  Created by Руслан on 28.11.2021.
//

import UIKit

class WordsViewController: UIViewController {

    // MARK: - UI
    lazy final var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Enter word"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        return searchController
    }()

    // MARK: - Properties
    final var words: [Word] = []
    final let interactor = Interactor()

    // MARK: - Table view builder
    final func createWordsTableView() -> UITableView {
        let tableView = UITableView()
        tableView.rowHeight = 40
        tableView.layoutMargins = .zero
        tableView.separatorInset = .zero
        tableView.register(WordsTableViewCell.self,
                           forCellReuseIdentifier: WordsTableViewCell.reuseIdentifier)
        return tableView
    }

    // MARK: - Layout methods
    func configureLayout(for tableView: UITableView) {
        view.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.left.top.right.equalTo(view.safeAreaLayoutGuide).inset(5)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

}

// MARK: - Table view data source methods
extension WordsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: WordsTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? WordsTableViewCell else {
            return UITableViewCell()
        }
        let cellData = WordsTableCellData(
            word: words[indexPath.row].word,
            phonetic: words[indexPath.row].phonetic,
            audioURL: words[indexPath.row].phonetics.first?.audio
        )
        cell.configure(with: cellData)
        return cell
    }

}

// MARK: - Search bar delegate methods
extension WordsViewController: UISearchBarDelegate {

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBar.showsCancelButton = false
    }

}

