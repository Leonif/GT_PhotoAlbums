//
//  PhotoAlbumListVC.swift
//  GT_PhotoAlbums
//
//  Created by Leonid Nifantyev on 11/21/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

import UIKit

protocol PhotoAlbumListView: BaseView {
}



class PhotoAlbumListVC: UIViewController, PhotoAlbumListView {
    var presenter: PhotoAlbumListPresenter!
    var interactor: PhotoAlbumListInteractor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }

    func close() { }
}
