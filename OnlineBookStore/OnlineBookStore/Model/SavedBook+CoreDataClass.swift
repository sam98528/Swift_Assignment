//
//  SavedBook+CoreDataClass.swift
//  OnlineBookStore
//
//  Created by Sam.Lee on 5/7/24.
//
//

import Foundation
import CoreData

@objc(SavedBook)
public class SavedBook: NSManagedObject {

    func typeCasting() -> Book{
        var tempBook = Book(
            title: self.title ?? "",
            contents: self.contents ?? "",
            url: self.url ?? "",
            authors: self.authors ?? [],
            publisher: self.publisher ?? "",
            price: Int(self.price),
            salePrice: Int(self.salePrice),
            thumbnail: self.thumbnail ?? "",
            status: self.status ?? ""
        )
        return tempBook
    }
}
