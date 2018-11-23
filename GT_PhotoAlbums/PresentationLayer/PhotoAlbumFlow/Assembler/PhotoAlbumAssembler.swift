//
//  PhotoAlbumAssembler.swift
//  GT_PhotoAlbums
//
//  Created by Leonid Nifantyev on 11/21/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

import UIKit
import DataLayer

class PhotoAlbumAssembler {
    
    func assemble() -> UIViewController {
        let view = PhotoAlbumVC.initFromStoryboard()
        let presenter = PhotoAlbumPresenterImpl()
        view.presenter = presenter
        presenter.view = view
        
        let repository = PhotoAlbumListCloudRepository()
        let interactor = PhotoAlbumInteractorImpl()
        interactor.repository = repository
        
        let router = PhotoAlbumRouterImpl(vc: view)
        presenter.interactor = interactor
        presenter.router = router
        
        return view
    }
}
