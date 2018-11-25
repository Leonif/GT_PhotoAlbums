//
//  PhotoRepositoryImpl.swift
//  DataLayer
//
//  Created by Leonid Nifantyev on 11/25/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//


public class PhotoRepositoryImpl: PhotoRepository {
    
    private var current: PhotoRepository
    private var local: PhotoRepository
    private var cloud: PhotoRepository
    private var pManager: PersistanceManager
    
    public init(local: PhotoRepository, cloud: PhotoRepository, pManager: PersistanceManager) {
        self.local = local
        self.cloud = cloud
        self.current = self.cloud
        self.pManager = pManager
    }
    
    public func fetchAlbumList(callback: @escaping (PhotoRepositoryResult<[PhotoAlbumEntity]>) -> Void) {
        self.current.fetchAlbumList(callback: callback)
    }
    
    public func fetchPhotoWith(id: String, callback: @escaping (PhotoRepositoryResult<String>) -> Void) {
        self.current.fetchPhotoWith(id: id, callback: callback)
    }
    
    public func fetchPhotos(album id: String, callback: @escaping (PhotoRepositoryResult<[PhotoEntity]>) -> Void) {
        self.current.fetchPhotos(album: id, callback: callback)
    }
}
