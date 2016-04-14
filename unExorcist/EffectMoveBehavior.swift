//
//  EffectMoveBehavior.swift
//  unExorcist
//
//  Created by Terry on 16/4/8.
//  Copyright © 2016年 Terry. All rights reserved.
//

import GameplayKit
import SpriteKit

class EffectMoveBehavior:GKBehavior {
    
    init(targetSpeed: Float, seek: GKAgent, avoid: [GKAgent]) {
        super.init()
        // 2
        if targetSpeed > 0 {
            // 3
            setWeight(0.1, forGoal: GKGoal(toReachTargetSpeed: targetSpeed))
            // 4
            setWeight(0.5, forGoal: GKGoal(toSeekAgent: seek))
            // 5
            //setWeight(1.0, forGoal: GKGoal(toAvoidAgents: avoid, maxPredictionTime: 1.0))
        }
    }
    
}
