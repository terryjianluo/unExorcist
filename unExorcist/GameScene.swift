//
//  GameScene.swift
//  unExorcist
//
//  Created by Terry on 16/3/25.
//  Copyright © 2016年 Terry. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene{
    
    var components = GKComponentSystem(componentClass: TargetComponent.self)
   
    var lastUpdateTimeInterval: NSTimeInterval = 0
    var gameRules:GKStateMachine!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let a = SKLabelNode(text: "召唤师峡谷")
        a.position = CGPoint(x: size.width/2, y: size.height/2)
        a.fontColor = UIColor.whiteColor()
        a.zPosition = 1
        self.addChild(a)
        print(self.size)
        
        
        let entityManager = EntityManager(scene: self)
        gameRules = GKStateMachine(states: [GameReadyState(manager:entityManager,scene:self),GamePlayState(manager: entityManager),GameOverState(manager: entityManager),GameCheckOut()])
        gameRules.enterState(GameReadyState)
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        let deltaTime = currentTime - lastUpdateTimeInterval
            gameRules.updateWithDeltaTime(deltaTime)
            lastUpdateTimeInterval = currentTime
        
        //teammate[0].componentForClass(AttackComponent)!.updateWithDeltaTime(deltaTime)
            //enemy.componentForClass(DamageComponent)?.updateWithDeltaTime(deltaTime)
            //print("HP = \(enemy.componentForClass(BasicProperty)?.HP)")
        for component in components.components{
            component.updateWithDeltaTime(currentTime)
        }
        
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let uiTouchPoint = touch.locationInView(self.view)
            let touchPoint = CGPoint(x: (512 - (self.view?.frame.width)!/2) + uiTouchPoint.x , y:(768 - (uiTouchPoint.y * 768 / (self.view?.frame.height)!)))
            //AiEnemy[0].componentForClass(BasicNode)?.node.position = touchPoint
            //AiEnemy[0].agent.position = float2(x: Float(touchPoint.x), y: Float(touchPoint.y))
        }
        
    }
    
}
