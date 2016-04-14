//
//  EffectEntity.swift
//  unExorcist
//
//  Created by Terry on 16/4/14.
//  Copyright © 2016年 Terry. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class EffectEntity:GKEntity {
    
    init(id:String) {
        super.init()
        let spriteComponent = BasicNode(code: id)
        addComponent(spriteComponent)
    }
    
    
}
