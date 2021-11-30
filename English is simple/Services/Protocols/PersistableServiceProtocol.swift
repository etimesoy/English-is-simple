//
//  PersistableServiceProtocol.swift
//  English is simple
//
//  Created by Руслан on 30.11.2021.
//

import Foundation

protocol PersistableServiceProtocol {

    // MARK: - Properties
    static var shared: PersistableServiceProtocol { get }

    // MARK: - Methods
    func saveWord(_ word: Word)
    func fetchWords(beginWith wordPart: String?) -> [Word]
    func deleteWord(named word: String) -> Bool
    func isFirstOpeningOfTheApplication() -> Bool

}
