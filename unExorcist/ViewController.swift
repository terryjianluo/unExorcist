//
//  ViewController.swift
//  unExorcist
//
//  Created by Terry on 15/9/20.
//  Copyright © 2015年 Terry. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //CoreDataManager().csv2Realm("playerProperty")
        let a = CoreDataManager().PropertyDictionary("P0001", dataModel: PlayerProperty.self)
        print(a)
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func serverTest(sender: UIButton) {
        let testData = PFObject(className: "testData")
        testData["score"] = 10
        testData["name"] = "Terry"
        //testData.objectId = "testData1"
        testData.saveInBackground()
    }

}

