//
//  SavedBook+CoreDataProperties.swift
//  OnlineBookStore
//
//  Created by Sam.Lee on 5/7/24.
//
//

import Foundation
import CoreData


extension SavedBook {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedBook> {
        return NSFetchRequest<SavedBook>(entityName: "SavedBook")
    }

    @NSManaged public var title: String?
    @NSManaged public var contents: String?
    @NSManaged public var url: String?
    @NSManaged public var authors: [String]?
    @NSManaged public var publisher: String?
    @NSManaged public var price: Int64
    @NSManaged public var salePrice: Int64
    @NSManaged public var thumbnail: String?
    @NSManaged public var status: String?

}

extension SavedBook : Identifiable {

}
