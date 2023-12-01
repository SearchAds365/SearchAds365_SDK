//
//  ApiManager.swift
//  SearchAds365MobileSDK
//
//  Created by 靖核 on 2022/2/25.
//

import Foundation
import AnyCodable
import StoreKit

public typealias ErrorCompletion = (ErrorResponse?) -> Void
public typealias RequestProductsCompletion = (SKProduct?) -> Void

class ApiManager {

    @objc func startSession(){
        SessionsAPI.reportSession(X_USER_ID: UserProperties.requestUUID, userAgent: UserProperties.userAgent, X_APP_ID: SAMConstants.APIKeys.appId, X_PLATFORM: SessionsAPI.XPLATFORM_reportSession.ios, X_VERSION: UserProperties.sdkVersion, uniqueUserObject: UniqueUserObject(), apiResponseQueue: OpenAPIClientAPI.apiResponseQueue) { data, error in
            if (error != nil) {
                SAMLogManager.logError(error!)

                let time: TimeInterval = 1.0
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
                    self.startSession()
                }
            } else {
                SAMLogManager.logMessage("Active Completely!")
            }
        }
    }

    func reportIdfa(idfa:String,completion:@escaping ((SimpleStatusResult?,Error?)->())) {
        SessionsAPI.reportType(X_USER_ID: UserProperties.requestUUID, userAgent: UserProperties.userAgent, X_APP_ID: SAMConstants.APIKeys.appId, X_PLATFORM: SessionsAPI.XPLATFORM_reportType.ios, X_VERSION: UserProperties.sdkVersion, type: SessionsAPI.ModelType_reportType.idfa, body: idfa) { data, error in
            completion(data,error)
        }
    }

    func reportDeviceToken(token:String,completion:@escaping ((SimpleStatusResult?,Error?)->())) {
        SessionsAPI.reportType(X_USER_ID: UserProperties.requestUUID, userAgent: UserProperties.userAgent, X_APP_ID: SAMConstants.APIKeys.appId, X_PLATFORM: SessionsAPI.XPLATFORM_reportType.ios, X_VERSION: UserProperties.sdkVersion, type: SessionsAPI.ModelType_reportType.deviceToken, body: token) { data, error in
            completion(data,error)
        }
    }
    
    func updateSearchAdsAttribution(attribution: AnyCodable? = nil, completion:@escaping (SimpleStatusResult?,Error?) -> Void) {
        guard let attribution = attribution?.value as? SAMParams else{
            SAMLogManager.logMessage("attrition is nil")
            completion(nil,nil)
            return
        }
        let searchAtt = AppleSearchAdsAttribution(attribution: attribution)
        let appleReportObjAtt = AppleSearchAdsAttributionReportObjectAttribution(version31:searchAtt)
        let appleReportObj = AppleSearchAdsAttributionReportObject(attribution: appleReportObjAtt)
        AttributionAPI.reportSearchAdsAttr(X_USER_ID: UserProperties.requestUUID, userAgent: UserProperties.userAgent, X_APP_ID: SAMConstants.APIKeys.appId, X_PLATFORM: AttributionAPI.XPLATFORM_reportSearchAdsAttr.ios, X_VERSION: UserProperties.sdkVersion, appleSearchAdsAttributionReportObject: appleReportObj, apiResponseQueue: OpenAPIClientAPI.apiResponseQueue) { data, error in
            completion(data,error)
        }
    }

    func reportAttribution(attribution:Attribution,complete:@escaping ((SimpleStatusResult?,Error?)->())) {
        if attribution.adjustId == nil && attribution.appsFlyerId == nil && attribution.amplitudeId == nil {
            SAMLogManager.logMessage("attrition is nil")
            complete(nil,nil)
            return
        }
        AttributionAPI.attributionData(X_USER_ID: UserProperties.requestUUID, userAgent: UserProperties.userAgent, X_APP_ID: SAMConstants.APIKeys.appId, X_PLATFORM: AttributionAPI.XPLATFORM_attributionData.ios, X_VERSION: UserProperties.sdkVersion, attribution: attribution, apiResponseQueue: OpenAPIClientAPI.apiResponseQueue) { data, error in
            complete(data,error)
        }
    }
}
