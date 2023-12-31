//
//  SessionsAPI.swift
//  SearchAds365_SDK
//
//  Created by apple on 2023/11/21.
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

open class SessionsAPI {

    /**
     * enum for parameter X_PLATFORM
     */
    public enum XPLATFORM_reportEvents: String, CaseIterable {
        case ios = "ios"
        case android = "android"
    }

    /**
     report events
     
     - parameter X_USER_ID: (header) an unique string represents the current user 
     - parameter userAgent: (header) user agent 
     - parameter X_APP_ID: (header) an unique string represents the current user 
     - parameter X_PLATFORM: (header) an unique string represents the current user 
     - parameter X_VERSION: (header) sdk version 
     - parameter eventReportObject: (body)  
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    @discardableResult
    open class func reportEvents(X_USER_ID: String, userAgent: String, X_APP_ID: String, X_PLATFORM: XPLATFORM_reportEvents, X_VERSION: String, eventReportObject: EventReportObject, apiResponseQueue: DispatchQueue = OpenAPIClientAPI.apiResponseQueue, completion: @escaping ((_ data: SimpleStatusResult?, _ error: Error?) -> Void)) -> RequestTask {
        return reportEventsWithRequestBuilder(X_USER_ID: X_USER_ID, userAgent: userAgent, X_APP_ID: X_APP_ID, X_PLATFORM: X_PLATFORM, X_VERSION: X_VERSION, eventReportObject: eventReportObject).execute(apiResponseQueue) { result in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     report events
     - POST /users/report/events
     - API Key:
       - type: apiKey X-API-KEY 
       - name: ApiKeyAuth
     - parameter X_USER_ID: (header) an unique string represents the current user 
     - parameter userAgent: (header) user agent 
     - parameter X_APP_ID: (header) an unique string represents the current user 
     - parameter X_PLATFORM: (header) an unique string represents the current user 
     - parameter X_VERSION: (header) sdk version 
     - parameter eventReportObject: (body)  
     - returns: RequestBuilder<SimpleStatusResult> 
     */
    open class func reportEventsWithRequestBuilder(X_USER_ID: String, userAgent: String, X_APP_ID: String, X_PLATFORM: XPLATFORM_reportEvents, X_VERSION: String, eventReportObject: EventReportObject) -> RequestBuilder<SimpleStatusResult> {
        let localVariablePath = "/users/report/events"
        let localVariableURLString = OpenAPIClientAPI.basePath + localVariablePath
        let localVariableParameters = JSONEncodingHelper.encodingParameters(forEncodableObject: eventReportObject)

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

    /**
     * enum for parameter X_PLATFORM
     */
    public enum XPLATFORM_reportSession: String, CaseIterable {
        case ios = "ios"
        case android = "android"
    }

    /**
     report session start
     
     - parameter X_USER_ID: (header) an unique string represents the current user 
     - parameter userAgent: (header) user agent 
     - parameter X_APP_ID: (header) an unique string represents the current user 
     - parameter X_PLATFORM: (header) an unique string represents the current user 
     - parameter X_VERSION: (header) sdk version 
     - parameter uniqueUserObject: (body)  
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    @discardableResult
    open class func reportSession(X_USER_ID: String, userAgent: String, X_APP_ID: String, X_PLATFORM: XPLATFORM_reportSession, X_VERSION: String, uniqueUserObject: UniqueUserObject, apiResponseQueue: DispatchQueue = OpenAPIClientAPI.apiResponseQueue, completion: @escaping ((_ data: ReportSessionResult?, _ error: Error?) -> Void)) -> RequestTask {
        return reportSessionWithRequestBuilder(X_USER_ID: X_USER_ID, userAgent: userAgent, X_APP_ID: X_APP_ID, X_PLATFORM: X_PLATFORM, X_VERSION: X_VERSION, uniqueUserObject: uniqueUserObject).execute(apiResponseQueue) { result in
            switch result {
            case let .success(response):
                    completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     report session start
     - POST /sessions/report
     - report a user's session start. it will create a new user if does not seen this user before
     - API Key:
       - type: apiKey X-API-KEY 
       - name: ApiKeyAuth
     - parameter X_USER_ID: (header) an unique string represents the current user 
     - parameter userAgent: (header) user agent 
     - parameter X_APP_ID: (header) an unique string represents the current user 
     - parameter X_PLATFORM: (header) an unique string represents the current user 
     - parameter X_VERSION: (header) sdk version 
     - parameter uniqueUserObject: (body)  
     - returns: RequestBuilder<ReportSessionResult>
     */
    open class func reportSessionWithRequestBuilder(X_USER_ID: String, userAgent: String, X_APP_ID: String, X_PLATFORM: XPLATFORM_reportSession, X_VERSION: String, uniqueUserObject: UniqueUserObject) -> RequestBuilder<ReportSessionResult> {
        let localVariablePath = "/sessions/report"
        let localVariableURLString = OpenAPIClientAPI.basePath + localVariablePath
        let localVariableParameters = JSONEncodingHelper.encodingParameters(forEncodableObject: uniqueUserObject)

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

