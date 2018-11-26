//
//  PhotoLocalRepository.swift
//  DataLayer
//
//  Created by Leonid Nifantyev on 11/25/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

import Foundation

public class PhotoLocalRepository: PhotoRepository {
    
    private var pManager: PersistanceManager
    
    public init(pManager: PersistanceManager) {
        self.pManager = pManager
    }
    
    public func fetchAlbumList(callback: @escaping (PhotoRepositoryResult<[PhotoAlbumEntity]>) -> Void) {
        let albums: [CDPhotoAlbum] = pManager.fetchAllRecords()
        var output: [PhotoAlbumEntity] = []
        
        for album in albums {
            if let filePath = album.filepath {
                let image = UIImage(contentsOfFile: filePath)
                output.append(PhotoAlbumEntity(id: album.id!, name: album.name!, coverImage: image ?? #imageLiteral(resourceName: "cat")))
            }
        }
        callback(PhotoRepositoryResult.success(output))
    }
    
    public func fetchPhotoWith(id: String, callback: @escaping (PhotoRepositoryResult<String>) -> Void) {
        
    }
    
    public func fetchPhotos(album id: String, callback: @escaping (PhotoRepositoryResult<[PhotoEntity]>) -> Void) {
        
    }
}
