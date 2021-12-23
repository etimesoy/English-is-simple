//
//  DefinitionEntity+CoreDataClass.swift
//  
//
//  Created by Руслан on 27.11.2021.
//
//

import CoreData

@objc(DefinitionEntity)
public class DefinitionEntity: NSManagedObject {

}

extension DefinitionEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DefinitionEntity> {
        return NSFetchRequest<DefinitionEntity>(entityName: "DefinitionEntity")
    }

    @NSManaged public var definition: String?
    @NSManaged public var example: String?
    @NSManaged public var antonyms: Set<AntonymEntity>
    @NSManaged public var synonyms: Set<SynonymEntity>
    @NSManaged public var meaning: MeaningEntity?

}

// MARK: Generated accessors for antonyms
extension DefinitionEntity {

    @objc(addAntonymsObject:)
    @NSManaged public func addToAntonyms(_ value: AntonymEntity)

    @objc(removeAntonymsObject:)
    @NSManaged public func removeFromAntonyms(_ value: AntonymEntity)

    @objc(addAntonyms:)
    @NSManaged public func addToAntonyms(_ values: Set<AntonymEntity>)

    @objc(removeAntonyms:)
    @NSManaged public func removeFromAntonyms(_ values: Set<AntonymEntity>)

}

// MARK: Generated accessors for synonyms
extension DefinitionEntity {

    @objc(addSynonymsObject:)
    @NSManaged public func addToSynonyms(_ value: SynonymEntity)

    @objc(removeSynonymsObject:)
    @NSManaged public func removeFromSynonyms(_ value: SynonymEntity)

    @objc(addSynonyms:)
    @NSManaged public func addToSynonyms(_ values: Set<SynonymEntity>)

    @objc(removeSynonyms:)
    @NSManaged public func removeFromSynonyms(_ values: Set<SynonymEntity>)

}
