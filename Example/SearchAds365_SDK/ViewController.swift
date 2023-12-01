//
//  ViewController.swift
//  SearchAds365_SDK
//
//  Created by huazhenyun on 11/16/2023.
//  Copyright (c) 2023 huazhenyun. All rights reserved.
//

import UIKit
import StoreKit
import SearchAds365_SDK

class ViewController: UIViewController,SKProductsRequestDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        SAMobileSDK.track(event: "viewController_didAppear")
    }
    
    @IBAction func subscriptionAction(_ sender: Any) {
        
        let request = SKProductsRequest(productIdentifiers: ["XXXX"])
        request.delegate = self
        request.start()
    }
    
    
    @IBAction func consumptionAction(_ sender: Any) {
        
        let request = SKProductsRequest(productIdentifiers: ["xxxxx"])
        request.delegate = self
        request.start()
    }
    
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if let product = response.products.first {
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(payment)
        }
    }
}
