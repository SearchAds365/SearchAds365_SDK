//
//  DYMIPAManager.swift
//  SearchAds365MobileSDK
//
//  Created by 靖核 on 2022/4/4.
//

import UIKit
import StoreKit

class SAMIAPManager: NSObject, SKPaymentTransactionObserver {

    static let shared = SAMIAPManager()
    override private init() { super.init() }
    
    var productId:String = ""
    var requestProductsCompletion:RequestProductsCompletion?
    
    func startObserverPurchase() {
        startObserving()
        
        NotificationCenter.default.addObserver(forName: Notification.Name.UIApplicationWillTerminate, object: nil, queue: .main) { notification in
            self.stopObserving()
        }
    }
    
    // MARK: - Observer
    ///开启支付监控
    private func startObserving() {
        SKPaymentQueue.default().add(self)
    }
    ///关闭支付监控
    private func stopObserving() {
        SKPaymentQueue.default().remove(self)
    }
    
    ///SKPaymentTransactionObserver
    //Observe transaction updates.
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        var latestTransaction: SKPaymentTransaction?
        for transaction in transactions {
            if transaction.transactionState == .purchased, let transactionDate = transaction.transactionDate {
                if let latest = latestTransaction {
                    if transactionDate > latest.transactionDate! {
                        latestTransaction = transaction
                    }
                } else {
                    latestTransaction = transaction
                }
            }
        }
        if let latest = latestTransaction {
            handlePurchase(transaction: latest)
        }
    }
    
    func handlePurchase(transaction: SKPaymentTransaction) {
        guard let transactionId = transaction.transactionIdentifier else {return}
        
        var productModel = ProductPurchaseInfo(transactionId: transactionId, quantity: transaction.payment.quantity, productId: transaction.payment.productIdentifier)
        
        let productIdentifier = transaction.payment.productIdentifier
        self.productId = productIdentifier
        
        if let transactionDate = transaction.transactionDate {
            productModel.transactionDate = Int64(transactionDate.timeIntervalSince1970 * 1000)
        }
        
        if let original = transaction.original {
            if let id = original.transactionIdentifier {
                productModel.originalTransactionId = id
            }
            if let date = original.transactionDate {
                productModel.originalTransactionDate = Int64(date.timeIntervalSince1970 * 1000)
            }
        }

        fetchProductInformation(productIdentifier: productIdentifier) { skproduct in
            if let product = skproduct {

                productModel.price = product.price.stringValue
                productModel.currencyCode = product.priceLocale.currencyCode
                productModel.regionCode = product.priceLocale.regionCode
                if #available(iOS 12.0, *) {
                    productModel.subscriptionGroupId = product.subscriptionGroupIdentifier
                }
                if #available(iOS 11.2, *) {
                    if let subscriptionPeriod = product.subscriptionPeriod {
                        productModel.subscriptionPeriodNumberOfUnits = "\(subscriptionPeriod.numberOfUnits)"
                        productModel.subscriptionPeriodUnit = subscriptionPeriod.unit.name
                    }
                }
            }

            ProductInfoAPI.reportPurchaseInfo(X_USER_ID: UserProperties.requestUUID, userAgent: UserProperties.userAgent, X_APP_ID: SAMConstants.APIKeys.appId, X_PLATFORM: .ios, X_VERSION: UserProperties.sdkVersion, productReportObject: productModel) { data, error in
                
            }
        }
    }
    
    func fetchProductInformation(productIdentifier: String, completion:@escaping RequestProductsCompletion) {
        self.requestProductsCompletion = completion
        
        let productIdentifiers: Set<String> = [productIdentifier]
        let productsRequest = SKProductsRequest(productIdentifiers: productIdentifiers)
        productsRequest.delegate = self
        productsRequest.start()
    }
}

extension SAMIAPManager:SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        guard let product = response.products.first(where: { $0.productIdentifier == self.productId }) else { return }
        self.requestProductsCompletion?(product)
    }
}

@available(iOS 11.2, *)
extension SKProduct.PeriodUnit {
    var name: String {
        switch self {
        case .day:
            return "day"
        case .week:
            return "week"
        case .month:
            return "month"
        case .year:
            return "year"
        }
    }
}
