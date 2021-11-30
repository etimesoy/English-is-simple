//
//  PersistableService.swift
//  English is simple
//
//  Created by Руслан on 27.11.2021.
//

import CoreData

final class PersistableService: PersistableServiceProtocol {

    // MARK: - Properties
    static let shared: PersistableServiceProtocol = PersistableService()
    private let userDefaultsIsNotFirstOpeningOfTheApplicationKey = "isNotFirstOpening"
    
    // MARK: - Core Data stack
    lazy private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "English_is_simple")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy private var viewContext = persistentContainer.viewContext

    // MARK: - Core Data Saving support
    private func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Private methods
    private func convertToWord(from wordEntity: WordEntity) -> Word {
        let word = wordEntity.word
        let phonetic = wordEntity.phonetic
        let phonetics: [Phonetics] = wordEntity.phonetics.map { phoneticsEntity in
            return Phonetics(text: phoneticsEntity.text, audio: phoneticsEntity.audio)
        }
        let origin = wordEntity.origin
        let meanings: [Meaning] = wordEntity.meanings.map { meaningEntity in
            
            let partOfSpeech = meaningEntity.partOfSpeech
            let definitions: [Definition] = meaningEntity.definitions.map { definitionEntity in
                
                let definition = definitionEntity.definition
                let example = definitionEntity.example
                let synonyms = definitionEntity.synonyms.map { synonymEntity in
                    return synonymEntity.value
                }
                let antonyms = definitionEntity.antonyms.map { antonymEntity in
                    return antonymEntity.value
                }
                return Definition(definition: definition, example: example,
                                  synonyms: synonyms, antonyms: antonyms)
            }
            return Meaning(partOfSpeech: partOfSpeech, definitions: definitions)
        }
        return Word(word: word, phonetic: phonetic, phonetics: phonetics,
                    origin: origin, meanings: meanings)
    }
    
    // MARK: - Public methods
    func saveWord(_ word: Word) {
        let wordEntity = WordEntity(context: viewContext)
        wordEntity.word = word.word
        wordEntity.phonetic = word.phonetic
        wordEntity.origin = word.origin
        
        word.phonetics.forEach { phonetics in
            let phoneticsEntity = PhoneticsEntity(context: viewContext)
            phoneticsEntity.text = phonetics.text
            phoneticsEntity.audio = phonetics.audio
            wordEntity.addToPhonetics(phoneticsEntity)
        }
        
        word.meanings.forEach { meaning in
            let meaningEntity = MeaningEntity(context: viewContext)
            meaningEntity.partOfSpeech = meaning.partOfSpeech
            
            meaning.definitions.forEach { definition in
                let definitionEntity = DefinitionEntity(context: viewContext)
                definitionEntity.definition = definition.definition
                definitionEntity.example = definition.example
                
                definition.synonyms.forEach { synonym in
                    let synonymEntity = SynonymEntity(context: viewContext)
                    synonymEntity.value = synonym
                    definitionEntity.addToSynonyms(synonymEntity)
                }
                
                definition.antonyms.forEach { antonym in
                    let antonymEntity = AntonymEntity(context: viewContext)
                    antonymEntity.value = antonym
                    definitionEntity.addToAntonyms(antonymEntity)
                }
                
                meaningEntity.addToDefinitions(definitionEntity)
            }
            
            wordEntity.addToMeanings(meaningEntity)
        }
        
        saveContext()
    }
    
    func fetchWords(beginWith wordPart: String?) -> [Word] {
        let fetchRequest = WordEntity.fetchRequest()
        if let wordPart = wordPart {
            fetchRequest.predicate = NSPredicate(format: "word BEGINSWITH[c] %@", wordPart)
        }
        
        do {
            let wordEntities = try viewContext.fetch(fetchRequest)
            return wordEntities.map { wordEntity in
                return convertToWord(from: wordEntity)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return []
    }
    
    func deleteWord(named word: String) -> Bool {
        let fetchRequest = WordEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "word == %@", word)
        do {
            let words = try viewContext.fetch(fetchRequest)
            if let wordEntity = words.first {
                viewContext.delete(wordEntity)
                saveContext()
                return true
            }
        } catch {
            print(error.localizedDescription)
        }
        return false
    }
    
    func isFirstOpeningOfTheApplication() -> Bool {
        let userDefaults = UserDefaults.standard
        let isNotFirstOpening = userDefaults.bool(forKey: userDefaultsIsNotFirstOpeningOfTheApplicationKey)
        if !isNotFirstOpening {
            userDefaults.set(true, forKey: userDefaultsIsNotFirstOpeningOfTheApplicationKey)
        }
        return !isNotFirstOpening
    }

}
