//
//  Movement.swift
//  unExorcist
//
//  Created by Terry on 16/3/29.
//  Copyright © 2016年 Terry. All rights reserved.
//

import UIKit
import GameplayKit
import SpriteKit

class Movement: GKAgent2D, GKAgentDelegate {
    
    let entityManager: EntityManager
    
    // 3
    init(maxSpeed: Float, maxAcceleration: Float, radius: Float, entityManager: EntityManager) {
        self.entityManager = entityManager
        super.init()
        delegate = self
        self.maxSpeed = maxSpeed
        self.maxAcceleration = maxAcceleration
        self.radius = radius
        print(self.mass)
        self.mass = 0.01
    }
    
    // 4
    func agentWillUpdate(agent: GKAgent) {
        guard let spriteComponent = entity?.componentForClass(BasicNode.self) else {
            return
        }
        
        position = float2(spriteComponent.node.position)
    }
    
    // 5
    func agentDidUpdate(agent: GKAgent) {
        guard let spriteComponent = entity?.componentForClass(BasicNode.self) else {
            return
        }
        
        //spriteComponent.node.position = CGPoint(position)
    }
    
    
}