        let localVariableRequestBuilder: RequestBuilder<ReportSessionResult>.Type = OpenAPIClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "POST", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters)
    }

    /**
     * enum for parameter X_PLATFORM
     */
    public enum XPLATFORM_reportType: String, CaseIterable {
        case ios = "ios"
        case android = "android"
    }

    /**
     * enum for parameter type
     */
    public enum ModelType_reportType: String, CaseIterable {
        case idfa = "idfa"
        case deviceToken = "device_token"
    }

    /**
     report idfa or deviceToken

     - parameter X_USER_ID: (header) an unique string represents the current user
     - parameter userAgent: (header) user agent
     - parameter X_APP_ID: (header) an unique string represents the current user
     - parameter X_PLATFORM: (header) an unique string represents the current user
     - parameter X_VERSION: (header) sdk version 
     - parameter type: (path)
     - parameter body: (body) test text/plain
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    @discardableResult
    open class func reportType(X_USER_ID: String, userAgent: String, X_APP_ID: String, X_PLATFORM: XPLATFORM_reportType, X_VERSION: String, type: ModelType_reportType, body: String, apiResponseQueue: DispatchQueue = OpenAPIClientAPI.apiResponseQueue, completion: @escaping ((_ data: SimpleStatusResult?, _ error: Error?) -> Void)) -> RequestTask {
        return reportTypeWithRequestBuilder(X_USER_ID: X_USER_ID, userAgent: userAgent, X_APP_ID: X_APP_ID, X_PLATFORM: X_PLATFORM, X_VERSION: X_VERSION, type: type, body: body).execute(apiResponseQueue) { result in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     report idfa or deviceToken
     - POST /report/{type}
     - API Key:
       - type: apiKey X-API-KEY
       - name: ApiKeyAuth
     - parameter X_USER_ID: (header) an unique string represents the current user
     - parameter userAgent: (header) user agent
     - parameter X_APP_ID: (header) an unique string represents the current user
     - parameter X_PLATFORM: (header) an unique string represents the current user
     - parameter X_VERSION: (header) sdk version 
     - parameter type: (path)
     - parameter body: (body) test text/plain
     - returns: RequestBuilder<SimpleStatusResult>
     */
    open class func reportTypeWithRequestBuilder(X_USER_ID: String, userAgent: String, X_APP_ID: String, X_PLATFORM: XPLATFORM_reportType, X_VERSION: String, type: ModelType_reportType, body: String) -> RequestBuilder<SimpleStatusResult> {
        var localVariablePath = "/report/{type}"
        let typePreEscape = "\(type.rawValue)"
        let typePostEscape = typePreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        localVariablePath = localVariablePath.replacingOccurrences(of: "{type}", with: typePostEscape, options: .literal, range: nil)
        let localVariableURLString = OpenAPIClientAPI.basePath + localVariablePath
        let localVariableParameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)

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
