//
//  ExploreUserViewModel.swift
//  TikTok
//
//  Created by Акнур on 6/7/21.
//  Copyright © 2021 Aknur. All rights reserved.
//

import Foundation
import UIKit
struct ExploreUserViewModel {
    let username: String
    let profileImage: UIImage?
    let followerCount: Int
    let handler: (() -> Void)
}
