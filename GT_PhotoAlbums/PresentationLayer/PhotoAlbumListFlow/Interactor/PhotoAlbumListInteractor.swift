//
//  PhotoAlbumListInteractor.swift
//  GT_PhotoAlbums
//
//  Created by Leonid Nifantyev on 11/23/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

import DataLayer

protocol PhotoAlbumListInteractor {
    func fetchAlbumList(completion: @escaping (LoginRepositoryResult<[PhotoAlbumEntity]>) -> Void)
}

class PhotoAlbumListInteractorImpl: PhotoAlbumListInteractor {
    
    var repository: PhotoAlbumListRepository!
    
    func fetchAlbumList(completion: @escaping (LoginRepositoryResult<[PhotoAlbumEntity]>) -> Void) {
        repository.fetchAlbumList { (result) in
            switch result {
            case let .success(entities):
                debugPrint(entities)
            case let .failure(error):
                debugPrint(error)
            }
        }
    }
}

