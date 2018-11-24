//
//  FullScreenPhotoPresenter.swift
//  GT_PhotoAlbums
//
//  Created by Leonid Nifantyev on 11/23/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

import Foundation

protocol FullScreenPhotoPresenter: BasePresenter {
    var urlString: String! { get set }
    func viewDidLoad()
}

class FullScreenPhotoPresenterImpl: FullScreenPhotoPresenter {
    weak var view: FullScreenPhotoView!
    var urlString: String!
    
    func viewDidLoad() {
        view.update(urlString: urlString)
    }
}
