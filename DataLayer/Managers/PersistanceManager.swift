//
//  PersistanceManager.swift
//  DataLayer
//
//  Created by Leonid Nifantyev on 11/25/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

import Foundation
import CoreData
import MagicalRecord

public typealias Persistanble = NSManagedObject

public protocol PersistanceManager {
    func fetchAllRecords<Entity: Persistanble>() -> [Entity]
    func fetchRecord<Entity: Persistanble>(with id: String) -> Entity
    func saveRecord<Entity: Persistanble>(saveCode: @escaping (Entity) -> Void, completion: @escaping (Bool) -> Void)
    func removeRecord<Entity: Persistanble>(for entity: Entity)
    func saveImage(image: UIImage) -> String
}

public class PersistanceManagerImpl: PersistanceManager {
    
    public init() {
        MagicalRecord.setupCoreDataStack(withStoreNamed: "CoreDataCash")
    }
    
    public func fetchRecord<Entity>(with id: String) -> Entity where Entity : Persistanble {
        if let resultObject = Entity.mr_findFirst(byAttribute: "id", withValue: id) {
            return resultObject
        } else {
            return Entity()
        }
    }
    
    public func fetchAllRecords<Entity>() -> [Entity] where Entity : Persistanble {
        if let resultArray = Entity.mr_findAll() as? [Entity] {
            return resultArray
        } else {
            return []
        }
    }
    
    public func saveImage(image: UIImage) -> String {
        // Save imageData to filePath
        
        // Get access to shared instance of the file manager
        let fileManager = FileManager.default
        
        // Get the URL for the users home directory
        let documentsURL =  fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        // Get the document URL as a string
        let documentPath = documentsURL.path
        
        // Create filePath URL by appending final path component (name of image)
        let filePath = documentsURL.appendingPathComponent("file\(UUID().uuidString).png")
        
        // Check for existing image data
        do {
            // Look through array of files in documentDirectory
            let files = try fileManager.contentsOfDirectory(atPath: "\(documentPath)")
            for file in files {
                // If we find existing image filePath delete it to make way for new imageData
                if "\(documentPath)/\(file)" == filePath.path {
                    try fileManager.removeItem(atPath: filePath.path)
                }
            }
        } catch {
            print("Could not add image from document directory: \(error)")
        }
        
        // Create imageData and write to filePath
        do {
            if let pngImageData = image.pngData() {
                try pngImageData.write(to: filePath, options: .atomic)
            }
        } catch {
            print("couldn't write image")
        }
        return filePath.path
    }
    
    public func saveRecord<Entity>(saveCode: @escaping (Entity) -> Void, completion: @escaping (Bool) -> Void) where Entity : Persistanble {
        MagicalRecord.save({ (localContext) in
            let localEntity: Entity = Entity.mr_createEntity(in: localContext)!
            saveCode(localEntity)
        }) { (success, error) in
            completion(success)
        }
    }
    
    public func removeRecord<Entity>(for entity: Entity) where Entity : Persistanble {
        MagicalRecord.save ({ (localContext) in
            entity.mr_deleteEntity(in: localContext)
        })
    }
}

public class PersistanceManagerFactory {
    public static func createPersistanceManager() -> PersistanceManager {
        return PersistanceManagerImpl()
    }
}
