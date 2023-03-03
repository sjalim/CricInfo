//
//  CoreDataManager.swift
//  CricInfo
//
//  Created by bjit on 21/2/23.
//

import Foundation
import CoreData
import UIKit


class CoreDataManager{
    
    
    static let shared = CoreDataManager()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private init() {}
    
    
    func isCoreDataEmpty() -> Bool{
        
        let playerList = CoreDataManager.shared.getSearchData(searchText: "A")
        
        guard let dataList = playerList else {
            return true
        }
        
        if dataList.isEmpty {
            return true
        }
        
        return false
    }
    
    
    
    func getSearchData(searchText: String) -> [PlayerDataEntity]?
    {
        let fetchRequest = NSFetchRequest<PlayerDataEntity>(entityName: "PlayerDataEntity")
        let predicate = NSPredicate(format: "fullName CONTAINS[c] %@", searchText)
        fetchRequest.predicate = predicate
        fetchRequest.fetchLimit = 20
        
        
        var result = [PlayerDataEntity]()

        do {
            result = try context.fetch(fetchRequest)
            
            return result
        } catch {
            print(error)
            return nil
        }
    }
    
    func addItems(data Players: [DatumPlayer]) {
        
        let defaults = UserDefaults.standard
        defaults.set(false, forKey: Constants.shared.DarkMode)

           guard let entity = NSEntityDescription.entity(forEntityName: "PlayerDataEntity", in: context) else {
               return
           }

        for item in Players{
               let dataObject = NSManagedObject(entity: entity, insertInto: context)
               dataObject.setValue(item.id, forKey: "id")
               dataObject.setValue(item.fullname, forKey: "fullName")
               dataObject.setValue(item.imagePath, forKey: "imagePath")
           }

           do {
               try context.save()
           } catch let error as NSError {
               print("Could not save. \(error), \(error.userInfo)")
           }
       }
    
    
}
