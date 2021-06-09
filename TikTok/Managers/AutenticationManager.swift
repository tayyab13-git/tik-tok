//
//  AutenticationManager.swift
//  TikTok
//
//  Created by Акнур on 5/18/21.
//  Copyright © 2021 Aknur. All rights reserved.
//

import Foundation

final class AuthManager {
    public static let shared = AuthManager()
    
    private init(){}
    
    enum SignInMethod {
        case email
        case facebook
        case goggle
    }
    
    public func signIn(with method: SignInMethod){
        
    }
    func signOut(){
        
    }
}
