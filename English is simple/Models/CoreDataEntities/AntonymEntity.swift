//
//  AntonymEntity+CoreDataClass.swift
//  
//
//  Created by Руслан on 27.11.2021.
//
//

import CoreData

@objc(AntonymEntity)
public class AntonymEntity: NSManagedObject {

}

extension AntonymEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AntonymEntity> {
        return NSFetchRequest<AntonymEntity>(entityName: "AntonymEntity")
    }

    @NSManaged public var value: String
    @NSManaged public var definition: DefinitionEntity?

}
