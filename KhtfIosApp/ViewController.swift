//
//  ViewController.swift
//  KhtfIosApp
//
//  Created by Konstantin on 30/09/2019.
//  Copyright © 2019 Ekahau. All rights reserved.
//

import UIKit
import KhtfIosAppFw

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("\(String(describing: Thread.current)): app started")
        
        //will not work for static .framework
        //let b1 = Bundle(for: KotlinInt.self)
        //let b2 = xxx.path(forResource: "fileFw", ofType: "txt")
        
        let khtfBundle = Bundle(url: Bundle.main.bundleURL.appendingPathComponent("KhtfIosAppFw.bundle"))!
        let resourcePath = khtfBundle.url(forResource: "colors", withExtension: "txt")!.absoluteString
        ColorProviderFactory().initialPathToFile = resourcePath
    
    
    
        //call call platform specific code
        PlatformColorProvider().addPlatformSpecificColor()
        
        
        let colorProvider = ColorProviderFactory().colorProvider
        print("\(String(describing: Thread.current)): red: \(colorProvider.getVal(key: "red"))")
        print("\(String(describing: Thread.current)): platform: \(colorProvider.getVal(key: "platform"))")
        
        //overwrite value
        colorProvider.putVal(key: "red", value: "#BB0000")
    
        print("\(String(describing: Thread.current)): kotlin color initialized")
      
        
    }
    
    @IBAction func open1(_ sender: Any) {
        self.navigationController?.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "ViewController01") as UIViewController, animated: true)
    }
    
    @IBAction func open2(_ sender: Any) {
        self.navigationController?.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "ViewController02") as UIViewController, animated: true)
    }
    
    @IBAction func open3(_ sender: Any) {
        self.navigationController?.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "ViewController03") as UIViewController, animated: true)
    }
}

