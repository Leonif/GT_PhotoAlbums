//
//  PhotoRepository1.swift
//  DataLayer
//
//  Created by Leonid Nifantyev on 11/25/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

import Foundation

public enum PhotoRepositoryError: Error {
    case unknown(String)
    case noAlbums(String)
    case facebookError(String)
}

public typealias PhotoRepositoryResult<T> = ResultType<T, PhotoRepositoryError>

public protocol PhotoRepository {
    func fetchAlbumList(callback: @escaping (PhotoRepositoryResult<[PhotoAlbumEntity]>) -> Void)
    func fetchPhotoWith(id: String, callback: @escaping (PhotoRepositoryResult<String>) -> Void)
    func fetchPhotos(album id: String, callback: @escaping (PhotoRepositoryResult<[PhotoEntity]>) -> Void)
}
