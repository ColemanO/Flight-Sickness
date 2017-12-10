//
//  GeneratorConfig.swift
//  Flight Sickness
//
//  Created by William Lin on 12/5/17.
//  Copyright © 2017 Coleman. All rights reserved.
//

/*
 eventually we can modify this class at runtime to change difficuly/level
 */
class GeneratorConfig {
    static let config = GeneratorConfig()
    
    // new obstacle will be generated every generatorTicks
    var generatorTicks: Int64 = 100
    
    // rate at which generatorTicks is changed
    var rate: Int64 = -2
    
    // lowest # of ticks in between spawn
    var minTicks: Int64 = 30
    
    // max # of obstacles that can be generated at once
    var maxObstaclesGenerated = 2
    
    // max # of power ups that can be generated at once
    var maxPowerUpsGenerated = 2
    
    func updateTick() {
        if self.generatorTicks > self.minTicks {
            self.generatorTicks += self.rate
        } else {
            self.generatorTicks = self.minTicks
        }
    }
}
