//
//  PhotoAlbumListAssembler.swift
//  GT_PhotoAlbums
//
//  Created by Leonid Nifantyev on 11/21/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

import UIKit
import FacebookLogin

class PhotoAlbumListAssembler {
    
    func assemble() -> UIViewController {
        let view = PhotoAlbumListVC.initFromStoryboard()
//        let presenter = LoginPresenterImpl()
//        view.presenter = presenter
//        presenter.view = view
//        
//        let manager = LoginManager()
//        
//        let provider = FacebookApi(manager: manager)
//        let interactor = LoginInteractorImpl()
//        interactor.provider = provider
//        
//        let router = LoginRouterImpl(vc: view)
//        presenter.interactor = interactor
//        presenter.router = router
        
        return view
    }
}
