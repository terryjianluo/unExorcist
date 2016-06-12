//
//  SkillCooldownComponent.swift
//  unExorcist
//
//  Created by Terry on 16/6/12.
//  Copyright © 2016年 Terry. All rights reserved.
//

import Foundation
import GameplayKit

class SkillCooldownComponent: GKComponent {
    
    var cd = NSTimeInterval(0)
    
    override func updateWithDeltaTime(seconds: NSTimeInterval) {
        cd -= seconds
    }
    
}