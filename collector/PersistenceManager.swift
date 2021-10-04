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
    
    
    func fetchFilteredByGenre<T: NSManagedObject>(_ objectType: T.Type, name: String) -> [T]{
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let filterPredicate = NSPredicate(format: "name == %@", name)
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
    
    func fetchUserPhotos<T: NSManagedObject>(_ objectType: T.Type, category: String, gameTitle: String) -> [T] {
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let filterPredicate = NSPredicate(format: "(category == %@) AND (gameTitle == %@)", category, gameTitle)
        fetchRequest.predicate = filterPredicate
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
//            print("fetchedObjects = \(fetchedObjects?.count)")

            return fetchedObjects ?? [T]()
        } catch {
            print("error")
            return [T]()
        }
        
        
    }
//    
//    func physicalCopyOwned <T: NSManagedObject>(objectType:T.Type, gameTitle: String) -> Bool {
//        let entityName = String(describing: objectType)
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
//        var filterPredicate = NSPredicate(format: "title == %@", gameTitle)
//        fetchRequest.predicate = filterPredicate
//        do {
//            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
//            let object = (fetchedObjects?[0])!
//            if object.
//        } catch {
//
//            print("error")
//        }
//        
//        
//    }
    
    func updateCompletedPercent<T: NSManagedObject>(objectType: T.Type, gameTitle: String, completedValue: Float) {
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let filterPredicate = NSPredicate(format: "title == %@", gameTitle)
        fetchRequest.predicate = filterPredicate
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            let objectUpdate = (fetchedObjects?[0])! as NSManagedObject
//            let object = fetchedObjects?[0]
//            object
            print(completedValue)
            objectUpdate.setValue(completedValue, forKeyPath: "percentComplete")
            print(objectUpdate)
                save()
        } catch {
            
            print("error")
            
        }
    }
    
    func updateGameConditionPercent<T: NSManagedObject>(objectType: T.Type, gameTitle: String, gameCondition: Float) {
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let filterPredicate = NSPredicate(format: "title == %@", gameTitle)
        fetchRequest.predicate = filterPredicate
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            let objectUpdate = (fetchedObjects?[0])! as NSManagedObject
//            let object = fetchedObjects?[0]
//            object
            print(gameCondition)
            objectUpdate.setValue(gameCondition, forKeyPath: "gameCondition")
            print(objectUpdate)
                save()
        } catch {
            
            print("error")
            
        }
    }
    
    func updateBoxConditionPercent<T: NSManagedObject>(objectType: T.Type, gameTitle: String, boxCondition: Float) {
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let filterPredicate = NSPredicate(format: "title == %@", gameTitle)
        fetchRequest.predicate = filterPredicate
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            let objectUpdate = (fetchedObjects?[0])! as NSManagedObject
//            let object = fetchedObjects?[0]
//            object
            print(boxCondition)
            objectUpdate.setValue(boxCondition, forKeyPath: "boxCondition")
            print(objectUpdate)
                save()
        } catch {
            
            print("error")
            
        }
    }
        
        
    func updateManualConditionPercent<T: NSManagedObject>(objectType: T.Type, gameTitle: String, manualCondition: Float) {
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let filterPredicate = NSPredicate(format: "title == %@", gameTitle)
        fetchRequest.predicate = filterPredicate
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            let objectUpdate = (fetchedObjects?[0])! as NSManagedObject
//            let object = fetchedObjects?[0]
//            object
            print(manualCondition)
            objectUpdate.setValue(manualCondition, forKeyPath: "manualCondition")
            print(objectUpdate)
                save()
        } catch {
            
            print("error")
            
        }
    }
   
    func updateGameOwned<T: NSManagedObject>(objectType: T.Type, gameTitle: String, gameOwned: Bool) {
        
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let filterPredicate = NSPredicate(format: "title == %@", gameTitle)
        fetchRequest.predicate = filterPredicate
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            let objectUpdate = (fetchedObjects?[0])! as NSManagedObject
//            let object = fetchedObjects?[0]
//            object
            print(gameOwned)
            objectUpdate.setValue(gameOwned, forKeyPath: "gameOwned")
            print(objectUpdate)
                save()
        } catch {
            
            print("error")
            
        }
    }
    
    func updateBoxOwned<T: NSManagedObject>(objectType: T.Type, gameTitle: String, boxOwned: Bool) {
        
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let filterPredicate = NSPredicate(format: "title == %@", gameTitle)
        fetchRequest.predicate = filterPredicate
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            let objectUpdate = (fetchedObjects?[0])! as NSManagedObject
//            let object = fetchedObjects?[0]
//            object
            print(boxOwned)
            objectUpdate.setValue(boxOwned, forKeyPath: "boxOwned")
            print(objectUpdate)
                save()
        } catch {
            
            print("error")
            
        }
    }
    
    func updateManualOwned<T: NSManagedObject>(objectType: T.Type, gameTitle: String, manualOwned: Bool) {
        
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let filterPredicate = NSPredicate(format: "title == %@", gameTitle)
        fetchRequest.predicate = filterPredicate
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            let objectUpdate = (fetchedObjects?[0])! as NSManagedObject
//            let object = fetchedObjects?[0]
//            object
            print(manualOwned)
            objectUpdate.setValue(manualOwned, forKeyPath: "manualOwned")
            print(objectUpdate)
                save()
        } catch {
            
            print("error")
            
        }
    }
    
    
    func updatePhysicalCopyOwned<T: NSManagedObject>(objectType: T.Type, gameTitle: String, physicalCopy: Bool) {
        
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let filterPredicate = NSPredicate(format: "title == %@", gameTitle)
        fetchRequest.predicate = filterPredicate
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            let objectUpdate = (fetchedObjects?[0])! as NSManagedObject
//            let object = fetchedObjects?[0]
//            object
            print(physicalCopy)
            objectUpdate.setValue(physicalCopy, forKeyPath: "physicalCopy")
            print(objectUpdate)
                save()
        } catch {
            
            print("error")
            
        }
    }
    
    func updateDigitalCopyOwned<T: NSManagedObject>(objectType: T.Type, gameTitle: String, digitalCopy: Bool) {
        
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let filterPredicate = NSPredicate(format: "title == %@", gameTitle)
        fetchRequest.predicate = filterPredicate
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            let objectUpdate = (fetchedObjects?[0])! as NSManagedObject
//            let object = fetchedObjects?[0]
//            object
            print(digitalCopy)
            objectUpdate.setValue(digitalCopy, forKeyPath: "digitalCopy")
            print(objectUpdate)
                save()
        } catch {
            
            print("error")
            
        }
    }
    
    
    func updateBeatStatus<T: NSManagedObject>(objectType: T.Type, gameTitle: String, beat: Bool) {
        
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let filterPredicate = NSPredicate(format: "title == %@", gameTitle)
        fetchRequest.predicate = filterPredicate
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            let objectUpdate = (fetchedObjects?[0])! as NSManagedObject
//            let object = fetchedObjects?[0]
//            object
            print(beat)
            objectUpdate.setValue(beat, forKeyPath: "hasBeaten")
            print(objectUpdate)
                save()
        } catch {
            
            print("error")
            
        }
    }

    func updateCompletedStatus<T: NSManagedObject>(objectType: T.Type, gameTitle: String, completed: Bool) {
        
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let filterPredicate = NSPredicate(format: "title == %@", gameTitle)
        fetchRequest.predicate = filterPredicate
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            let objectUpdate = (fetchedObjects?[0])! as NSManagedObject
//            let object = fetchedObjects?[0]
//            object
            print(completed)
            objectUpdate.setValue(completed, forKeyPath: "hasCompleted")
            print(objectUpdate)
                save()
        } catch {
            
            print("error")
            
        }
    }
    
    
    
    func updatePricePaid<T:NSManagedObject>(objectType: T.Type, gameTitle: String, pricePaid: String) {
        
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let filterPredicate = NSPredicate(format: "title == %@", gameTitle)
        fetchRequest.predicate = filterPredicate
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            let objectUpdate = (fetchedObjects?[0])! as NSManagedObject
//            let object = fetchedObjects?[0]
//            object
            print(pricePaid)
            objectUpdate.setValue(pricePaid, forKeyPath: "pricePaid")
            print(objectUpdate)
                save()
        } catch {
            
            print("error")
            
        }
        
        
    }
    
    func updateNotes<T:NSManagedObject>(objectType: T.Type, gameTitle: String, notes: String) {
        
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let filterPredicate = NSPredicate(format: "title == %@", gameTitle)
        fetchRequest.predicate = filterPredicate
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            let objectUpdate = (fetchedObjects?[0])! as NSManagedObject
//            let object = fetchedObjects?[0]
//            object
            print(notes)
            
            objectUpdate.setValue(notes, forKeyPath: "notes")
            print(objectUpdate)
                save()
        } catch {
            
            print("error")
            
        }
        
        
    }
    
    
    func fetchSingleGameObjectByName<T: NSManagedObject>(_ objectType: T.Type, name: String, platformID: Int) -> [T] {
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        var filterPredicate : NSPredicate?
        filterPredicate = NSPredicate(format: "title == %@ AND platformID == %i", name, platformID)
        fetchRequest.predicate = filterPredicate
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
        if platformID != 0 {
        fetchRequest.predicate = filterPredicate
        }
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
    
    
    func fetchFilteredByReleaseDate<T: NSManagedObject>(_ objectType: T.Type, platformID: Int?, sortBy: String?, dateRange: [Int]?) -> [T]{
        
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let filterPredicate : NSPredicate?
        let sortAscending : NSSortDescriptor?
        let startYear = Int32((dateRange?.first)!)
        let endYear = Int32((dateRange?.last)!)
        
     
            
            if dateRange != nil{
             
                    filterPredicate = NSPredicate(format: "(releaseYear >= %i) AND (releaseYear <= %i)", startYear, endYear)
                
                
                sortAscending = NSSortDescriptor(key: sortBy, ascending: true)
                fetchRequest.predicate = filterPredicate
                fetchRequest.sortDescriptors = [sortAscending!]
              
                
                
            }
            
            
    
            
        
    
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            return fetchedObjects ?? [T]()
        } catch {
            print("error")
            return [T]()
        }
    }
    
    func fetchGenres<T: NSManagedObject>(_ objectType: T.Type, selectedGenres: [String]) -> [T] {
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        var filterPrediate: NSPredicate?
        
        filterPrediate = NSPredicate(format: "%K = %@", #keyPath(GameGenre.name), selectedGenres )
        
        fetchRequest.predicate = filterPrediate
        
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            return fetchedObjects ?? [T]()
        } catch {
            print("error")
            return [T]()
        }
        
    }
    
    
    func fetchGame<T: NSManagedObject>(_ objectType: T.Type, byGameTitle: String?, sortBy: String? , sortByAscending: Bool, platformID: Int?, selectedGenres: [String]?, selectedPlatforms: [Int]?, selectedDateRange: [Int]? ) -> [T]{
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        var filterPredicate : NSPredicate?
        var sortAscending : NSSortDescriptor?
        var platforms : [Int] = []
        var genres : [String] = []
        var dates : [Int] = []
        var title = ""
        var startYear = 0
        var endYear = 0
        
        if let platform = selectedPlatforms{
        platforms = platform
        }
        if let genre = selectedGenres {
            genres = genre
        }
        
        if let date = selectedDateRange {
            dates = date

        }
        if dates.count > 0 {
            startYear = dates.first!
            endYear = dates.last!
        }

        if let sortKey = sortBy {
            
            sortAscending = NSSortDescriptor(key: sortKey, ascending: sortByAscending)
        } else {
            sortAscending = NSSortDescriptor(key: "title", ascending: sortByAscending)
        }

        if let gameTitle = byGameTitle {
            title = gameTitle
        }
        
        
                print("selectedPlatform is", platforms)
                print("selectedGenre is", genres)
                
        switch (dates.isEmpty, platforms.isEmpty, genres.isEmpty, byGameTitle == nil) {
                
                case (true, true, true, true):
                    // all arrays are empty so we don't filter anything and return all SavedGame objects
                    print("all arrays are empty so we don't filter anything and return all SavedGame objects")
                    filterPredicate = NSPredicate(value: true)
                    
                case (true ,true, false, true):
                    // only filter genres
                    print("only filter genres")
                    
                    filterPredicate = NSPredicate(format: "SUBQUERY(%K, $genre, $genre.name IN %@).@count > 0", #keyPath(SavedGames.genreType), genres)

                case (true, false, true, true):
                    // only filter platforms
                    print("only filter platforms")
                    
                    filterPredicate = NSPredicate(format: "%K in %@", argumentArray: [#keyPath(SavedGames.platformID), platforms])
                    
                case (true, false, false, true):
                    // filter both genres and platforms
                    print("filter both genres and platforms")
                    
                    filterPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                        NSPredicate(format: "SUBQUERY(%K, $genre, $genre.name IN %@).@count > 0", #keyPath(SavedGames.genreType), genres),
                        NSPredicate(format: "%K IN %@", argumentArray: [#keyPath(SavedGames.platformID), platforms])
                    ])
                    
                    
                case (true, true, true, false):
                    //Filtering by name only
                    filterPredicate = NSPredicate(format: "%K CONTAINS [c] %@", argumentArray: [#keyPath(SavedGames.title), title])
                    
                    
                case (true, true, false, false):
                    //filtering by name and genre
                    filterPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                        NSPredicate(format: "%K CONTAINS [c] %@", argumentArray: [#keyPath(SavedGames.title), title]),
                        NSPredicate(format: "SUBQUERY(%K, $genre, $genre.name IN %@).@count > 0", #keyPath(SavedGames.genreType), genres)
                    ])
                    
                case (true, false, true, false):
                    //filtering by name and platform
                    filterPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                        NSPredicate(format: "%K CONTAINS [c] %@", argumentArray: [#keyPath(SavedGames.title), title]),
                        NSPredicate(format: "%K in %@", argumentArray: [#keyPath(SavedGames.platformID), platforms])
                    ])
                    
                case (true, false, false, false):
                    //filtering by name, genre, and platform
        
                    filterPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                        NSPredicate(format: "%K CONTAINS [c] %@", argumentArray: [#keyPath(SavedGames.title), title]),
                        NSPredicate(format: "SUBQUERY(%K, $genre, $genre.name IN %@).@count > 0", #keyPath(SavedGames.genreType), genres),
                        NSPredicate(format: "%K IN %@", argumentArray: [#keyPath(SavedGames.platformID), platforms])
                        
                    ])
            case (false, true, true, true):
                //filtering only by date range
                filterPredicate = NSPredicate(format: "(releaseYear >= %i) AND (releaseYear <= %i)", startYear, endYear)
            case (false, false, true, true):
            //filtering by date range and platforms
                filterPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                    NSPredicate(format: "(releaseYear >= %i) AND (releaseYear <= %i)", startYear, endYear),
                    NSPredicate(format: "%K in %@", argumentArray: [#keyPath(SavedGames.platformID), platforms])
                ])
                    
            case (false, false, false, true):
            //filtering by date range, platforms, and genres
                filterPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                    NSPredicate(format: "(releaseYear >= %i) AND (releaseYear <= %i)", startYear, endYear),
                    NSPredicate(format: "%K in %@", argumentArray: [#keyPath(SavedGames.platformID), platforms]),
                    NSPredicate(format: "SUBQUERY(%K, $genre, $genre.name IN %@).@count > 0", #keyPath(SavedGames.genreType), genres)
                ])
            case (false, false, false, false):
            //filtering by date range, platforms, genres, and name
                filterPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                    NSPredicate(format: "(releaseYear >= %i) AND (releaseYear <= %i)", startYear, endYear),
                    NSPredicate(format: "%K in %@", argumentArray: [#keyPath(SavedGames.platformID), platforms]),
                    NSPredicate(format: "SUBQUERY(%K, $genre, $genre.name IN %@).@count > 0", #keyPath(SavedGames.genreType), genres),
                    NSPredicate(format: "%K CONTAINS [c] %@", argumentArray: [#keyPath(SavedGames.title), title])
                ])
            case (false, true, false, false):
            //filtering by date range, genres, and name
                filterPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                    NSPredicate(format: "(releaseYear >= %i) AND (releaseYear <= %i)", startYear, endYear),
                    NSPredicate(format: "SUBQUERY(%K, $genre, $genre.name IN %@).@count > 0", #keyPath(SavedGames.genreType), genres),
                    NSPredicate(format: "%K CONTAINS [c] %@", argumentArray: [#keyPath(SavedGames.title), title])
                ])
        
            case (false, true, false, true):
            //filtering by date range and genres
                filterPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                    NSPredicate(format: "(releaseYear >= %i) AND (releaseYear <= %i)", startYear, endYear),
                    NSPredicate(format: "SUBQUERY(%K, $genre, $genre.name IN %@).@count > 0", #keyPath(SavedGames.genreType), genres)
                ])
            case (false, true, true, false):
            //filtering by date range and name
                filterPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                    NSPredicate(format: "(releaseYear >= %i) AND (releaseYear <= %i)", startYear, endYear),
                    NSPredicate(format: "%K CONTAINS [c] %@", argumentArray: [#keyPath(SavedGames.title), title])
                ])
            case (false, false, true, false):
            //filtering by date range, platforms, and name
                filterPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                    NSPredicate(format: "(releaseYear >= %i) AND (releaseYear <= %i)", startYear, endYear),
                    NSPredicate(format: "%K in %@", argumentArray: [#keyPath(SavedGames.platformID), platforms]),
                    NSPredicate(format: "%K CONTAINS [c] %@", argumentArray: [#keyPath(SavedGames.title), title])
                ])
       

        }
        
        
//        print("filterPredicate", filterPredicate)
                
                fetchRequest.predicate = filterPredicate
                fetchRequest.sortDescriptors = [sortAscending!]
                

   

        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            return fetchedObjects ?? [T]()
        } catch {
            print("error")
            return [T]()
        }
    
        
        
    }
}



