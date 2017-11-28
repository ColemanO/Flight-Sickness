//
//  Seat.swift
//  Flight Sickness
//
//  Created by William Lin on 11/23/17.
//  Copyright © 2017 Coleman. All rights reserved.
//

import Foundation
import SpriteKit

class Seat: Obstacle {
    required init() {
        let bagTexture = SKTexture(imageNamed: "seat")
        super.init(texture: bagTexture, color: UIColor.clear, size: bagTexture.size())
        self.setScale(2.5)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
