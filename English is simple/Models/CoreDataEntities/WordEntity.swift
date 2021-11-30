//
//  WordEntity+CoreDataClass.swift
//  
//
//  Created by Руслан on 27.11.2021.
//
//

import CoreData

@objc(WordEntity)
public class WordEntity: NSManagedObject {

}

extension WordEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WordEntity> {
        return NSFetchRequest<WordEntity>(entityName: "WordEntity")
    }

    @NSManaged public var origin: String?
    @NSManaged public var phonetic: String?
    @NSManaged public var word: String
    @NSManaged public var meanings: Set<MeaningEntity>
    @NSManaged public var phonetics: Set<PhoneticsEntity>

}

// MARK: Generated accessors for meanings
extension WordEntity {

    @objc(addMeaningsObject:)
    @NSManaged public func addToMeanings(_ value: MeaningEntity)

    @objc(removeMeaningsObject:)
    @NSManaged public func removeFromMeanings(_ value: MeaningEntity)

    @objc(addMeanings:)
    @NSManaged public func addToMeanings(_ values: Set<MeaningEntity>)

    @objc(removeMeanings:)
    @NSManaged public func removeFromMeanings(_ values: Set<MeaningEntity>)

}

// MARK: Generated accessors for phonetics
extension WordEntity {

    @objc(addPhoneticsObject:)
    @NSManaged public func addToPhonetics(_ value: PhoneticsEntity)

    @objc(removePhoneticsObject:)
    @NSManaged public func removeFromPhonetics(_ value: PhoneticsEntity)

    @objc(addPhonetics:)
    @NSManaged public func addToPhonetics(_ values: Set<PhoneticsEntity>)

    @objc(removePhonetics:)
    @NSManaged public func removeFromPhonetics(_ values: Set<PhoneticsEntity>)

}
