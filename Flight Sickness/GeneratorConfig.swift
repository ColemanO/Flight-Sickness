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
    static var config = GeneratorConfig()
    
    /******** Obstacle spawn rate **********/
    // new obstacle will be generated every generatorTicks
    var generatorTicks: Int64 = 100
    
    // rate at which generatorTicks is changed
    var rate: Int64 = -2
    
    // lowest # of ticks in between spawn
    var minTicks: Int64 = 45
    // hard mode
    var minTicksH: Int64 = 30
    
    // max # of obstacles that can be generated at once
    var maxObstaclesGenerated = 2
    
    // max # of power ups that can be generated at once
    var maxPowerUpsGenerated = 2
    /**************************************/
    
    // the chance for an Obstacle spawn to be a powerUp
    var powerUpChance = 0.3
    
    func updateTick() {
        var min: Int64
        if Settings.hardMode() {
            min = self.minTicksH
        } else {
            min = self.minTicks
        }
        
        if self.generatorTicks > min {
            self.generatorTicks += self.rate
        } else {
            self.generatorTicks = min
        }
    }
}
