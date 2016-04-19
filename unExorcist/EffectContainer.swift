//
//  EffectContainer.swift
//  unExorcist
//
//  Created by Terry on 16/4/19.
//  Copyright © 2016年 Terry. All rights reserved.
//

import Foundation
import GameplayKit

class EffectContainer:GKComponent {
    
    var effects = Set<EffectEntity>()
    
    func addEffect(effect:EffectEntity){
        effects.insert(effect)
    }
    
    func removeEffect(effect:EffectEntity){
        effects.remove(effect)
    }
    
    override func updateWithDeltaTime(seconds: NSTimeInterval) {
        for effect in effects {
            effect.updateWithDeltaTime(seconds)
        }
    }
}