//
//  PhotoAlbumListInteractor.swift
//  GT_PhotoAlbums
//
//  Created by Leonid Nifantyev on 11/23/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

import DataLayer

protocol PhotoAlbumListInteractor {
    func fetchAlbumList(completion: @escaping (PhotoRepositoryResult<[PhotoAlbumEntity]>) -> Void)
}

class PhotoAlbumListInteractorImpl: PhotoAlbumListInteractor {
    
    var repository: PhotoRepository!
    var presenter: PhotoAlbumListPresenter!
    
    func fetchAlbumList(completion: @escaping (PhotoRepositoryResult<[PhotoAlbumEntity]>) -> Void) {
        repository.fetchAlbumList { (result) in
            switch result {
            case let .success(entities):
                self.fetchURLStrings(for: entities, callback: completion)
            case let .failure(error):
                completion(PhotoRepositoryResult.failure(error))
            }
        }
    }
    
    private func fetchURLStrings(for albums: [PhotoAlbumEntity], callback: @escaping (PhotoRepositoryResult<[PhotoAlbumEntity]>) -> Void) {
        var output: [PhotoAlbumEntity] = []

        let group = DispatchGroup()

        for album in albums {
            group.enter()
            guard let id = album.coverPhotoId else {
                output.append(album)
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
            callback(PhotoRepositoryResult.success(output))
        }
    }
}

