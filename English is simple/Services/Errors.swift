//
//  Errors.swift
//  English is simple
//
//  Created by Руслан on 28.11.2021.
//

import Foundation

enum NetworkError: Error {
    case invalidURLStringError(String)
    case networkServiceError
    case dataTaskError(Error)
    case noDataError
    case decodeError(Error)
}
