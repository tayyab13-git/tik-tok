//
//  PostModel.swift
//  TikTok
//
//  Created by Акнур on 5/25/21.
//  Copyright © 2021 Aknur. All rights reserved.
//

import Foundation
import UIKit


struct PostModel {
    let identifier: String
    
    let user = User(username: "ececewcewc", profilePicturedURL: nil, identifier: UUID().uuidString)
    var isLikedByCurrentUser = false
    
    static func mockModels() -> [PostModel] {
        var posts = [PostModel]()
        for _ in 0...100 {
            let post = PostModel(identifier: UUID().uuidString)
            posts.append(post)
        }
        return posts
    }
}
