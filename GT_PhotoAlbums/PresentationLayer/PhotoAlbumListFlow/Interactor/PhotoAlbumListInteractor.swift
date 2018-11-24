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
                self.fetchURLStrings(for: entities, callback: completion)
            case let .failure(error):
                completion(PhotoAlbumResult.failure(error))
            }
        }
        
        
//        repository.testOperation { (result) in
//            debugPrint(result)
//        }
    }
    
    private func fetchURLStrings(for albums: [PhotoAlbumEntity], callback: @escaping (PhotoAlbumResult<[PhotoAlbumEntity]>) -> Void) {
        var output: [PhotoAlbumEntity] = []

        let group = DispatchGroup()

        for album in albums {
            group.enter()
            guard let id = album.coverPhotoId else {
                group.leave()
                continue
            }
            
            self.repository.fetchPhotoWith(id: id, callback: { (result) in
                switch result {
                case let .success(urlString):
                    var updated = album
                    updated.link = urlString
                    output.append(updated)
                case .failure: fatalError()
                }
                group.leave()
            })
        }
        
        group.notify(queue: .main) {
            callback(PhotoAlbumResult.success(output))
        }
    }
}

