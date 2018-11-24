//
//  PhotoAlbumListMapper.swift
//  GT_PhotoAlbums
//
//  Created by Leonid Nifantyev on 11/24/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

import DataLayer

struct PhotoAlbumViewItem {
    let id: String
    let name: String
    var urlString: String?
}
class PhotoAlbumListMapper {
    
    func transform(input: PhotoAlbumEntity) -> PhotoAlbumViewItem? {
        guard let id = input.id,
        let name = input.name,
            let link = input.link  else {
                return nil
        }
        return PhotoAlbumViewItem(id: id, name: name, urlString: link)
    }
    
    func transform(input: [PhotoAlbumEntity]) -> [PhotoAlbumViewItem] {
        return input.compactMap { transform(input: $0) }
    }
    
}
