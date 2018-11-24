//
//  AddLinksToAlbumsOperation.swift
//  DataLayer
//
//  Created by Leonid Nifantyev on 11/24/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

import FacebookCore

class AddLinksToAlbumsOperation: DAOperation {
    var input: [PhotoAlbumEntity]?
    var output: [PhotoAlbumEntity]?
    var responseData: String?
    
    override init() {
        super.init()
    }
    
    override func main() {
        guard isCancelled == false else {
            finish(true)
            return
        }
        
        executing(true)
        
        guard let input = input else {
            return
        }
        
        addLinks(to: input) {
            self.executing(false)
            self.finish(true)
        }
    }
    
    func addLinks(to albums: [PhotoAlbumEntity], callback: @escaping () -> Void) {
        let group = DispatchGroup()
        var mutableAlbums = albums
        
        for (index, album) in mutableAlbums.enumerated() {
            group.enter()
            fetchPhotoWith(id: album.coverPhoto!.id!, callback: { (result) in
                switch result {
                case let .success(entity):
                    mutableAlbums[index].coverPhoto?.link = entity.link
                    group.leave()
                default: break
                }
            })
        }
        
        group.notify(queue: .main) {
            debugPrint(mutableAlbums)
            self.output = mutableAlbums
            callback()
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
