//
//  ViewController.swift
//  KhtfIosApp
//
//  Created by Konstantin on 30/09/2019.
//  Copyright © 2019 Ekahau. All rights reserved.
//

import UIKit
import KhtfIosAppFw

class ViewController02: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        let curThread = Thread.current
        print("\(String(describing: curThread)): view2")
    
        HistoryServiceFactoryKt.setDefaultHistoryServiceData(initialValue: "Monday")
        ModificationServiceFactoryKt.setDefaultModificationServiceData(mod1: "a", mod2: "b")
        
        
        
        //buttons
        let buttonX = 150
        let buttonY = 150
        let buttonWidth = 100
        let buttonHeight = 100
        
        let button1 = UIButton(type: .infoDark)
        button1.frame = CGRect(x: buttonX, y: buttonY, width: buttonWidth, height: buttonHeight)
        button1.addTarget(self, action: #selector(button1Clicked), for: .touchUpInside)
        self.view.addSubview(button1)
        
        let button2 = UIButton(type: .infoDark)
        button2.frame = CGRect(x: buttonX+200, y: buttonY, width: buttonWidth, height: buttonHeight)
        button2.addTarget(self, action: #selector(button2Clicked), for: .touchUpInside)
        self.view.addSubview(button2)
        
    }
    
    /**
   If this button clicked first, list content will be:
        Monday
        LibEntryPoint1.init ()
        LibEntryPoint1.init ()
        LibEntry1: From LibF
        LibEntryPoint1.init ()
        
       As libF initialize new LibEntryPoint1 at each method call. Note that ModificationService is not initialized yet.
    */
    @objc func button1Clicked(sender : UIButton){
    
        let curThread = Thread.current
        print("\(String(describing: curThread)): action 1 called in UI thread")
    
        let libFCase = LibFCase()
    
        print("\(String(describing: curThread)).content: \(libFCase.getContent())")
    
        //add one entity
        libFCase.doSomething()
    
        print("\(String(describing: curThread)).content: \(libFCase.getContent())")
        
    }
    
    /**
    If this button clicked first, list content will be:
         Monday
         ModificationService.init (a, b)
         aLibEntryPoint2.init ()
         aLibEntry2: From LibG
         aLibEntryPoint2.init ()
         bLibEntry2: From LibG
    */
    @objc func button2Clicked(sender : UIButton){
        
        let curThread = Thread.current
        print("\(String(describing: curThread)): action 2 called in UI thread")
    
        let libGCase = LibGCase()
    
        print("\(String(describing: curThread)).content: \(libGCase.getContent())")
    
        //execute in BG thread
        DispatchQueue.global(qos: .background).async {[weak self] in
            guard let strongSelf = self else { return }
    
            strongSelf.logMessageWithThread()
        
            //kotlin code that don't depend on mutable state could be called in any thread
            let independentService = IndependentService()
            print("\(String(describing: curThread)): " + independentService.format(s: "BG thread"))
    
            //execute in main thread
            DispatchQueue.main.async {[weak self] in
                guard let strongSelf = self else { return }
            
                let curThread = Thread.current
                //will reuse existing history service
                let libGCaseOther = LibGCase()
                
                print("\(String(describing: curThread)): called in UI thread inside DispatchQueue")
                print("\(String(describing: curThread)).content: \(libGCaseOther.getContent())")
                //add one entity
                libGCaseOther.doSomething2()
                
                print("\(String(describing: curThread)).content: \(libGCaseOther.getContent())")
                
            }
            
        }
        
        sleep(2)
    
        print("\(String(describing: curThread)): action 2 called in UI thread after sleep")
        
        //add one entity
        libGCase.doSomething1()
    
        print("\(String(describing: curThread)).content: \(libGCase.getContent())")
    
        logMessageWithThread()
    }
    

    /**
     This function execute kotlin code inside, and work in any thread.
    */
    func logMessageWithThread() {
        //kotlin code that don't depend on mutable state could be called in any thread
        let curThread = Thread.current
        let independentService = IndependentService()
        print("\(String(describing: curThread)): " + independentService.format(s: " <- BG or UI thread"))
    }


}
