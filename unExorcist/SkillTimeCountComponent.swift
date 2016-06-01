//
//  SkillTimeCountComponent.swift
//  unExorcist
//
//  Created by Terry on 16/5/31.
//  Copyright © 2016年 Terry. All rights reserved.
//

import Foundation
import GameplayKit

class SkillTimeCountComponent: GKComponent {
    
    var sumTime = NSTimeInterval(0)
    var timePerEffect = NSTimeInterval(0)
    var sumTimeCount = NSTimeInterval(0)
    var timePerEffectCount = NSTimeInterval(0)
    var skillConfig:[String:Double]!
    
    init(config:[String:Double]){
        super.init()
        sumTime = NSTimeInterval(config["sumTime"]!)
        timePerEffect = NSTimeInterval(config["timePerEffect"]!)
        skillConfig = config
        switch skillConfig["type"] {
        case SkillType.buff.rawValue?:
            (entity as! SkillEntity).componentForClass(BuffComponent)?.buff(skillConfig)
            break
        case SkillType.aoe.rawValue?:
            break
        case SkillType.control.rawValue?:
            break
        case SkillType.damage.rawValue?:
            break
        case SkillType.dot.rawValue?:
            break
        case SkillType.halo.rawValue?:
            break
        case SkillType.heal.rawValue?:
            break
        case SkillType.hot.rawValue?:
            break
        case SkillType.move.rawValue?:
            break
        default:
            break
        }
    }
    
    override func updateWithDeltaTime(seconds: NSTimeInterval) {
        super.updateWithDeltaTime(seconds)
        
        switch skillConfig["type"] {
        case SkillType.buff.rawValue?:
            if sumTimeCount > sumTime {
                (entity as! SkillEntity).componentForClass(BuffComponent)?.buffEnd()
                sumTimeCount = 0
            }
            break
        case SkillType.aoe.rawValue?:
            break
        case SkillType.control.rawValue?:
            break
        case SkillType.damage.rawValue?:
            break
        case SkillType.dot.rawValue?:
            break
        case SkillType.halo.rawValue?:
            break
        case SkillType.heal.rawValue?:
            break
        case SkillType.hot.rawValue?:
            break
        case SkillType.move.rawValue?:
            break
        default:
            break
        }
        
        
        
        sumTimeCount += seconds
        timePerEffectCount += seconds
    }
}