//
//  GameReadyState.swift
//  unExorcist
//
//  Created by Terry on 16/4/21.
//  Copyright © 2016年 Terry. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

class GameReadyState:GKState {
    
    let entityManager:EntityManager
    let gameScene:GameScene
    
    init(manager:EntityManager,scene:GameScene) {
        entityManager = manager
        gameScene = scene
    }
    
    override func didEnterWithPreviousState(previousState: GKState?) {
        countDown()
        playerInit()
    }
    
    func playerInit(){
        var a:CGFloat = 3.5
        var b:CGFloat = 3.5
        entityManager.addTeamMate(HeroEntity(id: "P0001", team: "partner"))
        entityManager.addTeamMate(HeroEntity(id: "P0001", team: "partner"))
        entityManager.addTeamMate(HeroEntity(id: "P0001", team: "partner"))
        entityManager.addTeamMate(HeroEntity(id: "P0001", team: "partner"))
        entityManager.addTeamMate(HeroEntity(id: "P0001", team: "partner"))
        
        entityManager.addEnemy(HeroEntity(id: "P0001", team: "enemy"))
        entityManager.addEnemy(HeroEntity(id: "P0001", team: "enemy"))
        entityManager.addEnemy(HeroEntity(id: "P0001", team: "enemy"))
        entityManager.addEnemy(HeroEntity(id: "P0001", team: "enemy"))
        entityManager.addEnemy(HeroEntity(id: "P0001", team: "enemy"))
        
        for p in entityManager.teammates{
            p.componentForClass(BasicNode)?.node.position = CGPoint(x: entityManager.scene.size.width*(a*0.1), y: entityManager.scene.size.height*0.4)
            a += 0.75
            let targetComponent = TargetComponent(selfEntity:p,manager: entityManager)
            p.addComponent(targetComponent)
            gameScene.components.addComponent(targetComponent)
            
        }
        
        for e in entityManager.enemys{
            e.componentForClass(BasicNode)?.node.position = CGPoint(x: entityManager.scene.size.width*(b*0.1), y: entityManager.scene.size.height*0.6)
            b += 0.75
            
            let targetComponent = TargetComponent(selfEntity:e,manager: entityManager)
            e.addComponent(targetComponent)
            gameScene.components.addComponent(targetComponent)
        }
        
    }
    
    func countDown(){
        let countNumber = SKLabelNode(text: "4")
        countNumber.fontSize = 190
        countNumber.zPosition = 15
        countNumber.position = CGPoint(x: entityManager.scene.size.width/2, y: entityManager.scene.size.height/2)
        entityManager.scene.addChild(countNumber)
        
        let countActionDown = SKAction.scaleTo(0.1, duration: 0.5)
        let countActionUp = SKAction.scaleTo(1, duration: 0.5)
        
        let countNumberChange3 = SKAction.runBlock({
            countNumber.text = "3"
        })
        let countNumberChange2 = SKAction.runBlock({
            countNumber.text = "2"
        })
        let countNumberChange1 = SKAction.runBlock({
            countNumber.text = "1"
        })
        let countNumberChangeGo = SKAction.runBlock({
            countNumber.text = "Go"
        })
        countNumber.runAction(SKAction.sequence([countActionDown,countNumberChange3,countActionUp,countActionDown,countNumberChange2,countActionUp,countActionDown,countNumberChange1,countActionUp,countActionDown,countNumberChangeGo,SKAction.runBlock({
            countNumber.removeFromParent()
            self.stateMachine?.enterState(GamePlayState)
        })]))
    }
    
}

class GamePlayState:GKState {
    let entityManager:EntityManager
    
    init(manager:EntityManager) {
        entityManager = manager
    }
    
    override func didEnterWithPreviousState(previousState: GKState?) {
        //Need write fight method
    }
    
    override func updateWithDeltaTime(seconds: NSTimeInterval) {
        super.updateWithDeltaTime(seconds)
        if (entityManager.enemysDie.count == 5 || entityManager.teammatesDie.count == 5) == true{
            self.stateMachine?.enterState(GameOverState)
        }else{
        for entity in entityManager.teammates{
            
            if entity.componentForClass(BasicProperty)?.HP <= 0{
                entityManager.removeTeamMate(entity)
            }else if entity.componentForClass(BasicProperty)?.updateTime == 0 {
                entity.componentForClass(AttackComponent)?.damage()
            }else{
                //entity attack method
                let strikeSpeed = (entity.componentForClass(BasicProperty)?.strikeSpeed)! as NSTimeInterval
                if entity.componentForClass(BasicProperty)?.updateTime > strikeSpeed{
                    entity.componentForClass(AttackComponent)?.damage()
                    entity.componentForClass(BasicProperty)?.updateTime = 0
                }
            }
            entity.componentForClass(EffectContainer)?.updateWithDeltaTime(seconds)
            entity.componentForClass(BasicProperty)?.updateTime += seconds
        }
        
        for entity in entityManager.enemys{
            
            if entity.componentForClass(BasicProperty)?.HP <= 0{
                entityManager.removeEnemy(entity)
            }else if entity.componentForClass(BasicProperty)?.updateTime == 0 {
                entity.componentForClass(AttackComponent)?.damage()
            }else{
                //entity attack method
                let strikeSpeed = (entity.componentForClass(BasicProperty)?.strikeSpeed)! as NSTimeInterval
                if entity.componentForClass(BasicProperty)?.updateTime > strikeSpeed{
                    entity.componentForClass(AttackComponent)?.damage()
                    entity.componentForClass(BasicProperty)?.updateTime = 0
                }
                }
            entity.componentForClass(EffectContainer)?.updateWithDeltaTime(seconds)
            entity.componentForClass(BasicProperty)?.updateTime += seconds
            }
        }       
    }
}

class GameOverState:GKState {
    let entityManager:EntityManager
    
    init(manager:EntityManager) {
        entityManager = manager
    }
    
    override func didEnterWithPreviousState(previousState: GKState?) {
        print("Game Over!!")
        if entityManager.teammatesDie.count == 5{
            print("Lose")
        }else if entityManager.enemysDie.count == 5{
            print("win")
        }
    }
}

class GameCheckOut: GKState {
    
    override func didEnterWithPreviousState(previousState: GKState?) {
        //Scene 转场
    }
    
}
