//
//  PhotoAlbumListRouter.swift
//  GT_PhotoAlbums
//
//  Created by Leonid Nifantyev on 11/23/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

import UIKit

protocol PhotoAlbumListRouter: BaseRouter {
    func showAlbum(with album: PhotoAlbumViewItem)
}

class PhotoAlbumListRouterImpl: PhotoAlbumListRouter {
    
    private var vc: BaseView!
    
    init(vc: BaseView) {
        self.vc = vc
    }
    
    func showAlbum(with album: PhotoAlbumViewItem) {
        var module = PhotosAssembler().assemble()
        module.presenter.album = album
        pushModule(fromModule: vc, toModule: module.view)
    }
}
