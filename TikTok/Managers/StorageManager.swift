//
//  StorageManager.swift
//  TikTok
//
//  Created by Акнур on 5/18/21.
//  Copyright © 2021 Aknur. All rights reserved.
//

import Foundation
import FirebaseStorage

final class StorageManager {
    public static let shared = StorageManager()
    
    private let database = Storage.storage().reference()
    
    private init() {}
    
    //Public
    
    public func getVideoURL(with identifier: String, completion: (URL) -> Void){
}

public func uploadVideoURL(from url: URL) {
    
}
}
