//
//  ObstacleGenerator.swift
//  Flight Sickness
//
//  Created by William Lin on 11/21/17.
//  Copyright © 2017 Coleman. All rights reserved.
//

import Foundation
import SpriteKit

/*
 TODO:
 clean up:
 use array(bad)
 queue (better)
 reuse obstacles(best)
 
 mulitple spawns
 faster spawns?
 
 eventaully maybe handle seat generation as well.
 */
class ObstacleGenerator {
    // list of possible obstacles to generate
    let obstaclesTypes: [Obstacle.Type]
    let lanes: [CGFloat]
    
    init(_ obstaclesTypes: [Obstacle.Type], _ lanes: [CGFloat]) {
        self.obstaclesTypes = obstaclesTypes
        self.lanes = lanes
    }
    
    // determines which obstacle should be returned. Does not initialize them.
    func next(topScreen: CGFloat, bottomScreen: CGFloat) -> Obstacle {
        let lane: Int = Int(arc4random_uniform(UInt32(lanes.count)))
        let obstacleType: Int = Int(arc4random_uniform(UInt32(obstaclesTypes.count)))
        let newObstacle: Obstacle = obstaclesTypes[obstacleType].init()
        
        if (newObstacle.startFromTop) {
            newObstacle.setPosition(x: lanes[lane], y: topScreen + newObstacle.size.height)
        } else {
            let y = CGFloat(arc4random_uniform(UInt32(topScreen - bottomScreen + 500))) + bottomScreen
            newObstacle.setPosition(x: lanes[lane], y: y + newObstacle.size.height)
        }
        
        return newObstacle
    }
}

