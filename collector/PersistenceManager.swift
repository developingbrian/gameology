//
//  PersistenceManager.swift
//  collector
//
//  Created by Brian on 10/3/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import Foundation
import CoreData

final class PersistenceManager {
    
    private init() {}
    static let shared = PersistenceManager()
    
    // MARK: - Core Data stack
    
    
    lazy var persistenceContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Collector")
        container.loadPersistentStores(completionHandler: { (storedDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error: \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    lazy var context = persistenceContainer.viewContext // MARK: - define
    
    // MARK: - Core Data Saving Support
    
    func save() {
        let context = persistenceContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("saved successfully")
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    
    func delete(_ object: NSManagedObject) {
        context.delete(object)
        do {
           try context.save()
            print("deleted successfully")
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    func fetch<T: NSManagedObject>(_ objectType: T.Type) -> [T] {
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            return fetchedObjects ?? [T]()
        } catch {
            print("error")
            return [T]()
        }
    }
    
    func fetchAscending<T: NSManagedObject>(_ objectType: T.Type) -> [T] {
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let sortAscending = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortAscending]
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            return fetchedObjects ?? [T]()
        } catch {
            print("error")
            return [T]()
        }
    
        
    }
    
    
    func fetchPlatformsAscending<T: NSManagedObject>(_ objectType: T.Type) -> [T] {
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let sortAscending = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortAscending]
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            return fetchedObjects ?? [T]()
        } catch {
            print("error")
            return [T]()
        }
    
        
    }
    
    func fetchFilteredByPlatform<T: NSManagedObject>(_ objectType: T.Type, platformID: Int) -> [T]{
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let filterPredicate = NSPredicate(format: "id == \(Int64(platformID))")
        let sortAscending = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.predicate = filterPredicate
        fetchRequest.sortDescriptors = [sortAscending]
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            return fetchedObjects ?? [T]()
        } catch {
            print("error")
            return [T]()
        }
    
        
        
    }
    
    
    func fetchFilteredByName<T: NSManagedObject>(_ objectType: T.Type, name: String, platformID: Int) -> [T]{
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        var filterPredicate : NSPredicate?
        if platformID != 0 {
         filterPredicate = NSPredicate(format: "title CONTAINS [c] %@ AND platformID == %i", name, platformID)
        } else {
            filterPredicate = NSPredicate(format: "title CONTAINS [c] %@", name)

            
        }
        
        let sortAscending = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.predicate = filterPredicate
        fetchRequest.sortDescriptors = [sortAscending]
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            return fetchedObjects ?? [T]()
        } catch {
            print("error")
            return [T]()
        }
    
        
        
    }
    
    func fetchFilteredByGenre<T: NSManagedObject>(_ objectType: T.Type, genres: [String]?) -> [T] {
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        let filterPredicates = genres!.map {
            NSPredicate(format: "genre CONTAINS %@", $0)
        }
        let filterPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: filterPredicates)
        let sortAscending = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.predicate = filterPredicate
        fetchRequest.sortDescriptors = [sortAscending]
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            return fetchedObjects ?? [T]()
        } catch {
            print("error")
            return [T]()
        }
    }
    
    func fetchFilteredByGenreByPlatform<T: NSManagedObject>(_ objectType: T.Type, genres: [String]?, platformID: Int) -> [T] {
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        var filterPredicates : [NSPredicate]?
        filterPredicates = genres!.map {
            NSPredicate(format: "genre CONTAINS %@", $0)
        }
        let platformPredicate = NSPredicate(format: "id == \(Int32(platformID))")

        filterPredicates?.append(platformPredicate)
        let filterPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: filterPredicates!)
        let sortAscending = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.predicate = filterPredicate
        fetchRequest.sortDescriptors = [sortAscending]
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            return fetchedObjects ?? [T]()
        } catch {
            print("error")
            return [T]()
        }
    }
    
    
