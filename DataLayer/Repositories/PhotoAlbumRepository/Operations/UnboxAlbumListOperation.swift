//
//  UnboxAlbumListOperation.swift
//  DataLayer
//
//  Created by Leonid Nifantyev on 11/24/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

class UnboxAlbumListOperation: Operation {
    var jsonObject: JSONObject?
    
    var photoAlbumList: [PhotoAlbumEntity]?
    
    override init() {
        super.init()
    }
    override func main() {
        guard
            let dict = jsonObject,
            let data = dict["data"] as? [JSONObject] else { return }
        photoAlbumList = data.map { unbox(from: $0) }
    }
}
