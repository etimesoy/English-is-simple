//
//  Word.swift
//  English is simple
//
//  Created by Руслан on 27.11.2021.
//

import Foundation

struct Word: Codable {
    let word: String
    let phonetic: String?
    let phonetics: [Phonetics]
    let origin: String?
    let meanings: [Meaning]
}

struct Phonetics: Codable {
    let text: String?
    let audio: String?
}

struct Meaning: Codable {
    let partOfSpeech: String
    let definitions: [Definition]
}

struct Definition: Codable {
    let definition: String
    let example: String?
    let synonyms: [String]
    let antonyms: [String]
}
