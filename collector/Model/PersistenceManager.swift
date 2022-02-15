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
    
    
    lazy var persistenceContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "Collector")
        container.loadPersistentStores(completionHandler: { (storedDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error: \(error), \(error.userInfo)")
            }
        })
        
        
        return container
    }()
    
    // MARK: - define
    var context: NSManagedObjectContext {
        let context = PersistenceManager.shared.persistenceContainer.viewContext
        context.automaticallyMergesChangesFromParent = true
        return context
    }
    
    
    // MARK: - Core Data Saving Support
    
    func save() {
        let context = persistenceContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()

            } catch {
                
                let nserror = error as NSError
                
                
                
                
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    func delete(_ object: NSManagedObject) {
        let context = persistenceContainer.viewContext
        
        context.delete(object)
        do {
            try context.save()

        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    
    // MARK: - Fetching Methods

    
    
    func fetch<T: NSManagedObject>(_ objectType: T.Type) -> [T] {
        let entityName = String(describing: objectType)
        let context = persistenceContainer.viewContext
        
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
        let context = persistenceContainer.viewContext
        
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
        let context = persistenceContainer.viewContext
        
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
        let context = persistenceContainer.viewContext
        
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
        let context = persistenceContainer.viewContext
        
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
        let context = persistenceContainer.viewContext
        
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let filterPredicate = NSPredicate(format: "(category == %@) AND (gameTitle == %@)", category, gameTitle)
        fetchRequest.predicate = filterPredicate
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            
            return fetchedObjects ?? [T]()
        } catch {
            return [T]()
        }
        
        
    }
    
    
    func fetchSingleGameObjectByName<T: NSManagedObject>(_ objectType: T.Type, name: String, platformID: Int) -> [T] {
        let context = persistenceContainer.viewContext
        
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
        let context = persistenceContainer.viewContext
        
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
        let context = persistenceContainer.viewContext
        
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
        let context = persistenceContainer.viewContext
        
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
    
    
    
    
    func fetchSortByReleaseDate<T: NSManagedObject>(_ objectType: T.Type, platformID: Int) -> [T]{
        let context = persistenceContainer.viewContext
        
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
        let context = persistenceContainer.viewContext
        
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
        let context = persistenceContainer.viewContext
        
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let filterPredicate = NSPredicate(format: "platformID == \(Int32(platformID))")
        let sortAscending = NSSortDescriptor(key: "title", ascending: true)

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
        let context = persistenceContainer.viewContext
        
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
        let context = persistenceContainer.viewContext
        
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let filterPredicate : NSPredicate?
        let startYear = Int32((dateRange?.first)!)
        let endYear = Int32((dateRange?.last)!)
        
        
        
        if dateRange != nil{
            
            filterPredicate = NSPredicate(format: "(releaseYear >= %i) AND (releaseYear <= %i)", startYear, endYear)
            
            
            fetchRequest.predicate = filterPredicate
            let sortAscending = NSSortDescriptor(key: "title", ascending: true)
            fetchRequest.sortDescriptors = [sortAscending]
            
            
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
        let context = persistenceContainer.viewContext
        
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
    
    
    func fetchGame<T: NSManagedObject>(_ objectType: T.Type, byGameTitle: String?, platformID: Int?, selectedGenres: [String]?, selectedPlatforms: [Int]?, selectedDateRange: [Int]? ) -> [T]{
        let context = persistenceContainer.viewContext
        
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        var filterPredicate : NSPredicate?
        
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
        
        
        if let gameTitle = byGameTitle {
            title = gameTitle
        }
        
 
        
        switch (dates.isEmpty, platforms.isEmpty, genres.isEmpty, byGameTitle == nil) {
            
        case (true, true, true, true):
            // all arrays are empty so we don't filter anything and return all SavedGame objects
            filterPredicate = NSPredicate(value: true)
            
        case (true ,true, false, true):
            // only filter genres
            
            filterPredicate = NSPredicate(format: "SUBQUERY(%K, $genre, $genre.name IN %@).@count > 0", #keyPath(SavedGames.genreType), genres)
            
        case (true, false, true, true):
            // only filter platforms
            
            filterPredicate = NSPredicate(format: "%K in %@", argumentArray: [#keyPath(SavedGames.platformID), platforms])
            
        case (true, false, false, true):
            // filter both genres and platforms
            
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
        
        fetchRequest.predicate = filterPredicate
        
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            return fetchedObjects ?? [T]()
        } catch {
            print("error")
            return [T]()
        }
        
        
        
    }
    


    func updateCompletedPercent<T: NSManagedObject>(objectType: T.Type, gameTitle: String, completedValue: Float) {
        let context = persistenceContainer.viewContext
        
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let filterPredicate = NSPredicate(format: "title == %@", gameTitle)
        fetchRequest.predicate = filterPredicate
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            let objectUpdate = (fetchedObjects?[0])! as NSManagedObject
            
            
            objectUpdate.setValue(completedValue, forKeyPath: "percentComplete")
            
            save()
        } catch {
            
            print("error")
            
        }
    }
    
    func updateGameConditionPercent<T: NSManagedObject>(objectType: T.Type, gameTitle: String, gameCondition: Float) {
        let context = persistenceContainer.viewContext
        
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let filterPredicate = NSPredicate(format: "title == %@", gameTitle)
        fetchRequest.predicate = filterPredicate
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            let objectUpdate = (fetchedObjects?[0])! as NSManagedObject
            
            objectUpdate.setValue(gameCondition, forKeyPath: "gameCondition")
            
            save()
        } catch {
            
            print("error")
            
        }
    }
    
    func updateBoxConditionPercent<T: NSManagedObject>(objectType: T.Type, gameTitle: String, boxCondition: Float) {
        let context = persistenceContainer.viewContext
        
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let filterPredicate = NSPredicate(format: "title == %@", gameTitle)
        fetchRequest.predicate = filterPredicate
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            let objectUpdate = (fetchedObjects?[0])! as NSManagedObject
            
            objectUpdate.setValue(boxCondition, forKeyPath: "boxCondition")
            
            save()
        } catch {
            
            print("error")
            
        }
    }
    
    
    func updateManualConditionPercent<T: NSManagedObject>(objectType: T.Type, gameTitle: String, manualCondition: Float) {
        let context = persistenceContainer.viewContext
        
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let filterPredicate = NSPredicate(format: "title == %@", gameTitle)
        fetchRequest.predicate = filterPredicate
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            let objectUpdate = (fetchedObjects?[0])! as NSManagedObject
            
            objectUpdate.setValue(manualCondition, forKeyPath: "manualCondition")
            
            save()
        } catch {
            
            print("error")
            
        }
    }
    
    func updateGameOwned<T: NSManagedObject>(objectType: T.Type, gameTitle: String, gameOwned: Bool) {
        let context = persistenceContainer.viewContext
        
        
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let filterPredicate = NSPredicate(format: "title == %@", gameTitle)
        fetchRequest.predicate = filterPredicate
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            let objectUpdate = (fetchedObjects?[0])! as NSManagedObject
            
            objectUpdate.setValue(gameOwned, forKeyPath: "gameOwned")
            
            save()
        } catch {
            
            print("error")
            
        }
    }
    
    func updateBoxOwned<T: NSManagedObject>(objectType: T.Type, gameTitle: String, boxOwned: Bool) {
        let context = persistenceContainer.viewContext
        
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let filterPredicate = NSPredicate(format: "title == %@", gameTitle)
        fetchRequest.predicate = filterPredicate
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            let objectUpdate = (fetchedObjects?[0])! as NSManagedObject
            
            objectUpdate.setValue(boxOwned, forKeyPath: "boxOwned")
            
            save()
        } catch {
            
            print("error")
            
        }
    }
    
    func updateManualOwned<T: NSManagedObject>(objectType: T.Type, gameTitle: String, manualOwned: Bool) {
        let context = persistenceContainer.viewContext
        
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let filterPredicate = NSPredicate(format: "title == %@", gameTitle)
        fetchRequest.predicate = filterPredicate
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            let objectUpdate = (fetchedObjects?[0])! as NSManagedObject
            
            objectUpdate.setValue(manualOwned, forKeyPath: "manualOwned")
            
            save()
        } catch {
            
            print("error")
            
        }
    }
    
    
    func updatePhysicalCopyOwned<T: NSManagedObject>(objectType: T.Type, gameTitle: String, physicalCopy: Bool) {
        let context = persistenceContainer.viewContext
        
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let filterPredicate = NSPredicate(format: "title == %@", gameTitle)
        fetchRequest.predicate = filterPredicate
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            let objectUpdate = (fetchedObjects?[0])! as NSManagedObject
            
            objectUpdate.setValue(physicalCopy, forKeyPath: "physicalCopy")
            
            save()
        } catch {
            
            print("error")
            
        }
    }
    
    func updateDigitalCopyOwned<T: NSManagedObject>(objectType: T.Type, gameTitle: String, digitalCopy: Bool) {
        let context = persistenceContainer.viewContext
        
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let filterPredicate = NSPredicate(format: "title == %@", gameTitle)
        fetchRequest.predicate = filterPredicate
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            let objectUpdate = (fetchedObjects?[0])! as NSManagedObject
            
            objectUpdate.setValue(digitalCopy, forKeyPath: "digitalCopy")
            
            save()
        } catch {
            
            print("error")
            
        }
    }
    
    
    func updateBeatStatus<T: NSManagedObject>(objectType: T.Type, gameTitle: String, beat: Bool) {
        let context = persistenceContainer.viewContext
        
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let filterPredicate = NSPredicate(format: "title == %@", gameTitle)
        fetchRequest.predicate = filterPredicate
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            let objectUpdate = (fetchedObjects?[0])! as NSManagedObject
            
            objectUpdate.setValue(beat, forKeyPath: "hasBeaten")
            
            save()
        } catch {
            
            print("error")
            
        }
    }
    
    func updateCompletedStatus<T: NSManagedObject>(objectType: T.Type, gameTitle: String, completed: Bool) {
        let context = persistenceContainer.viewContext
        
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let filterPredicate = NSPredicate(format: "title == %@", gameTitle)
        fetchRequest.predicate = filterPredicate
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            let objectUpdate = (fetchedObjects?[0])! as NSManagedObject
            
            objectUpdate.setValue(completed, forKeyPath: "hasCompleted")
            
            save()
        } catch {
            
            print("error")
            
        }
    }
    
    
    
    func updatePricePaid<T:NSManagedObject>(objectType: T.Type, gameTitle: String, pricePaid: String) {
        let context = persistenceContainer.viewContext
        
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let filterPredicate = NSPredicate(format: "title == %@", gameTitle)
        fetchRequest.predicate = filterPredicate
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            let objectUpdate = (fetchedObjects?[0])! as NSManagedObject
            
            objectUpdate.setValue(pricePaid, forKeyPath: "pricePaid")
            
            save()
        } catch {
            
            print("error")
            
        }
        
        
    }
    
    func updateNotes<T:NSManagedObject>(objectType: T.Type, gameTitle: String, notes: String) {
        let context = persistenceContainer.viewContext
        
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let filterPredicate = NSPredicate(format: "title == %@", gameTitle)
        fetchRequest.predicate = filterPredicate
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            let objectUpdate = (fetchedObjects?[0])! as NSManagedObject
            
            
            objectUpdate.setValue(notes, forKeyPath: "notes")
            
            save()
        } catch {
            
            print("error")
            
        }
        
        
    }
    
    
   //REFACTOR
    func deleteAllPlatforms() {
        
        let savedPlatforms = fetchAllSavedPlatforms()
        for platform in savedPlatforms {
            delete(platform)
            
        }
        
    }
    
    func fetchAllSavedPlatforms() -> [Platform] {
        
        let savedPlatforms = fetch(Platform.self)
        return savedPlatforms
        
    }
    
    func fetchAllSavedGames() -> [SavedGames] {
        
        let savedGames = fetch(SavedGames.self)
        return savedGames
        
    }
    
    func fetchAllWishlistGames() -> [WishList] {
        
        let wishListGames = fetch(WishList.self)
        return wishListGames
        
    }
    
    func fetchSavedPlatformObject(with platformId: Int) -> Platform {
        
        let platforms = fetchFilteredByPlatform(Platform.self, platformID: platformId)
        let platformObject = platforms[0]
        
        return platformObject
        
    }
    
    

    
    func fetchSavedGenreObject(named genreName: String) -> GameGenre {
        
        let genres = fetchFilteredByGenre(GameGenre.self, name: genreName)
       
        let genreObject = genres[0]
        return genreObject
        
    }
    
    
    func saveGameToLibrary(game: GameObject) {
        guard let gameID = game.id else { return }
        let gameToSave = SavedGames(context: context)
        
        gameToSave.title = game.title
        gameToSave.platformName = game.platformName
        if let platformID = game.platformID {
        gameToSave.platformID = Int64(platformID)
        }
        gameToSave.gameID = Int32(gameID)
        
        gameToSave.boxartImageURL = game.boxartFrontImage
        
        var screenshots : [String] = []
        if let gameScreenshots = game.screenshots {
            for screenshot in gameScreenshots {
                
                if let imageID = screenshot.imageID {
                    
                    screenshots.append(imageID)
                    
                }
            }
        }
        
        gameToSave.screenshotImageIDs = screenshots
        
        gameToSave.maxPlayers = game.maxPlayers
        gameToSave.releaseDate = game.releaseDate
        
        var truncatedReleaseDate: String?
        truncatedReleaseDate = game.releaseDate?.toLengthOf(length: 6)
        
        if let releaseYearString = truncatedReleaseDate {
            let releaseYear = Int32(releaseYearString)
            if let year = releaseYear {
            gameToSave.releaseYear = year
            }
        }
        
        gameToSave.youtubeURL = game.youtubePath
        gameToSave.overview = game.overview
        gameToSave.rating = game.rating
        gameToSave.developerName = game.developer
        gameToSave.owned = true
        if let userRating = game.userRating {
            gameToSave.userRating = Int32(userRating)
        }
        if let totalRating = game.totalRating {
            gameToSave.totalRating = Int32(totalRating)
        }
        gameToSave.genre = game.genreDescriptions
        if let genres = game.genres {
            gameToSave.genres = genres
        } else {
            gameToSave.genres?.append("")
        }
        

        if isGameInWishlist(gameID: gameID) {
            removeGameFromWishlist(gameID: gameID)
        }
        
        save()
     
        addSavedGameToPlatform(game: gameToSave)
        
        addSavedGameToGenre(game: gameToSave)
        
        save()
        
      
    }
    
    func saveGameToWishlist(game: GameObject) {
        let gameToSave = WishList(context: context)
        
        gameToSave.title = game.title
        gameToSave.platformName = game.platformName
        if let platformID = game.platformID {
        gameToSave.platformID = Int64(platformID)
        }
        if let gameID = game.id {
        gameToSave.gameID = Int32(gameID)
        }
        gameToSave.boxartImageURL = game.boxartFrontImage
        
        var screenshots : [String] = []
        if let gameScreenshots = game.screenshots {
            for screenshot in gameScreenshots {
                
                if let imageID = screenshot.imageID {
                    
                    screenshots.append(imageID)
                    
                }
            }
        }
        
        gameToSave.screenshotImageIDs = screenshots
        
        gameToSave.maxPlayers = game.maxPlayers
        gameToSave.releaseDate = game.releaseDate
        
        var truncatedReleaseDate: String?
        truncatedReleaseDate = game.releaseDate?.toLengthOf(length: 6)
        
        if let releaseYearString = truncatedReleaseDate {
            let releaseYear = Int32(releaseYearString)
            if let year = releaseYear {
            gameToSave.releaseYear = year
            }
        }
        
        gameToSave.youtubeURL = game.youtubePath
        gameToSave.overview = game.overview
        gameToSave.rating = game.rating
        gameToSave.developerName = game.developer
        gameToSave.inWishlist = true
        if let userRating = game.userRating {
            gameToSave.userRating = Int32(userRating)
        }
        if let totalRating = game.totalRating {
            gameToSave.totalRating = Int32(totalRating)
        }
        gameToSave.genre = game.genreDescriptions
        if let genres = game.genres {
            gameToSave.genres = genres
        } else {
            gameToSave.genres?.append("")
        }
        
        

        
        save()
        
      
    }
    
    func addSavedGameToGenre(game: SavedGames) {
        guard let genreOfSavedGame = game.genre else { return }
        
        if isGenreInLibrary(name: genreOfSavedGame) {
            //Genre already exists, retrieve it and add to Saved Game
            let existingGenre = fetchSavedGenreObject(named: genreOfSavedGame)
            game.addToGenreType(existingGenre)
            save()
        } else {
            //Create new genre, add it to Saved Game
            let newGenre = GameGenre(context: context)
            newGenre.name = genreOfSavedGame
            game.addToGenreType(newGenre)
            save()
        }
        
    }
    
    
    func addSavedGameToPlatform(game: SavedGames) {
        let platformID = Int(game.platformID)
        
        if isPlatformInLibrary(platformID: platformID) {
            let existingPlatform = fetchSavedPlatformObject(with: platformID)
            existingPlatform.addToGames(game)
            save()
            
        } else {
            let newPlatform = Platform(context: context)
            newPlatform.id = Int32(game.platformID)
            newPlatform.name = game.platformName
            newPlatform.addToGames(game)
            save()
            
        }
    
    
    }
    
    func removePlatformFromLibrary(platformID: Int) {
        let savedPlatforms = fetch(Platform.self)
        for platform in savedPlatforms {
            if platform.id == platformID {
                delete(platform)
            }
        }
        save()
        
    }

    
    func removeGameFromLibrary(gameID: Int) {
        let savedGames = fetch(SavedGames.self)
        for game in savedGames {
            if game.gameID == gameID {
                let currentPlatformID = Int(game.platformID)
                let currentPlatform = fetchSavedPlatformObject(with: currentPlatformID)
                currentPlatform.removeFromGames(game)
                
                if let currentPlatformGames = currentPlatform.games {
                    if currentPlatformGames.count < 1 {
                        
                        removePlatformFromLibrary(platformID: currentPlatformID)
                    }
                    
                }
                
                delete(game)
            }
        }
        save()
    }
    
    
    func removeGameFromWishlist(gameID: Int) {
        let wishlistGames = fetch(WishList.self)

        for currentGame in wishlistGames {
            if currentGame.gameID == gameID {
                delete(currentGame)
            }
        }
        save()
    }
    
    
    func isPlatformInLibrary(platformID : Int) -> Bool {
        let savedPlatforms = fetch(Platform.self)
        
        for platform in savedPlatforms {
            if platform.id == platformID {
                return true
                
            }
        }
        
        return false
    }
    
    

    
    
    func isGameInLibrary(gameID: Int) -> Bool {
        
        let savedGames = fetchAllSavedGames()
        
        for savedGame in savedGames {
            if savedGame.gameID == gameID {
                return true
            }
        }
        return false
    }
    
    func isGameInWishlist(gameID: Int) -> Bool {
        
        let wishlist = fetchAllWishlistGames()
        
        for game in wishlist {
            if game.gameID == gameID {
                return true
            }
        }
        return false
    }

    
    func isGenreInLibrary(name: String) -> Bool {
        
        let savedGenres = fetchAllSavedGenres()
        
        for genre in savedGenres {
            
            if genre.name == name {
                return true
            }
        }
        return false
    }
    
    func fetchAllSavedGenres() -> [GameGenre] {
        let savedGenres = fetch(GameGenre.self)
        return savedGenres
    }
    
    
    func convertSavedGameToGameObject(savedGame: SavedGames) -> GameObject {
        
        var screenshots : [ImageInfo] = []
        
        if let persistedScreenshots = savedGame.screenshotImageIDs {
            for screenshot in persistedScreenshots {
                let imageInfo = ImageInfo(id: nil, alphaChannel: nil, animated: nil, game: nil, height: nil, imageID: screenshot, url: nil, width: nil, checksum: nil)
                
                screenshots.append(imageInfo)
            }
        }
        var savedGenres : [Genre] = []
        let genres = network.genres
        
        for genre in genres {

            for savedGenre in savedGame.genres! {

                if genre.name == savedGenre {
                    let genreObject = Genre(id: genre.id, createdAt: nil, name: genre.name, slug: genre.slug, updatedAt: nil, url: nil, checksum: nil)
                    savedGenres.append(genreObject)

                }

            }

        }
                
        let game = GameObject(
            title: savedGame.title,
            id: Int(savedGame.gameID),
            overview: savedGame.overview,
            boxartFrontImage: savedGame.boxartImageURL,
            boxartHeight: Int(savedGame.boxartHeight),
            boxartWidth: Int(savedGame.boxartWidth),
            boxartRearImage: nil,
            fanartImage: nil,
            rating: savedGame.rating,
            releaseDate: savedGame.releaseDate,
            owned: true,
            index: nil,
            screenshots: screenshots,
            developerIDs: nil,
            genreIDs: nil,
            pusblisherIDs: nil,
            youtubePath: savedGame.youtubeURL,
            platformID: Int(savedGame.platformID),
            maxPlayers: savedGame.maxPlayers,
            genreDescriptions: savedGame.genre,
            genre: savedGenres,
            genres: savedGame.genres,
            developer: savedGame.developerName,
            gamePhotos: nil,
            manualPhotos: nil,
            boxPhotos: nil,
            totalRating: Int(savedGame.totalRating),
            userRating: Int(savedGame.userRating)
            
            
            
        )
        
        return game
        
    }

    func convertWishlistGameToGameObject(wishListGame: WishList) -> GameObject {

        var screenshots : [ImageInfo] = []

        if let persistedScreenshots = wishListGame.screenshotImageIDs {
            for screenshot in persistedScreenshots {
                let imageInfo = ImageInfo(id: nil, alphaChannel: nil, animated: nil, game: nil, height: nil, imageID: screenshot, url: nil, width: nil, checksum: nil)

                screenshots.append(imageInfo)
            }
        }
        var savedGenres : [Genre] = []
        let genres = network.genres

        for genre in genres {

            for savedGenre in wishListGame.genres! {

                if genre.name == savedGenre {
                    let genreObject = Genre(id: genre.id, createdAt: nil, name: genre.name, slug: genre.slug, updatedAt: nil, url: nil, checksum: nil)
                    savedGenres.append(genreObject)

                }

            }

        }

        let game = GameObject(
            title: wishListGame.title,
            id: Int(wishListGame.gameID),
            overview: wishListGame.overview,
            boxartFrontImage: wishListGame.boxartImageURL,
            boxartHeight: Int(wishListGame.boxartHeight),
            boxartWidth: Int(wishListGame.boxartWidth),
            boxartRearImage: nil,
            fanartImage: nil,
            rating: wishListGame.rating,
            releaseDate: wishListGame.releaseDate,
            owned: true,
            index: nil,
            screenshots: screenshots,
            developerIDs: nil,
            genreIDs: nil,
            pusblisherIDs: nil,
            youtubePath: wishListGame.youtubeURL,
            platformID: Int(wishListGame.platformID),
            maxPlayers: wishListGame.maxPlayers,
            genreDescriptions: wishListGame.genre,
            genre: savedGenres,
            genres: wishListGame.genres,
            developer: wishListGame.developerName,
            gamePhotos: nil,
            manualPhotos: nil,
            boxPhotos: nil,
            totalRating: Int(wishListGame.totalRating),
            userRating: Int(wishListGame.userRating)



        )

        return game

    }
    
}



