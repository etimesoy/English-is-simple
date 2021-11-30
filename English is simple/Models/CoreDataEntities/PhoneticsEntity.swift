//
//  PhoneticsEntity+CoreDataClass.swift
//  
//
//  Created by Руслан on 27.11.2021.
//
//

import CoreData

@objc(PhoneticsEntity)
public class PhoneticsEntity: NSManagedObject {

}

extension PhoneticsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhoneticsEntity> {
        return NSFetchRequest<PhoneticsEntity>(entityName: "PhoneticsEntity")
    }

    @NSManaged public var audio: String?
    @NSManaged public var text: String?
    @NSManaged public var word: WordEntity?

}
