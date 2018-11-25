//
//  FullScreenPhotoVC.swift
//  GT_PhotoAlbums
//
//  Created by Leonid Nifantyev on 11/21/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

import UIKit
import DataLayer

protocol FullScreenPhotoView: BaseView {
    
    func update(urlString: String)
}

class FullScreenPhotoVC: UIViewController, FullScreenPhotoView {
    var presenter: FullScreenPhotoPresenter!
    @IBOutlet private var imageView: UIImageView!
    var repository = PhotoCloudRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    func update(urlString: String) {
        self.imageView.downloadImage(for: urlString)
    }
    
    func close() {
        navigationController?.popViewController(animated: true)
    }
}
