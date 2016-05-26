//
//  EntityManager.swift
//  unExorcist
//
//  Created by Terry on 16/3/30.
//  Copyright © 2016年 Terry. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit


class EntityManager {
    
    var teammates = Set<HeroEntity>()
    var enemys = Set<HeroEntity>()
    let scene: SKScene
    
    var teammatesDie = Set<HeroEntity>()
    var enemysDie = Set<HeroEntity>()
    
    init(scene: SKScene) {
        self.scene = scene
    }
    
    func addTeamMate(entity: HeroEntity) {
        teammates.insert(entity)
        
        if let spriteNode = entity.componentForClass(BasicNode.self)?.node {
            scene.addChild(spriteNode)
        }
    }
    
    func addEnemy(entity: HeroEntity) {
        enemys.insert(entity)
        
        if let spriteNode = entity.componentForClass(BasicNode.self)?.node {
            scene.addChild(spriteNode)
            }
    }
    
    func removeTeamMate(entity: HeroEntity) {
        if let spriteNode = entity.componentForClass(BasicNode.self)?.node {
            //spriteNode.removeFromParent()
            spriteNode.color = UIColor.grayColor()
            spriteNode.colorBlendFactor = 0.8
        }
        
        //teammates.remove(entity)
        teammatesDie.insert(entity)
        entity.componentForClass(BasicProperty)?.team = "partnerDie"
    }
    
    func removeEnemy(entity: HeroEntity) {
        if let spriteNode = entity.componentForClass(BasicNode.self)?.node {
            //spriteNode.removeFromParent()
            spriteNode.color = UIColor.grayColor()
            spriteNode.colorBlendFactor = 0.8
        }
        
        //enemys.remove(entity)
        enemysDie.insert(entity)
        entity.componentForClass(BasicProperty)?.team = "enemyDie"
    }
    
    
}