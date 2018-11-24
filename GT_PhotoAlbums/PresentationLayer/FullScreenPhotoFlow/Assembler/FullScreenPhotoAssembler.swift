//
//  FullScreenPhotoAssembler.swift
//  GT_PhotoAlbums
//
//  Created by Leonid Nifantyev on 11/21/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

import UIKit
import DataLayer

class FullScreenPhotoAssembler {
    
    func assemble() -> (view: BaseView, presenter: FullScreenPhotoPresenter) {
        let view = FullScreenPhotoVC.initFromStoryboard()
        let presenter = FullScreenPhotoPresenterImpl()
        view.presenter = presenter
        presenter.view = view
        
        return (view, presenter)
    }
}