//    func fetchGames<object: NSManagedObject>(objectType: object.Type, filterOptions: [String]?, platformID: Int?) {
//        let entityName = String(describing: objectType)
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
//        
//        let filterPredicates : [NSPredicate]?
//        
//        
//        if filterOptions != nil {
//            filterPredicates = filterOptions.map(<#T##transform: ([String]) throws -> U##([String]) throws -> U#>)
//            
//        }
//        
//    }
//
    
    
    func fetchSortByReleaseDate<T: NSManagedObject>(_ objectType: T.Type, platformID: Int) -> [T]{
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let filterPredicate = NSPredicate(format: "releaseDate == \(Int32(platformID))")
        let sortAscending = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.predicate = filterPredicate
        fetchRequest.sortDescriptors = [sortAscending]
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            return fetchedObjects ?? [T]()
        } catch {
            print("error")
            return [T]()
        }
    
        
        
    }
    
    func fetchSortByReleaseDateByPlatform<T: NSManagedObject>(_ objectType: T.Type, platformID: Int) -> [T]{
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let filterPredicate = NSPredicate(format: "releaseDate == \(Int32(platformID))")
        let sortAscending = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.predicate = filterPredicate
        fetchRequest.sortDescriptors = [sortAscending]
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            return fetchedObjects ?? [T]()
        } catch {
            print("error")
            return [T]()
        }
    
        
        
    }
    
    
    
    
    
    
    
    
    func fetchGameFilteredByPlatform<T: NSManagedObject>(_ objectType: T.Type, platformID: Int) -> [T]{
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let filterPredicate = NSPredicate(format: "platformID == \(Int32(platformID))")
        let sortAscending = NSSortDescriptor(key: "title", ascending: true)
        print("filterPredicates \(filterPredicate)")
        fetchRequest.predicate = filterPredicate
        fetchRequest.sortDescriptors = [sortAscending]
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            return fetchedObjects ?? [T]()
        } catch {
            print("error")
            return [T]()
        }
    
        
        
    }
    
    
    func fetchFilteredByPlayers<T: NSManagedObject>(_ objectType: T.Type, platformID: Int?, playerRange: [Int]?) -> [T]{
        
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let filterPredicate : NSPredicate?
        let sortAscending : NSSortDescriptor?
        let startNum = Int32((playerRange?.first)!)
        let endNum = Int32((playerRange?.last)!)
        
        if platformID != nil {
            
            if playerRange != nil{
                
                if platformID != 0 {
                    filterPredicate = NSPredicate(format: "(maxPlayers >= %i) AND (maxPlayers <= %i) AND platformID == %i", startNum, endNum, Int32(platformID!))
                    
                } else {
                    filterPredicate = NSPredicate(format: "(maxPlayers >= %i) AND (maxPlayers <= %i)", startNum, endNum)
                }
                
                sortAscending = NSSortDescriptor(key: "title", ascending: true)
                fetchRequest.predicate = filterPredicate
                fetchRequest.sortDescriptors = [sortAscending!]
              
                
                
            }
            
            
        
    }
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            return fetchedObjects ?? [T]()
        } catch {
            print("error")
            return [T]()
        }
    }
    
    
    func fetchFilteredByReleaseDate<T: NSManagedObject>(_ objectType: T.Type, platformID: Int?, dateRange: [Int]?) -> [T]{
        
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let filterPredicate : NSPredicate?
        let sortAscending : NSSortDescriptor?
        let startYear = Int32((dateRange?.first)!)
        let endYear = Int32((dateRange?.last)!)
        
        if platformID != nil {
            
            if dateRange != nil{
                
                if platformID != 0 {
                    filterPredicate = NSPredicate(format: "(releaseYear >= %i) AND (releaseYear <= %i) AND platformID == %i", startYear, endYear, Int32(platformID!))
                    
                } else {
                    filterPredicate = NSPredicate(format: "(releaseYear >= %i) AND (releaseYear <= %i)", startYear, endYear)
                }
                
                sortAscending = NSSortDescriptor(key: "title", ascending: true)
                fetchRequest.predicate = filterPredicate
                fetchRequest.sortDescriptors = [sortAscending!]
              
                
                
            }
            
            
      
            
        
    }
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            return fetchedObjects ?? [T]()
        } catch {
            print("error")
            return [T]()
        }
    }
    
    
    func fetchGame<T: NSManagedObject>(_ objectType: T.Type, platformID: Int?, selectedGenres: [String]?) -> [T]{
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let filterPredicate : NSPredicate?
        let sortAscending : NSSortDescriptor?
        if platformID != nil {
            
            if selectedGenres != nil {
                //if we have a platform id and a selected genre:
                
                //compound predicates for platform and selected genre
               
                var filterPredicates : [NSPredicate]?
                
                if platformID != 0 {
                    print("persistenceManager.fetchGame platformID != 0  platformID == \(platformID!)")
                    
                    filterPredicates = selectedGenres!.map {
                        NSPredicate(format: "genre CONTAINS %@ AND platformID == \(platformID!)", $0)
                    }
                    //will filter and present only those platforms that arent id 0 (all platforms)
//                let platformPredicate = NSPredicate(format: "platformID == \(Int64(platformID!))")
//                    filterPredicates.insert(platformPredicate, at: 0)
                print("filterPredicates \(filterPredicates)")
                } else {
                    
                    filterPredicates = selectedGenres!.map {
                        NSPredicate(format: "genre CONTAINS %@", $0)
                    }
                }
                
                filterPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: filterPredicates!)
                sortAscending = NSSortDescriptor(key: "title", ascending: true)
                fetchRequest.predicate = filterPredicate
                fetchRequest.sortDescriptors = [sortAscending!]


            }
            else {
                print("if we have platform id but no selected genre")

                if platformID != 0 {
                filterPredicate = NSPredicate(format: "platformID == \(Int64(platformID!))")
                fetchRequest.predicate = filterPredicate
                }

                sortAscending = NSSortDescriptor(key: "title", ascending: true)
                fetchRequest.sortDescriptors = [sortAscending!]

            }
            
            
            
        } else {
            print("selectedGenres is nil")

            if selectedGenres != nil {
                //predicate for genres but no platform id
                let filterPredicates = selectedGenres!.map {
                    NSPredicate(format: "genre CONTAINS %@", $0)
                }
                filterPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: filterPredicates)
                sortAscending = NSSortDescriptor(key: "title", ascending: true)
                fetchRequest.predicate = filterPredicate
                fetchRequest.sortDescriptors = [sortAscending!]


                }
            
            
        }
   

        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            return fetchedObjects ?? [T]()
        } catch {
            print("error")
            return [T]()
        }
    
        
        
    }
}
