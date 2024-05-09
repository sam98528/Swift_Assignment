import UIKit
import CoreData

class CoredataManager{
    static let shared: CoredataManager = CoredataManager()
    
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    let modelName : String = "SavedBook"
    let request = SavedBook.fetchRequest()
    func getBooks(ascending: Bool = false) -> [SavedBook] {
        var models: [SavedBook] = [SavedBook]()
        
        if let context = context {
            let titleSort : NSSortDescriptor = NSSortDescriptor(key: "title", ascending: ascending)
            let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest<NSManagedObject>(entityName: modelName)
            fetchRequest.sortDescriptors = [titleSort]
            
            do {
                if let fetchResult: [SavedBook] = try context.fetch(fetchRequest)as? [SavedBook]{
                    models = fetchResult
                }
            }catch let error as NSError {
                print("Fetch error : \(error), \(error.userInfo)")
            }
        }
        return models
    }
    func saveBook(bookToSave : Book){
        if let context = context, let entity : NSEntityDescription
            = NSEntityDescription.entity(forEntityName: modelName, in: context){
            if let savedBook: SavedBook = NSManagedObject(entity: entity, insertInto: context) as? SavedBook{
                savedBook.title = bookToSave.title
                savedBook.authors = bookToSave.authors
                savedBook.contents = bookToSave.contents
                savedBook.price = Int64(bookToSave.price)
                savedBook.salePrice = Int64(bookToSave.salePrice)
                savedBook.thumbnail = bookToSave.thumbnail
                savedBook.status = bookToSave.status
                savedBook.publisher = bookToSave.publisher
                savedBook.url = bookToSave.url
                
                do{
                    try context.save()
                    NotificationCenter.default.post(name: Notification.Name.bookAdd, object: nil,userInfo: [NotificationKey.title : savedBook.title ?? ""])
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func deleteBook(bookToDelete : SavedBook){
        if let context = context{
            if let allSavedBooks = try? context.fetch(request) {
                let filteredBook = allSavedBooks.filter{$0.title == bookToDelete.title}
                
                for book in filteredBook{
                    context.delete(book)
                }
                try? context.save()
                NotificationCenter.default.post(name: Notification.Name.bookDelete, object: nil)
            }
        }
    }
    
    func deleteAllBook(){
        if let context = context{
            if let allSavedBooks = try? context.fetch(request) {
                for book in allSavedBooks{
                    context.delete(book)
                }
                try? context.save()
                NotificationCenter.default.post(name: Notification.Name.bookDelete, object: nil)
            }
        }
    }
    
}
