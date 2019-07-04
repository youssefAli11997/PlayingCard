//
//  CGPoint_extension.swift
//  PlayingCard
//
//  Created by Owner on 7/4/19.
//  Copyright © 2019 Owner. All rights reserved.
//

import Foundation
import UIKit

extension CGPoint {
    func offsetBy(dx: CGFloat, dy: CGFloat) -> CGPoint {
        return CGPoint(x: x+dx, y: y+dy)
    }
}
