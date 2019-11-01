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
        
        print("\(String(describing: Thread.current)): view3")
        
        let colorProvider = ColorProviderFactory().colorProvider
        print("\(String(describing: Thread.current)): red:  \(colorProvider.getVal(key: "red"))")
    
        //execute in BG thread
        DispatchQueue.global(qos: .background).async {[weak self] in
            guard let strongSelf = self else { return }
        
            //kotlin code that don't depend on mutable state could be called in any thread
        
            //execute in main thread
            DispatchQueue.main.async {[weak self] in
                guard let strongSelf = self else { return }
    
                let colorProvider3 = ColorProviderFactory().colorProvider
                print("\(String(describing: Thread.current))(in callback): red: \(colorProvider3.getVal(key: "red"))")
            
            }
        
        }
        
    }
    


}
