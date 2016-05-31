//
//  AOEComponent.swift
//  unExorcist
//
//  Created by Terry on 16/4/14.
//  Copyright © 2016年 Terry. All rights reserved.
//

import Foundation
import GameplayKit
import UIKit

class AOEComponent: GKComponent{
    
    var point:CGPoint!
    var target:[HeroEntity]!
    
    init(targets:[HeroEntity],centerPoint:CGPoint) {
        super.init()
        point = centerPoint
        target = targets
    }
}
