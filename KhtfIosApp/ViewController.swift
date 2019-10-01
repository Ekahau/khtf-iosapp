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
    
        //either lib A or C, as depends on order resolved during compilation, names may change after recompiled
        let sum1  = Summator().sum(a: 4, b: 1)
        print("sum1: \(sum1)")
        let sum2  = Summator_().sum(a: 4, b: 1)
        print("sum2: \(sum2)")
        
        //lib B have companion object, so Summator__().sum() will not compile
        let sum3  = Summator__.Companion().sum(a: 4, b: 1)
        print("sum3: \(sum3)")
    
        //fw
        let sumFW  = SummatorFw().sum(a: 4, b: 1)
        print("sumFW: \(sumFW)")
    
        //fw lib A
        let sumFWa  = SummatorFw().sumA(a: 4, b: 1)
        print("sumFWa: \(sumFWa)")
    
        //fw lib C
        let sumFWc  = SummatorFw().sumC(a: 4, b: 1)
        print("sumFWc: \(sumFWc)")
    
        //fw lib C through class reference
        let summatorC = SummatorFw().getSummatorC()
        let sumFWrefC  = summatorC.sum(a: 4, b: 1)
        print("sumFWrefC: \(sumFWrefC)")
    
    }



}
