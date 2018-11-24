//
//  PhotoAlbumInteractor.swift
//  GT_PhotoAlbums
//
//  Created by Leonid Nifantyev on 11/23/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

import DataLayer

protocol PhotoAlbumInteractor {
    func fetchAlbumList(completion: @escaping (PhotoAlbumResult<Void>) -> Void)
}

class PhotoAlbumInteractorImpl: PhotoAlbumInteractor {
    
    var repository: PhotoAlbumRepository!
    
    func fetchAlbumList(completion: @escaping (PhotoAlbumResult<Void>) -> Void) {
//        repository.fetchAlbumList { (result) in
//            debugPrint(result)
//        }
        
        
        repository.testOperation { (result) in
            switch result {
            case let .success(entities):
                debugPrint(entities)
            case let .failure(error):
                debugPrint(error)
            }
        }
    }
}
