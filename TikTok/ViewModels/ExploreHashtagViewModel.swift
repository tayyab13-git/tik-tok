//
//  ExploreHashtagViewModel.swift
//  TikTok
//
//  Created by Акнур on 6/7/21.
//  Copyright © 2021 Aknur. All rights reserved.
//

import Foundation
import UIKit
struct ExploreHashtagViewModel {
    let text: String
    let icon: UIImage?
    let count: Int
    let handler: (() -> Void)
}
