//
//  PhotoAlbumListInteractor.swift
//  GT_PhotoAlbums
//
//  Created by Leonid Nifantyev on 11/23/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

import DataLayer

protocol PhotoAlbumListInteractor {
    func fetchAlbumList(completion: @escaping (PhotoAlbumResult<[PhotoAlbumEntity]>) -> Void)
}

class PhotoAlbumListInteractorImpl: PhotoAlbumListInteractor {
    
    var repository: PhotoAlbumRepository!
    var presenter: PhotoAlbumListPresenter!
    
    func fetchAlbumList(completion: @escaping (PhotoAlbumResult<[PhotoAlbumEntity]>) -> Void) {
        repository.fetchAlbumList { (result) in
            switch result {
            case let .success(entities):
                debugPrint(entities)
            case let .failure(error):
                debugPrint(error)
            }
        }
        
        
//        repository.testOperation { (result) in
//            debugPrint(result)
//        }
    }
}

