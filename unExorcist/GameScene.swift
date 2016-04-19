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
    
    var teammate = [HeroEntity]()
    var AiEnemy = [HeroEntity]()
    var components = GKComponentSystem(componentClass: TargetComponent.self)
    
    var lastUpdateTimeInterval: NSTimeInterval = 0
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        //self.view?.backgroundColor = UIColor.brownColor()
        let a = SKLabelNode(text: "hello world \n morning star")
        a.position = CGPoint(x: size.width/2, y: size.height/2)
        a.fontColor = UIColor.whiteColor()
        a.zPosition = 5
        self.addChild(a)
        print(self.size)
        
        let entityManager = EntityManager(scene: self)
        teammate.append(HeroEntity(id: "P0001",team: "partner"))
        AiEnemy.append(HeroEntity(id: "P0001", team: "enemy"))
        teammate[0].componentForClass(BasicNode.self)?.node.position = CGPoint(x: size.width/2, y: size.height/2)
        AiEnemy[0].componentForClass(BasicNode.self)?.node.position = CGPoint(x: size.width/2, y: size.height*0.75)
        for hero in teammate{
            entityManager.add(hero)
            print(hero.componentForClass(BasicNode)?.node.size)
        }
        for enemy in AiEnemy{
            entityManager.add(enemy)
        }
        for hero in teammate{
            let targetComponent = TargetComponent(selfEntity:hero,manager: entityManager)
            hero.addComponent(targetComponent)
            components.addComponent(targetComponent)
        }
        for enemy in AiEnemy{
            let targetComponent = TargetComponent(selfEntity:enemy,manager: entityManager)
            components.addComponent(targetComponent)
        }
        
        //hero.updateWithDeltaTime(1)
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        let deltaTime = currentTime - lastUpdateTimeInterval
        teammate[0].componentForClass(AttackComponent)!.updateWithDeltaTime(deltaTime)
            //enemy.componentForClass(DamageComponent)?.updateWithDeltaTime(deltaTime)
            //print("HP = \(enemy.componentForClass(BasicProperty)?.HP)")
        for component in components.components{
            component.updateWithDeltaTime(currentTime)
        }
        
        teammate[0].componentForClass(EffectContainer)?.updateWithDeltaTime(0.1)
        lastUpdateTimeInterval = currentTime
        
    }
    
    func heroEntityInit(heroDic:NSDictionary){
    
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let uiTouchPoint = touch.locationInView(self.view)
            let touchPoint = CGPoint(x: (512 - (self.view?.frame.width)!/2) + uiTouchPoint.x , y:(768 - (uiTouchPoint.y * 768 / (self.view?.frame.height)!)))
            print(touchPoint)
            AiEnemy[0].componentForClass(BasicNode)?.node.position = touchPoint
            AiEnemy[0].agent.position = float2(x: Float(touchPoint.x), y: Float(touchPoint.y))
        }
    }
    
}
