//
//  PhotosAssembler.swift
//  GT_PhotoAlbums
//
//  Created by Leonid Nifantyev on 11/21/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

import UIKit
import DataLayer

class PhotosAssembler {
    
    func assemble() -> (view: BaseView, presenter: PhotosPresenter) {
        let view = PhotosVC.initFromStoryboard()
        let presenter = PhotosPresenterImpl()
        let adapter = PhotoGridAdapter<PhotoCell, PhotoViewItem>(columns: 4)
        view.presenter = presenter
        view.adapter = adapter
        presenter.view = view
        
        let repository = PhotoCloudRepository()
        let interactor = PhotosInteractorImpl()
        interactor.presenter = presenter
        interactor.repository = repository
        
        let router = PhotosRouterImpl(vc: view)
        presenter.interactor = interactor
        presenter.router = router
        
        let mapper = PhotosMapper()
        
        presenter.mapper = mapper
        
        return (view, presenter)
    }
}
