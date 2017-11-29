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
    // list of possible obstacles types to generate
    let obstaclesTypes: [Obstacle.Type]
    
    // list of lanes that obstacles can spawn in
    let lanes: [CGFloat]
    
    // keeps track of the # of free instances for each obstacle type
    var freeCounts = [Metatype<Obstacle>: Int]()
    
    // a linked list of free instances for each obstacle type
    var freeLists = [Metatype<Obstacle>: LinkedList<Obstacle>]()
    
    // list of obstacles that are visible (not in a free list)
    var activeObstacles = LinkedList<Obstacle>()
    
    init(_ obstaclesTypes: [Obstacle.Type], _ lanes: [CGFloat]) {
        self.obstaclesTypes = obstaclesTypes
        self.lanes = lanes
        
        // initialize the dictionaries
        for type in obstaclesTypes {
            freeCounts[type.metatype] = 0
            freeLists[type.metatype] = LinkedList<Obstacle>()
        }
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
        
        self.activeObstacles.append(newObstacle)
        
        return newObstacle
    }
    
    /*
      adds obstacles to the freeLists as they move off of screen.
      This lets us reuse them by changing their position and adding them back
      to the scene instead of instantiating new obstacles and letting swift garbage
      collect.
     */
    func collectObstacles(bottomScreen: CGFloat) {
        var node = self.activeObstacles.first
        while node != nil {
            let next = node!.next
            // if the obstacle is not visible anymore we can collect them
            if (node!.value.position.y < bottomScreen) {
                node!.value.removeFromParent()
                self.activeObstacles.remove(node: node!)
                self.freeLists[type(of: node!.value).metatype]!.append(node!)
                self.freeCounts[type(of: node!.value).metatype]! += 1
            }
            node = next
        }
    }
}

