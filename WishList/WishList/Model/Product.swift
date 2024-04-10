//
//  Product.swift
//  WishList
//
//  Created by Sam.Lee on 4/9/24.
//

import Foundation
import UIKit

struct Product : Codable {
    var id : Int
    var title : String
    var description : String
    var price : Int
    var rating : Double
    var brand : String
    var category : String
    var thumbnail : String
    var images : [String]
    
    
    func addCommas(to number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: number)) ?? ""
    }
}

