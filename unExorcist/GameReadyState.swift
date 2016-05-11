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
    
    let myScene:SKScene
    var time = NSTimeInterval(0)
    
    init(scene:SKScene) {
        myScene = scene
    }
    
    override func updateWithDeltaTime(seconds: NSTimeInterval) {
        time += seconds
        
        if time > 4{
            stateMachine?.enterState(GamePlayState)
        }
    }
    
}

class GamePlayState:GKState {
    
}
