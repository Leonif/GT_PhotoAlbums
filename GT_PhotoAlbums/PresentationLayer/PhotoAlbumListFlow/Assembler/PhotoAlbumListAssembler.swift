//
//  PhotoAlbumListAssembler.swift
//  GT_PhotoAlbums
//
//  Created by Leonid Nifantyev on 11/21/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

import UIKit
import FacebookLogin
import DataLayer

class PhotoAlbumListAssembler {
    
    func assemble() -> UIViewController {
        let view = PhotoAlbumListVC.initFromStoryboard()
        let presenter = PhotoAlbumListPresenterImpl()
        view.presenter = presenter
        presenter.view = view
        
        let repository = PhotoAlbumListCloudRepository()
        let interactor = PhotoAlbumListInteractorImpl()
        interactor.repository = repository
        
        let router = PhotoAlbumListRouterImpl(vc: view)
        presenter.interactor = interactor
        presenter.router = router
        
        return view
    }
}
