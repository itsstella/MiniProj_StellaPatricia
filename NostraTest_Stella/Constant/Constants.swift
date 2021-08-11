//
//  Constants.swift
//  NostraTest_Stella
//
//  Created by Stella Patricia on 11/08/21.
//  Copyright © 2021 Stella Patricia. All rights reserved.
//

import Foundation
import UIKit

struct API_CONSTANT {
    static let BASE_URL = "https://api.opendota.com"
    static let GETDATA_URL = "/api/herostats"
}

struct IMG_CONSTANT {
    static let UP_ICON = UIImage(systemName: "chevron.up.square")
    static let DOWN_ICON = UIImage(systemName: "chevron.down.square")
    static let UNCHECK_ICON = UIImage(systemName: "square")
    static let CHECK_ICON = UIImage(systemName: "checkmark.square")
    static let LIKE_ICON = UIImage(systemName: "heart.fill")
    static let UNLIKE_ICON = UIImage(systemName: "heart")
}

enum sortType {
    case none
    case health
    case attack
    case mana
    case speed
}

enum sortTypeOrder {
    case highest
    case lowest
}
