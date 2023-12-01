//
//  ProductInfoAPI.swift
//  SearchAds365_SDK
//
//  Created by apple on 2023/11/21.
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

open class ProductInfoAPI {
    /**
     * enum for parameter X_PLATFORM
     */
    public enum XPLATFORM_productInfo: String, CaseIterable {
        case ios = "ios"
        case android = "android"
    }
    
    /**
     report purchase info
     
     - parameter X_USER_ID: (header) an unique string represents the current user
     - parameter userAgent: (header) user agent
     - parameter X_APP_ID: (header) an unique string represents the current user
     - parameter X_PLATFORM: (header) an unique string represents the current user
     - parameter X_VERSION: (header) sdk version
     - parameter productReportObject: (body)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    @discardableResult
    open class func reportPurchaseInfo(X_USER_ID: String, userAgent: String, X_APP_ID: String, X_PLATFORM: XPLATFORM_productInfo, X_VERSION: String, productReportObject: ProductPurchaseInfo, apiResponseQueue: DispatchQueue = OpenAPIClientAPI.apiResponseQueue, completion: @escaping ((_ data: SimpleStatusResult?, _ error: Error?) -> Void)) -> RequestTask {
        return reportPurchaseInfoWithRequestBuilder(X_USER_ID: X_USER_ID, userAgent: userAgent, X_APP_ID: X_APP_ID, X_PLATFORM: X_PLATFORM, X_VERSION: X_VERSION, productReportObject: productReportObject).execute(apiResponseQueue) { result in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }
    
    /**
     report purchase info
     - POST /order/report
     - report a user's session start. it will create a new user if does not seen this user before
     - API Key:
       - type: apiKey X-API-KEY
       - name: ApiKeyAuth
     - parameter X_USER_ID: (header) an unique string represents the current user
     - parameter userAgent: (header) user agent
     - parameter X_APP_ID: (header) an unique string represents the current user
     - parameter X_PLATFORM: (header) an unique string represents the current user
     - parameter X_VERSION: (header) sdk version
     - parameter productReportObject: (body)
     - returns: RequestBuilder<ReportSessionResult>
     */
    open class func reportPurchaseInfoWithRequestBuilder(X_USER_ID: String, userAgent: String, X_APP_ID: String, X_PLATFORM: XPLATFORM_productInfo, X_VERSION: String, productReportObject: ProductPurchaseInfo) -> RequestBuilder<SimpleStatusResult> {
        let localVariablePath = "/order/report"
        let localVariableURLString = OpenAPIClientAPI.basePath + localVariablePath
        let localVariableParameters = JSONEncodingHelper.encodingParameters(forEncodableObject: productReportObject)

        let localVariableUrlComponents = URLComponents(string: localVariableURLString)
        let X_API_KEY = SAMConstants.APIKeys.secretKey
        let localVariableNillableHeaders: [String: Any?] = [
            "X-USER-ID": X_USER_ID.encodeToJSON(),
            "User-Agent": userAgent.encodeToJSON(),
            "X-APP-ID": X_APP_ID.encodeToJSON(),
            "X-PLATFORM": X_PLATFORM.encodeToJSON(),
            "X-VERSION": X_VERSION.encodeToJSON(),
            "X-API-KEY":X_API_KEY.encodeToJSON()
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<SimpleStatusResult>.Type = OpenAPIClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "POST", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters)
    }
}
