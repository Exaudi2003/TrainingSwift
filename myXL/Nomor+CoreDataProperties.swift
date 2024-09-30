//
//  Nomor+CoreDataProperties.swift
//  myXL
//
//  Created by Aleph-VHV29 on 25/09/24.
//
//

import Foundation
import CoreData


extension Nomor {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Nomor> {
        return NSFetchRequest<Nomor>(entityName: "Nomor")
    }

    @NSManaged public var msisdn: String?

}

extension Nomor : Identifiable {

}
