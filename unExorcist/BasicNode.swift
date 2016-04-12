//
//  BasicNode.swift
//  unExorcist
//
//  Created by Terry on 16/3/29.
//  Copyright © 2016年 Terry. All rights reserved.
//

import UIKit
import GameplayKit
import SpriteKit

class BasicNode:GKComponent{
    
    var node:SKSpriteNode!
    
    init(code:String) {
        self.node = SKSpriteNode(imageNamed: code)
    }
    
}