//
//  ViewController.swift
//  KhtfIosApp
//
//  Created by Konstantin on 30/09/2019.
//  Copyright © 2019 Ekahau. All rights reserved.
//

import UIKit
import KhtfIosAppFw

class ViewController03: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let curThread = Thread.current
        print("\(String(describing: curThread)): view3")
        
    }
    


}
