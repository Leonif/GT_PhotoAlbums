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
        let adapter = PhotoAdapter<PhotoCell, PhotoViewItem>(columns: 4)
        view.presenter = presenter
        view.adapter = adapter
        presenter.view = view
        
        let repository = PhotoAlbumListCloudRepository()
        let interactor = PhotoAlbumInteractorImpl()
        interactor.presenter = presenter
        interactor.repository = repository
        
        let router = PhotoAlbumRouterImpl(vc: view)
        presenter.interactor = interactor
        presenter.router = router
        
        let mapper = PhotoAlbumMapper()
        
        presenter.mapper = mapper
        
        return view
    }
}
