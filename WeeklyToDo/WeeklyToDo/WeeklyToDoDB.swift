//
//  WeeklyToDoDB.swift
//  WeeklyToDo
//
//  Created by Cody on 2015. 1. 26..
//  Copyright (c) 2015년 TIEKLE. All rights reserved.
//

import CoreData

var todoCoreModelFileName = "Weekly_To_Do_DB"

class WeeklyToDoDB {
    var managedObjectContext : NSManagedObjectContext?
    
    init() {
        managedObjectContext = NSManagedObjectContext()
    }
    
    func create(#todo:String, repeat:Bool, symbols:[String]) {
        //http://timroadley.com/2012/02/12/core-data-basics-part-2-core-data-views/
        for symbol in symbols {
        }
    }
    func read(at:String) -> [Task]? {
        //http://timroadley.com/2012/02/12/core-data-basics-part-2-core-data-views/
        return nil
    }
    func update(index:Int, symbol:String) {
        //http://timroadley.com/2012/02/14/core-data-basics-part-3-editing-and-deleting/
    }
    func delete(index:Int, symbol:String) {
        //http://timroadley.com/2012/02/14/core-data-basics-part-3-editing-and-deleting/
    }

    
    var managedObjectModel : NSManagedObjectModel? {
        get {
            if self.managedObjectModel != nil {
                return self.managedObjectModel
            }
            
            if let modelURL = NSBundle.mainBundle().URLForResource(todoCoreModelFileName, withExtension: "mond") {
                return NSManagedObjectModel(contentsOfURL: modelURL)
            }
            
            return nil
        }
    }
    
    var persistentStoreCoordinator : NSPersistentStoreCoordinator? {
        get {
            if self.persistentStoreCoordinator != nil {
                return self.persistentStoreCoordinator
            }
            
            var url = NSFileManager.defaultManager().URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains:NSSearchPathDomainMask.UserDomainMask).last as? NSURL
            var stordUrl = url?.URLByAppendingPathComponent(todoCoreModelFileName+".sqlite")
            
            var persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel!)
            persistentStoreCoordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: stordUrl, options: nil, error: nil)
            return persistentStoreCoordinator
        }
    }
    
//    func persistentStoreCoordinator() -> NSPersistentStoreCoordinator? {
//        //abort()
//        return persistentStoreCoordinator
//    }
//    
//    // Returns the persistent store coordinator for the application.
//    // If the coordinator doesn't already exist, it is created and the application's store added to it.
//    - (NSPersistentStoreCoordinator *)persistentStoreCoordinator
//    {
//    if (_persistentStoreCoordinator != nil) {
//    return _persistentStoreCoordinator;
//    }
//    
//    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Recipe_33___Using_Core_Data.sqlite"];
//    
//    NSError *error = nil;
//    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
//    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
//    /*
//    Replace this implementation with code to handle the error appropriately.
//    
//    abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//    
//    Typical reasons for an error here include:
//    * The persistent store is not accessible;
//    * The schema for the persistent store is incompatible with current managed object model.
//    Check the error message to determine what the actual problem was.
//    
//    
//    If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
//    
//    If you encounter schema incompatibility errors during development, you can reduce their frequency by:
//    * Simply deleting the existing store:
//    [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
//    
//    * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
//    @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
//    
//    Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
//    
//    */
//    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//    abort();
//    }
//    
//    return _persistentStoreCoordinator;
//    }
//    
//    #pragma mark - Application's Documents directory
//    
//    // Returns the URL to the application's Documents directory.
//    - (NSURL *)applicationDocumentsDirectory
//    {
//    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
//    }
}