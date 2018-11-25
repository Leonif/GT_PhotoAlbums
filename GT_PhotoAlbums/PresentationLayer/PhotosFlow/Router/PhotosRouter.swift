//
//  PhotoAlbumRouter.swift
//  GT_PhotoAlbums
//
//  Created by Leonid Nifantyev on 11/23/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

import UIKit

protocol PhotosRouter: BaseRouter {
    func showPhoto(with urlString: String)
}

class PhotosRouterImpl: PhotosRouter {
    
    private var vc: BaseView!
    
    init(vc: BaseView) {
        self.vc = vc
    }
    
    func showPhoto(with urlString: String) {
        var module = FullScreenPhotoAssembler().assemble()
        module.presenter.urlString = urlString
        pushModule(fromModule: vc, toModule: module.view)
        
    }
}
