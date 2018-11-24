//
//  PhotoAlbumListRepository.swift
//  GT_PhotoAlbums
//
//  Created by Leonid Nifantyev on 11/23/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

import FacebookCore

public typealias JSONObject = [String: Any]

public enum PhotoAlbumListRepositoryError: Error {
}

public typealias PhotoAlbumResult<T> = ResultType<T, PhotoAlbumListRepositoryError>

public protocol PhotoAlbumRepository {
    func fetchAlbumList(callback: @escaping (PhotoAlbumResult<[PhotoAlbumEntity]>) -> Void)
    func fetchPhotoWith(id: String, callback: @escaping (PhotoAlbumResult<PhotoEntity>) -> Void)
    func testOperation(callback: @escaping (PhotoAlbumResult<[PhotoAlbumEntity]>) -> Void)
}

public class PhotoAlbumListCloudRepository: PhotoAlbumRepository {
    public init() { }
    
    public func testOperation(callback: @escaping (PhotoAlbumResult<[PhotoAlbumEntity]>) -> Void) {
        
        let operationQueue: OperationQueue = OperationQueue()
//        operationQueue.maxConcurrentOperationCount = 1
        
        let queueCompletionOperation = BlockOperation {
            debugPrint("")
        }
        
        let albumListRequest = GraphRequest(graphPath: "/me/albums",
                                            parameters: ["fields": "id, name, cover_photo"],
                                            httpMethod: .GET)
        
        
        let photoAlbumOperation = PhotoAlbumOperation(request: albumListRequest)
        let parseOperation = UnboxAlbumListOperation()
        
        photoAlbumOperation.completionBlock = {
            guard let jsonObject = photoAlbumOperation.responseData?.dictionaryValue
                else { return }
            parseOperation.jsonObject = jsonObject
        }
        
        parseOperation.completionBlock = {
            debugPrint(parseOperation.photoAlbumList ?? "")
        }
        
        parseOperation.addDependency(photoAlbumOperation)
        queueCompletionOperation.addDependency(parseOperation)
        
        operationQueue.addOperations([photoAlbumOperation, parseOperation, queueCompletionOperation], waitUntilFinished: false)
        

        
    }
    
    
    
    
    
    
    
    
    
    public func fetchAlbumList(callback: @escaping (PhotoAlbumResult<[PhotoAlbumEntity]>) -> Void) {
        let albumListRequest = GraphRequest(graphPath: "/me/albums",
                                   parameters: ["fields": "id, name, cover_photo"],
                                   httpMethod: .GET)
        albumListRequest.start { (response, result) in
            switch result {
            case let .success(response: response):
                guard
                    let dict = response.dictionaryValue,
                    let data = dict["data"] as? [JSONObject] else { return }
                
                let output: [PhotoAlbumEntity] = data.map { unbox(from: $0) }
                callback(PhotoAlbumResult.success(output))
            case let .failed(error):
                debugPrint(error)
            }
        }
    }
        
    public func fetchPhotoWith(id: String, callback: @escaping (PhotoAlbumResult<PhotoEntity>) -> Void) {
        let request = GraphRequest(graphPath: id,
                                   parameters: ["fields": "link"],
                                    httpMethod: .GET)
        request.start { (response, result) in
            switch result {
            case let .success(response: response):
                debugPrint(response)
            case let .failed(error):
                debugPrint(error)
            }
        }
    }
}