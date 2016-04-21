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

class Movement: GKAgent2D ,GKAgentDelegate{
    
    var myTarget:HeroEntity!

    init(targetEntity:HeroEntity) {
        super.init()
        myTarget = targetEntity
        myTarget.agent.position = float2(x: Float(myTarget.componentForClass(BasicNode)!.node.position.x), y: Float(myTarget.componentForClass(BasicNode)!.node.position.y))
        delegate = self
        move()
    }
    
    func move(){
        let seek = GKGoal(toSeekAgent: myTarget.agent)
        self.behavior = GKBehavior(goal: seek, weight: 1)
        
        self.maxSpeed = 15
        self.maxAcceleration = 4
        self.mass = 0.5
        
    }
    
    func agentDidUpdate(agent: GKAgent) {
        let spriteComponent = entity?.componentForClass(BasicNode.self)
        spriteComponent!.node.position = CGPoint(x: CGFloat(position.x), y: CGFloat(position.y))
        //print("test target ----- \(myTarget.agent.position) \(self.position)")
    }
    
    func agentWillUpdate(agent: GKAgent) {
        let spriteComponent = entity?.componentForClass(BasicNode.self)
        position = float2(x: Float(spriteComponent!.node.position.x), y: Float(spriteComponent!.node.position.y))
        //print("test target ----- \(myTarget.agent.position) \(self.position)")
    }
    
}