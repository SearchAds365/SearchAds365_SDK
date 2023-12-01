//
//  DYMError.swift
//  SearchAds365MobileSDK
//
//  Created by 靖核 on 2022/4/3.
//

import UIKit
import StoreKit

public class SAMError: NSError {

    private let DYMDomain = "com.SearchAds365MobileSDK.error"
    @objc public var dymCode: SAMErrorCode = .none

    init(_ error: Error) {
        if let error = error as? SKError {
            dymCode = SAMErrorCode(rawValue: error.code.rawValue) ?? .none
        }
        let error = error as NSError
        super.init(domain: DYMDomain, code: error.code, userInfo: error.userInfo)
    }

    init(code: Int, dymCode: SAMErrorCode = .none, message: String) {
        self.dymCode = dymCode
        super.init(domain: DYMDomain, code: code, userInfo: [NSLocalizedDescriptionKey:message])
    }

    init(code: SAMErrorCode = .none, message: String) {
        self.dymCode = code
        super.init(domain: DYMDomain, code: code.rawValue, userInfo: [NSLocalizedDescriptionKey:message])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc public enum SAMErrorCode: Int {
        case none    = 404
        case failed  = -200
        case succeed = 200
        
        // system storekit codes
        case unknown = 0
        case clientInvalid = 1 // client is not allowed to issue the request, etc.
        case paymentCancelled = 2 // user cancelled the request, etc.
        case paymentInvalid = 3 // purchase identifier was invalid, etc.
        case paymentNotAllowed = 4 // this device is not allowed to make the payment
        case storeProductNotAvailable = 5 // Product is not available in the current storefront
        case cloudServicePermissionDenied = 6 // user has not allowed access to cloud service information
        case cloudServiceNetworkConnectionFailed = 7 // the device could not connect to the nework
        case cloudServiceRevoked = 8 // user has revoked permission to use this cloud service
        case privacyAcknowledgementRequired = 9 // The user needs to acknowledge Apple's privacy policy
        case unauthorizedRequestData = 10 // The app is attempting to use SKPayment's requestData property, but does not have the appropriate entitlement
        case invalidOfferIdentifier = 11 // The specified subscription offer identifier is not valid
        case invalidSignature = 12 // The cryptographic signature provided is not valid
        case missingOfferParams = 13 // One or more parameters from SKPaymentDiscount is missing
        case invalidOfferPrice = 14
        
        // custom storekit codes
        case noProduct     = 2000 // No In-App Purchase product were found
        case unablePayment = 2001 // In-App Purchases are not allowed on this device
        case noPurchased   = 2002 // Not purchased
        case noReceipt     = 2003 // Can't find a valid receipt

        ///Custom URL Error
        case emptyRequest    = 4040 // Request url is nil
        case emptyData       = 4041 // Request data is empty
        case emptyResponse   = 4042 // Response is empty
        case authenticate    = 4003 // You need to be authenticated first
        case badRequest      = 4004 // Bad request
        case server          = 4005 // Server error
        case unableToDecode  = 4006 // We could not decode the response
        case missingParam    = 4007 // Missing some of the required params
        case invalidProperty = 4008 // Received invalid property data
        case encodingFailed  = 4009 // Parameters encoding failed
    }
    
    // MARK: - Common
    class var succeed: SAMError { return SAMError(code: .succeed, message: "Success!") }
    class var failed: SAMError { return SAMError(code: .failed, message: "Failed!")}
    // MARK: - StoreKit
    class var noProductIds: SAMError { return SAMError(code: .noProduct, message: "No In-App Purchase product identifiers were found.") }
    class var noProducts: SAMError { return SAMError(code: .noProduct, message: "No In-App Purchases were found.") }
    class var productRequestFail: SAMError { return SAMError(code: .failed, message: "Unable to fetch available In-App Purchase products at the moment.")}
    class var unablePayment: SAMError { return SAMError(code: .unablePayment, message: "In-App Purchases are not allowed on this device.") }
    class var noPurchased: SAMError { return SAMError(code: .noPurchased, message: "Not purchased.") }
    class var noReceipt: SAMError { return SAMError(code: .noReceipt, message: "Can't find a valid receipt.") }
    class var purchaseFailed: SAMError { return SAMError(code: .failed, message: "Product purchase failed.") }
    class var missSignParams: SAMError { return SAMError(code: .missingParam, message: "Missing offer signing required params") }
    // MARK: - Request Error
    class var emptyRequest: SAMError { return SAMError(code: .emptyRequest, message: "URL Request is nil.")}
    class var emptyData: SAMError {return SAMError(code: .emptyRequest, message: "Request data is empty.")}
    class var emptyResponse: SAMError {return SAMError(code: .emptyRequest, message: "Response is empty.")}
    class var authenticate: SAMError {return SAMError(code: .emptyRequest, message: "You need to be authenticated first.")}
    class var badRequest: SAMError {return SAMError(code: .emptyRequest, message: "Bad request.")}
    class var server: SAMError {return SAMError(code: .emptyRequest, message: "Server error.")}
    class var unableToDecode: SAMError {return SAMError(code: .emptyRequest, message: "We could not decode the response.")}
    class func missingParam(_ params: String) -> SAMError {
        return SAMError(code: .missingParam, message: "Missing some of the required params: `\(params)`")
    }
    class func invalidProperty(_ property: String, _ data: Any) -> SAMError {
        return SAMError(code: .invalidProperty, message: "Received invalid `\(property)`: `\(data)`")
    }
    class var encodingFailed: SAMError {return SAMError(code: .emptyRequest, message: "Parameters encoding failed.")}
    class var requestFailed: SAMError {return SAMError(code: .emptyRequest, message: "URL Request failed.")}
}
