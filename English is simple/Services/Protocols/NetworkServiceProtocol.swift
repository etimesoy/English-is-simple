//
//  NetworkServiceProtocol.swift
//  English is simple
//
//  Created by Руслан on 30.11.2021.
//

import Foundation

protocol NetworkServiceProtocol {

    // MARK: - Properties
    static var shared: NetworkServiceProtocol { get }

    // MARK: - Methods
    func getWordInfo(word: String, completion: @escaping (Result<[Word], NetworkError>) -> Void)

}
