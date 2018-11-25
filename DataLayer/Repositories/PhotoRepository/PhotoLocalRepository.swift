//
//  PhotoLocalRepository.swift
//  DataLayer
//
//  Created by Leonid Nifantyev on 11/25/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

import Foundation


public class PhotoLocalRepository: PhotoRepository {
    
    public init() {
        
    }
    
    public func fetchAlbumList(callback: @escaping (PhotoRepositoryResult<[PhotoAlbumEntity]>) -> Void) {
        
    }
    
    public func fetchPhotoWith(id: String, callback: @escaping (PhotoRepositoryResult<String>) -> Void) {
        
    }
    
    public func fetchPhotos(album id: String, callback: @escaping (PhotoRepositoryResult<[PhotoEntity]>) -> Void) {
        
    }
}
