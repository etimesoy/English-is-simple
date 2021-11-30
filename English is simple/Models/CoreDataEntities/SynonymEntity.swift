//
//  SynonymEntity+CoreDataClass.swift
//  
//
//  Created by Руслан on 27.11.2021.
//
//

import CoreData

@objc(SynonymEntity)
public class SynonymEntity: NSManagedObject {

}

extension SynonymEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SynonymEntity> {
        return NSFetchRequest<SynonymEntity>(entityName: "SynonymEntity")
    }

    @NSManaged public var value: String
    @NSManaged public var definition: DefinitionEntity?

}
