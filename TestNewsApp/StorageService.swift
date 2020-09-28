//
//  StorageService.swift
//  TestNewsApp
//
//  Created by Станислав Климов on 28.09.2020.
//

import Foundation
import CoreData

class StorageManager {
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    private var persistentContainer: NSPersistentContainer = {
           let container = NSPersistentContainer(name: "TestNewsApp")
           container.loadPersistentStores(completionHandler: { (storeDescription, error) in
               if let error = error as NSError? {
                   fatalError("Unresolved error \(error), \(error.userInfo)")
               }
           })
           return container
       }()
    
    func addNewsToStorage(with articles: [Article]) {
        guard let data = try? JSONEncoder().encode(articles) else { return }
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "News", in: context) else { return }
        guard let news = NSManagedObject(entity: entityDescription, insertInto: context) as? News else { return }
        news.newsData = data
        do {
            try context.save()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}
