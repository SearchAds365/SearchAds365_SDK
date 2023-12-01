//
//  AttributionAPI.swift
//  SearchAds365_SDK
//
//  Created by apple on 2023/11/21.
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

open class AttributionAPI {

    /**
     * enum for parameter X_PLATFORM
     */
    public enum XPLATFORM_attributionData: String, CaseIterable {
        case ios = "ios"
        case android = "android"
    }

    /**
     report attribution data for certain attribution networks
     
     - parameter X_USER_ID: (header) an unique string represents the current user 
     - parameter userAgent: (header) user agent 
     - parameter X_APP_ID: (header) an unique string represents the current user 
     - parameter X_PLATFORM: (header) an unique string represents the current user 
     - parameter X_VERSION: (header) sdk version 
     - parameter attribution: (body)  (optional)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    @discardableResult
    open class func attributionData(X_USER_ID: String, userAgent: String, X_APP_ID: String, X_PLATFORM: XPLATFORM_attributionData, X_VERSION: String, attribution: Attribution? = nil, apiResponseQueue: DispatchQueue = OpenAPIClientAPI.apiResponseQueue, completion: @escaping ((_ data: SimpleStatusResult?, _ error: Error?) -> Void)) -> RequestTask {
        return attributionDataWithRequestBuilder(X_USER_ID: X_USER_ID, userAgent: userAgent, X_APP_ID: X_APP_ID, X_PLATFORM: X_PLATFORM, X_VERSION: X_VERSION, attribution: attribution).execute(apiResponseQueue) { result in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     report attribution data for certain attribution networks
     - POST /attribution/report
     - report attribution data for certain attribution networks. see query parameters for supported network list
     - API Key:
       - type: apiKey X-API-KEY 
       - name: ApiKeyAuth
     - parameter X_USER_ID: (header) an unique string represents the current user 
     - parameter userAgent: (header) user agent 
     - parameter X_APP_ID: (header) an unique string represents the current user 
     - parameter X_PLATFORM: (header) an unique string represents the current user 
     - parameter X_VERSION: (header) sdk version 
     - parameter attribution: (body)  (optional)
     - returns: RequestBuilder<SimpleStatusResult> 
     */
    open class func attributionDataWithRequestBuilder(X_USER_ID: String, userAgent: String, X_APP_ID: String, X_PLATFORM: XPLATFORM_attributionData, X_VERSION: String, attribution: Attribution? = nil) -> RequestBuilder<SimpleStatusResult> {
        let localVariablePath = "/attribution/report"
        let localVariableURLString = OpenAPIClientAPI.basePath + localVariablePath
        let localVariableParameters = JSONEncodingHelper.encodingParameters(forEncodableObject: attribution)

        let localVariableUrlComponents = URLComponents(string: localVariableURLString)
        let X_API_KEY = SAMConstants.APIKeys.secretKey
        let localVariableNillableHeaders: [String: Any?] = [
            "X-USER-ID": X_USER_ID.encodeToJSON(),
            "User-Agent": userAgent.encodeToJSON(),
            "X-APP-ID": X_APP_ID.encodeToJSON(),
            "X-PLATFORM": X_PLATFORM.encodeToJSON(),
	        "X-VERSION": X_VERSION.encodeToJSON(),
            "X-API-KEY": X_API_KEY.encodeToJSON()
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<SimpleStatusResult>.Type = OpenAPIClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "POST", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters)
    }

    /**
     * enum for parameter X_PLATFORM
     */
    public enum XPLATFORM_reportSearchAdsAttr: String, CaseIterable {
        case ios = "ios"
        case android = "android"
    }

    /**
     report search ads attribution data
     
     - parameter X_USER_ID: (header) an unique string represents the current user 
     - parameter userAgent: (header) user agent 
     - parameter X_APP_ID: (header) an unique string represents the current user 
     - parameter X_PLATFORM: (header) an unique string represents the current user 
     - parameter X_VERSION: (header) sdk version 
     - parameter appleSearchAdsAttributionReportObject: (body)  
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    @discardableResult
    open class func reportSearchAdsAttr(X_USER_ID: String, userAgent: String, X_APP_ID: String, X_PLATFORM: XPLATFORM_reportSearchAdsAttr, X_VERSION: String, appleSearchAdsAttributionReportObject: AppleSearchAdsAttributionReportObject, apiResponseQueue: DispatchQueue = OpenAPIClientAPI.apiResponseQueue, completion: @escaping ((_ data: SimpleStatusResult?, _ error: Error?) -> Void)) -> RequestTask {
        return reportSearchAdsAttrWithRequestBuilder(X_USER_ID: X_USER_ID, userAgent: userAgent, X_APP_ID: X_APP_ID, X_PLATFORM: X_PLATFORM, X_VERSION: X_VERSION, appleSearchAdsAttributionReportObject: appleSearchAdsAttributionReportObject).execute(apiResponseQueue) { result in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     report search ads attribution data
     - POST /searchads/report
     - report search ads attribution data. iOS only
     - API Key:
       - type: apiKey X-API-KEY 
       - name: ApiKeyAuth
     - parameter X_USER_ID: (header) an unique string represents the current user 
     - parameter userAgent: (header) user agent 
     - parameter X_APP_ID: (header) an unique string represents the current user 
     - parameter X_PLATFORM: (header) an unique string represents the current user 
     - parameter X_VERSION: (header) sdk version 
     - parameter appleSearchAdsAttributionReportObject: (body)  
     - returns: RequestBuilder<SimpleStatusResult> 
     */
    open class func reportSearchAdsAttrWithRequestBuilder(X_USER_ID: String, userAgent: String, X_APP_ID: String, X_PLATFORM: XPLATFORM_reportSearchAdsAttr, X_VERSION: String, appleSearchAdsAttributionReportObject: AppleSearchAdsAttributionReportObject) -> RequestBuilder<SimpleStatusResult> {
        let localVariablePath = "/searchads/report"
        let localVariableURLString = OpenAPIClientAPI.basePath + localVariablePath
        let localVariableParameters = JSONEncodingHelper.encodingParameters(forEncodableObject: appleSearchAdsAttributionReportObject)

        let localVariableUrlComponents = URLComponents(string: localVariableURLString)
        let X_API_KEY = SAMConstants.APIKeys.secretKey
        let localVariableNillableHeaders: [String: Any?] = [
            "X-USER-ID": X_USER_ID.encodeToJSON(),
            "User-Agent": userAgent.encodeToJSON(),
            "X-APP-ID": X_APP_ID.encodeToJSON(),
            "X-PLATFORM": X_PLATFORM.encodeToJSON(),
	        "X-VERSION": X_VERSION.encodeToJSON(),
            "X-API-KEY": X_API_KEY.encodeToJSON()
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<SimpleStatusResult>.Type = OpenAPIClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "POST", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters)
    }
}
