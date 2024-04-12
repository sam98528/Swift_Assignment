//
//  CoreDataManger.swift
//  WishList
//
//  Created by Sam.Lee on 4/12/24.
//

import Foundation
import UIKit
import CoreData


class CoreDataManger {
    var persistentContainer : NSPersistentContainer? {
        (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    }
    let request = WishProduct.fetchRequest()
    
    func getCurrentCount() -> Int{
        guard let context = persistentContainer?.viewContext else {return 0}
        guard let wishes = try? context.fetch(request) else {return 0}
        return wishes.count
    }
    
    func getCurrnetData() -> [WishProduct]{
        guard let context = persistentContainer?.viewContext else {return []}
        guard let wishes = try? context.fetch(request) else {return []}
        return wishes.sorted{$0.id < $1.id}
    }
    
    func saveData(product : Product?, alert: () -> Void, finished: () -> Void) {
        guard let context = persistentContainer?.viewContext else {return}
        guard let wishes = try? context.fetch(request) else {return}
        guard let id = product?.id, let price = product?.price, let title = product?.title else{
            return
        }
        if wishes.contains(where: {$0.id == Int64(id)}) {
            alert()
            return
        }else{
            let newWishProduct = WishProduct(context : context)
            newWishProduct.id = Int64(id)
            newWishProduct.price = Int64(price)
            newWishProduct.title = title
            try? context.save()
            finished()
        }
    }
    
    func deleteData(product : WishProduct){
        guard let context = persistentContainer?.viewContext else {return}
        guard let wishes = try? context.fetch(request) else {return}
        let filteredWishes = wishes.filter{$0.id == product.id}
        
        for wish in filteredWishes {
            context.delete(wish)
        }
        try? context.save()
    }
}
