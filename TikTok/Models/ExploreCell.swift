//
//  ExploreCell.swift
//  TikTok
//
//  Created by Акнур on 6/7/21.
//  Copyright © 2021 Aknur. All rights reserved.
//

import Foundation
import UIKit
enum ExploreCell{
      case banner(viewModel: ExploreBannerViewModel)
      case post(viewModel: ExplorePostViewModel)
      case hashtag(viewModel: ExploreHashtagViewModel)
      case user(viewModel: ExploreUserViewModel)
  }





