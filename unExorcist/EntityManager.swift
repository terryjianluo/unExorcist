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
            spriteNode.removeFromParent()
        }
        
        teammates.remove(entity)
    }
    
    func removeEnemy(entity: HeroEntity) {
        if let spriteNode = entity.componentForClass(BasicNode.self)?.node {
            spriteNode.removeFromParent()
        }
        
        enemys.remove(entity)
    }
    
    
}