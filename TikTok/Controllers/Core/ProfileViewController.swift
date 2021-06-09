//
//  ProfileViewController.swift
//  TikTok
//
//  Created by Акнур on 5/18/21.
//  Copyright © 2021 Aknur. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    let user: User
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        title = user.username.uppercased()
         view.backgroundColor = .systemBackground
    }
    

   

}
