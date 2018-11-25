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
        self.current.fetchAlbumList { [weak self] (result) in
            switch result {
            case let .success(entities):
                self?.fetchImages(for: entities, callback: { [weak self] (result) in
                    switch result {
                    case let .success(albums):
                        self?.cashing(albums: albums)
                        callback(PhotoRepositoryResult.success(albums))
                    case .failure:
                        self?.local.fetchAlbumList(callback: callback)
                    }
                })
            case .failure:
                self?.local.fetchAlbumList(callback: callback)
            }
        }
    }
    
    private func cashing(albums: [PhotoAlbumEntity]) {
        saveAlbumList(albumList: albums)
    }
    
    private func fetchImages(for albums: [PhotoAlbumEntity], callback: @escaping (PhotoRepositoryResult<[PhotoAlbumEntity]>) -> Void) {
        var output: [PhotoAlbumEntity] = []
        
        let group = DispatchGroup()
        
        for album in albums {
            group.enter()
            guard let id = album.coverPhotoId else {
                output.append(album)
                group.leave()
                continue
            }
            
            self.fetchPhotoWith(id: id, callback: { [weak self] (result) in
                switch result {
                case let .success(urlString):
                    var updated = album
                    updated.link = urlString
                    self?.downloadImage(urlString: urlString, callback: { (image) in
                        updated.coverImage = image
                        output.append(updated)
                        group.leave()
                    })
                    
                case let .failure(error):
                    callback(PhotoRepositoryResult.failure(error))
                }
               
            })
        }
        
        group.notify(queue: .main) {
            callback(PhotoRepositoryResult.success(output))
        }
    }
    
    public func fetchPhotoWith(id: String, callback: @escaping (PhotoRepositoryResult<String>) -> Void) {
        self.current.fetchPhotoWith(id: id, callback: callback)
    }
    
    public func fetchPhotos(album id: String, callback: @escaping (PhotoRepositoryResult<[PhotoEntity]>) -> Void) {
        self.current.fetchPhotos(album: id, callback: callback)
    }
    
    func saveAlbumList(albumList: [PhotoAlbumEntity]) {
        for album in albumList {
            if let _: CDPhotoAlbum = pManager.fetchRecord(with: album.id!) {
                continue
            }
            saveAlbum(album: album)
        }
    }
    
    func saveAlbum(album: PhotoAlbumEntity, completion: ((Bool) -> Void)? = nil) {
        var filePath: String?
        
        if let coverImage = album.coverImage {
             filePath = self.pManager.saveImage(image: coverImage)
        }
        
        self.pManager.saveRecord(saveCode: { (albumObject: CDPhotoAlbum) in
            albumObject.id = album.id
            albumObject.name = album.name
            albumObject.filepath = filePath
        }) { (success) in
            completion?(success)
        }
    }
    
    private func downloadImage(urlString: String, callback: @escaping (UIImage?) -> Void) {
        let url = URL(string: urlString)!
        
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
            guard error == nil else {
                callback(nil)
                return
            }
            DispatchQueue.main.async {
                let image = UIImage(data: data!)
                callback(image)
            }}.resume()
    }
}
