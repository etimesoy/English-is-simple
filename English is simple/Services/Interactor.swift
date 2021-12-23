//
//  Interactor.swift
//  English is simple
//
//  Created by Руслан on 27.11.2021.
//

import Foundation

final class Interactor {

    // MARK: - Properties
    private let networkService: NetworkServiceProtocol = NetworkService.shared
    private let persistableSerice: PersistableServiceProtocol = PersistableService.shared

    var onboardingShouldBeShown: Bool {
        return persistableSerice.isFirstOpeningOfTheApplication()
    }

    // MARK: - Public methods
    func getNewWordInfo(named wordName: String, completion: @escaping ([Word]?) -> Void) {
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 10
        operationQueue.qualityOfService = .userInitiated

        operationQueue.addOperation { [weak self] in
            guard let self = self else { return }
            self.networkService.getWordInfo(word: wordName) { result in
                switch result {
                case .success(let words):
                    DispatchQueue.main.async {
                        completion(words)
                    }
                case .failure(let error):
                    switch error {
                    case .noDataError, .decodeError(_):
                        print("No definitions found for word \(wordName)")
                    default:
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }

    func saveNewWord(word: Word) {
        persistableSerice.saveWord(word)
    }

    func getSavedWords(startWith wordPart: String?, completion: @escaping ([Word]) -> Void) {
        let words = persistableSerice.fetchWords(beginWith: wordPart)
        completion(words)
    }

    func deleteSavedWord(named wordName: String, completion: @escaping (Bool) -> Void) {
        let successfullyDeleted = persistableSerice.deleteWord(named: wordName)
        completion(successfullyDeleted)
    }

}
