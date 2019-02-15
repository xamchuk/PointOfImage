//
//  ViewController.swift
//  PointOfImage
//
//  Created by Rusłan Chamski on 11/02/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var mainView = DrawView()
    var color: UIColor?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(mainView)
        mainView.backgroundColor = .clear
        mainView.frame = view.frame
    }
}
