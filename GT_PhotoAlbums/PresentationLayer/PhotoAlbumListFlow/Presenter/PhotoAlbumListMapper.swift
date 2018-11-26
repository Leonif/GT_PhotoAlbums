//
//  PhotoAlbumListMapper.swift
//  GT_PhotoAlbums
//
//  Created by Leonid Nifantyev on 11/24/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

import DataLayer

class PhotoAlbumListMapper {
    
    func transform(input: PhotoAlbumEntity) -> PhotoAlbumViewItem? {
        guard
            let id = input.id,
            let name = input.name
            else {
                return nil
        }

        return PhotoAlbumViewItem(id: id, name: name, image: input.coverImage ?? #imageLiteral(resourceName: "cat"))
    }
    
    func transform(input: [PhotoAlbumEntity]) -> [PhotoAlbumViewItem] {
        return input.compactMap { transform(input: $0) }
    }
}
