//
//  Constants.swift
//  SearchAds365MobileSDK
//
//  Created by 靖核 on 2022/2/10.
//

import UIKit
class SAMConstants: NSObject {

    ///API Key
    enum APIKeys {
        static var secretKey = ""
        static var appId = ""
    }
    
    ///请求头
    enum Headers {
        static let apiKey = "X-API-KEY"
        static let appId  = "X-APP-ID"
        static let userId = "X-USER-ID"
        static let agent  = "User-Agent"
    }

    enum Versions {
        static let SDKVersion = "0.0.1"
        static let SDKBuild = 1
    }
    
    enum BundleKeys {
        static let appDelegateProxyEnabled = "SAAppDelegateProxyEnabled"
        static let appleSearchAdsAttributionCollectionEnabled = "SAAppleSearchAdsAttributionCollectionEnabled"
    }
    
    enum UserDefaults {
        static let profileId                 = "SAMSDK_Profile_Id"
        static let apnsTokenString           = "SAMSDK_APNS_Token_String"
        static let cachedVariationsIds       = "SAMSDK_Cached_Variations_Ids"
        static let appleSearchAdsSyncDate    = "SAMSDK_Apple_Search_Ads_Sync_Date"
        static let externalAnalyticsDisabled = "SAMSDK_External_Analytics_Disabled"
        static let previousResponseHashes    = "SAMSDK_Previous_Response_Hashes"
        static let responseJSONCaches        = "SAMSDK_Response_JSON_Caches"
        static let postRequestParamsHashes   = "SAMSDK_Post_Request_Params_Hashes"
    }
    
    ///App信息
    enum AppInfoName {
        static let plistName = "SearchAds365"
        static let plistType = "plist"
        static let appId  = "SEARCHADS365_APP_ID"
        static let apiKey = "SEARCHADS365_API_KEY"
    }
}

public enum SAMAttributionSource: UInt {
    case appsFlyer
    case adjust
    case amplitude

    var rawString: String {
        switch self {
            case .appsFlyer: return "APPSFLYER"
            case .adjust: return "ADJUST"
            case .amplitude: return "AMPLITUDE"
        }
    }
}
