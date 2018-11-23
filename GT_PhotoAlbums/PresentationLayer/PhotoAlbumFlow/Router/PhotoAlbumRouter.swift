//
//  PhotoAlbumRouter.swift
//  GT_PhotoAlbums
//
//  Created by Leonid Nifantyev on 11/23/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

import UIKit

protocol PhotoAlbumRouter: BaseRouter {
    func showAlbum()
}

class PhotoAlbumRouterImpl: PhotoAlbumRouter {
    
    private var vc: BaseView!
    
    init(vc: BaseView) {
        self.vc = vc
    }
    
    func showAlbum() {
        
//        let albumView = PhotoAlbumListAssembler().assemble()
//        
//        let view = UINavigationController(rootViewController: albumView)
//        
//        presentController(fromModule: vc, to: view)
    }
}
