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
    
    var entities = Set<HeroEntity>()
    let scene: SKScene
    
    init(scene: SKScene) {
        self.scene = scene
    }
    
    func add(entity: HeroEntity) {
        entities.insert(entity)
        
        if let spriteNode = entity.componentForClass(BasicNode.self)?.node {
            scene.addChild(spriteNode)
        }
    }
    
    func remove(entity: HeroEntity) {
        if let spriteNode = entity.componentForClass(BasicNode.self)?.node {
            spriteNode.removeFromParent()
        }
        
        entities.remove(entity)
    }
    
}