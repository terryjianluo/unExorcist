//
//  GameScene.swift
//  unExorcist
//
//  Created by Terry on 16/3/25.
//  Copyright © 2016年 Terry. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var teammate = [HeroEntity]()
    var AiEnemy = [HeroEntity]()
    
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
        AiEnemy[0].componentForClass(BasicNode.self)?.node.position = CGPoint(x: size.width/2, y: size.height)
        for hero in teammate{
            entityManager.add(hero)
            print(hero.componentForClass(BasicNode)?.node.size)
        }
        for enemy in AiEnemy{
            entityManager.add(enemy)
        }
        for hero in teammate{
            let targetComponent = TargetComponent(selfEntity: hero, manager: entityManager)
            hero.addComponent(targetComponent)
        }
        for enemy in AiEnemy{
            let targetComponent = TargetComponent(selfEntity: enemy, manager: entityManager)
            enemy.addComponent(targetComponent)
        }
        
        //hero.updateWithDeltaTime(1)
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        let deltaTime = currentTime - lastUpdateTimeInterval
            lastUpdateTimeInterval = currentTime
            teammate[0].componentForClass(AttackComponent)!.updateWithDeltaTime(deltaTime)
            //enemy.componentForClass(DamageComponent)?.updateWithDeltaTime(deltaTime)
            //print("HP = \(enemy.componentForClass(BasicProperty)?.HP)")
    }
    
    func heroEntityInit(heroDic:NSDictionary){
        
        
    
    }
        
}
