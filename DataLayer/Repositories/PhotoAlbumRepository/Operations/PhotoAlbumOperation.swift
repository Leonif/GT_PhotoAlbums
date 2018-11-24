//
//  PhotoAlbumOperation.swift
//  DataLayer
//
//  Created by Leonid Nifantyev on 11/24/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//
import FacebookCore


class PhotoAlbumOperation: DAOperation {
    private let request: GraphRequest
    
    var responseData: GraphRequest.Response?
    
    init(request: GraphRequest) {
        self.request = request
    }
    
    override func main() {
        guard isCancelled == false else {
            finish(true)
            return
        }
        
        executing(true)
        self.request.start { (response, result) in
            switch result {
            case let .success(response: response):
                self.responseData = response
            case let .failed(error):
                debugPrint(error)
            }
            self.executing(false)
            self.finish(true)
        }
    }
}
