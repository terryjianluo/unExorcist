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
    
    init(manager:EntityManager) {
        entityManager = manager
    }
    
    override func didEnterWithPreviousState(previousState: GKState?) {
        countDown()
        playerInit()
    }
    
    func playerInit(){
        entityManager.addTeamMate(HeroEntity(id: "P0001", team: "partner"))
        entityManager.addTeamMate(HeroEntity(id: "P0001", team: "partner"))
        entityManager.addTeamMate(HeroEntity(id: "P0001", team: "partner"))
        entityManager.addTeamMate(HeroEntity(id: "P0001", team: "partner"))
        entityManager.addTeamMate(HeroEntity(id: "P0001", team: "partner"))
        
        entityManager.addTeamMate(HeroEntity(id: "P0001", team: "enemy"))
        entityManager.addTeamMate(HeroEntity(id: "P0001", team: "enemy"))
        entityManager.addTeamMate(HeroEntity(id: "P0001", team: "enemy"))
        entityManager.addTeamMate(HeroEntity(id: "P0001", team: "enemy"))
        entityManager.addTeamMate(HeroEntity(id: "P0001", team: "enemy"))
        
        for p in entityManager.teammates{
            p.componentForClass(BasicNode)?.node.position = CGPoint(x: entityManager.scene.size.width/2, y: entityManager.scene.size.width/4)
        }
        
        for e in entityManager.enemys{
            e.componentForClass(BasicNode)?.node.position = CGPoint(x: entityManager.scene.size.width/2, y: entityManager.scene.size.width*0.75)
        }
        
    }
    
    func countDown(){
        let countNumber = SKLabelNode(text: "4")
        countNumber.fontSize = 190
        countNumber.zPosition = 15
        countNumber.position = CGPoint(x: entityManager.scene.size.width/2, y: entityManager.scene.size.height/2)
        entityManager.scene.addChild(countNumber)
        
        let countActionDown = SKAction.scaleTo(0.1, duration: 1)
        let countActionUp = SKAction.scaleTo(1, duration: 1)
        
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
        countNumber.runAction(SKAction.sequence([countActionDown,countNumberChange3,countActionUp,countActionDown,countNumberChange2,countActionUp,countActionDown,countNumberChange1,countActionUp,countActionDown,countNumberChangeGo,countActionUp,SKAction.runBlock({
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
}

class GameOverState:GKState {
    let entityManager:EntityManager
    
    init(manager:EntityManager) {
        entityManager = manager
    }
}
