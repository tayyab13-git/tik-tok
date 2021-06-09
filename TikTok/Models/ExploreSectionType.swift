//
//  ExploreSectionType.swift
//  TikTok
//
//  Created by Акнур on 6/7/21.
//  Copyright © 2021 Aknur. All rights reserved.
//

import Foundation
enum ExploreSectionType: CaseIterable{
     case banners
     case trendingPosts
     case users
     case trendingHashtags
     case recommended
     case popular
     case new
     
     var title: String{
         switch self {
         case .banners:
             return "Featured"
         case .trendingPosts:
             return "Trending Videos"
         case .trendingHashtags:
             return "Hashtags"
         case .recommended:
             return "Recommended"
         case .popular:
           return  "Popular"
         case .new:
           return  "Recently Posted"
         case .users:
             return " Popular Creators"
         }
     }
 }
