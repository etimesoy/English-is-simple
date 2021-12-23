//
//  NetworkService.swift
//  English is simple
//
//  Created by Руслан on 27.11.2021.
//

import Foundation

final class NetworkService: NetworkServiceProtocol {

    // MARK: - Properties
    static let shared: NetworkServiceProtocol = NetworkService(sessionConfiguration: URLSessionConfiguration.default)
    private let decoder = JSONDecoder()
    private let sessionConfiguration: URLSessionConfiguration

    // MARK: - Initializers
    private init(sessionConfiguration: URLSessionConfiguration) {
        self.sessionConfiguration = sessionConfiguration
    }

    // MARK: - Public methods
    func getWordInfo(word: String, completion: @escaping (Result<[Word], NetworkError>) -> Void) {
        let session = URLSession(configuration: sessionConfiguration)
        let URLString = "https://api.dictionaryapi.dev/api/v2/entries/en/\(word)"
        let wordInfoURL = URL(string: URLString)
        guard let wordInfoURL = wordInfoURL else {
            completion(.failure(.invalidURLStringError(URLString)))
            return
        }

        var request = URLRequest(url: wordInfoURL)
        request.cachePolicy = .reloadIgnoringLocalCacheData
        request.httpMethod = "GET"

        session.dataTask(with: request) { [weak self] data, response, error in
            let result: Result<[Word], NetworkError>
            guard let self = self else {
                completion(.failure(.networkServiceError))
                return
            }
            if let error = error {
                result = .failure(.dataTaskError(error))
            } else if let data = data {
                do {
                    let words = try self.decoder.decode([Word].self, from: data)
                    result = .success(words)
                } catch {
                    result = .failure(.decodeError(error))
                }
            } else {
                result = .failure(.noDataError)
            }
            completion(result)
        }.resume()
    }

}
