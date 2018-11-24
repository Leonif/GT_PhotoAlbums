//
//  PhotoAlbumMapper.swift
//  GT_PhotoAlbums
//
//  Created by Leonid Nifantyev on 11/24/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

import DataLayer

class PhotoAlbumMapper {
    
    func transform(input: PhotoEntity) -> PhotoViewItem? {
        guard  let link = input.link  else { return nil }
        return PhotoViewItem(urlString: link)
    }
    
    func transform(input: [PhotoEntity]) -> [PhotoViewItem] {
        return input.compactMap { transform(input: $0) }
    }
}
