//
//  PhotosMapper.swift
//  GT_PhotoAlbums
//
//  Created by Leonid Nifantyev on 11/24/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

import DataLayer

class PhotosMapper {
    
    func transform(input: PhotoEntity) -> PhotoViewItem? {
        guard
            let id = input.id,
            let link = input.link
            else { return nil }
        return PhotoViewItem(id: id, urlString: link)
    }
    
    func transform(input: [PhotoEntity]) -> [PhotoViewItem] {
        return input.compactMap { transform(input: $0) }
    }
}
