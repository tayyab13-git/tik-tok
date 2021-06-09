//
//  PostComment.swift
//  TikTok
//
//  Created by Акнур on 5/30/21.
//  Copyright © 2021 Aknur. All rights reserved.
//

import Foundation

struct PostComment {
    let text: String
    let user: User
    let date: Date
    
    static func mockComments() -> [PostComment] {
        let user = User(username: "fvd", profilePicturedURL: nil, identifier: UUID().uuidString)
        
       var comments = [PostComment]()
        
        let text = [
        "rfjvbnerove",
        "rvefverev",
        "v ervwervwev"]
        
        for comment in text {
            comments.append(PostComment(text: comment, user: user, date: Date()))
        }
        return comments
    }
}
