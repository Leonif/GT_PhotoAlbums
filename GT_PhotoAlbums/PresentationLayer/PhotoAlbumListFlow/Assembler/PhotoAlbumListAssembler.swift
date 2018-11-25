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
        
        let persistanceManager = (UIApplication.shared.delegate as? AppDelegate)!.persistanceManager
        
        let view = PhotoAlbumListVC.initFromStoryboard()
        let presenter = PhotoAlbumListPresenterImpl()
        let adapter = PhotoGridAdapter<PhotoAlbumCell, PhotoAlbumViewItem>(columns: 2)
        view.presenter = presenter
        view.adapter = adapter
        presenter.view = view
        
        let repository = PhotoRepositoryImpl(local: PhotoLocalRepository(),
                                             cloud: PhotoCloudRepository(),
                                             pManager: persistanceManager)
        let interactor = PhotoAlbumListInteractorImpl()
        interactor.presenter = presenter
        interactor.repository = repository
        
        let router = PhotoAlbumListRouterImpl(vc: view)
        presenter.interactor = interactor
        presenter.router = router
        
        let mapper = PhotoAlbumListMapper()
        
        presenter.mapper = mapper
        
        return view
    }
}
