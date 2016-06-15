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
        //rotation = tanValue()
        move()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func move(){
        let seek = GKGoal(toSeekAgent: myTarget.agent)
        let seek1 = GKGoal(toReachTargetSpeed: 155)
        self.behavior = GKBehavior(goals: [seek,seek1], andWeights: [2,3])
        
        self.maxSpeed = 150
        self.maxAcceleration = 4000
        self.mass = 0.4
        //self.rotation = 3.14
        //rotation = tanValue()
        print(self.rotation)
        
    }
    
    func agentDidUpdate(_ agent: GKAgent) {
        let spriteComponent = entity?.componentForClass(BasicNode.self)
        spriteComponent!.node.position = CGPoint(x: CGFloat(position.x), y: CGFloat(position.y))
        spriteComponent!.node.zRotation = CGFloat((agent as! GKAgent2D).rotation)
    }
    
    func agentWillUpdate(_ agent: GKAgent) {
        let spriteComponent = entity?.componentForClass(BasicNode.self)
        position = float2(x: Float(spriteComponent!.node.position.x), y: Float(spriteComponent!.node.position.y))
        //rotation = Float((spriteComponent?.node.zRotation)!)
        rotation = tanValue()
    }
    
    func tanValue() -> Float {
        let y = myTarget.agent.position.y - self.position.y
        let x = myTarget.agent.position.x - self.position.x
        var v = Float(0)
        
        if (x == 0) && (y > 0){
            v = Float(M_PI*0.5)
        }else if (x == 0) && (y < 0){
            v = Float(M_PI*1.5)
        }else if (x > 0) && (y < 0){
            v = atan(Float(y/x))
        }else if (x < 0) && (y > 0){
            v = atan(Float(y/x)) + Float(M_PI)
        }else if (x > 0) && (y > 0){
            v = atan(Float(y/x))
        }else if (x < 0) && (y < 0){
            v = atan(Float(y/x)) + Float(M_PI)
        }
        
        return v
    }
    
}
