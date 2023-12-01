//
//  SAMobileSDK.swift
//  SearchAds365MobileSDK
//
//  Created by 靖核 on 2022/2/10.
//

#if canImport(UIKit)
import UIKit
import FCUUID
import AnyCodable
import StoreKit
import AppTrackingTransparency
import AdSupport
#endif

@objc public class SAMobileSDK: NSObject {

    private static let shared = SAMobileSDK()
    
    ///判断是否需要IDFA
    @objc public static var idfaCollectionDisabled: Bool = false
   
    ///场景控制器
    private lazy var sessionsManager: SessionsManager = {
        return SessionsManager()
    }()
    
    ///行为控制器
    private lazy var eventManager: SAMEventManager = {
        return SAMEventManager.shared
    }()
    
    ///api控制器
    private lazy var apiManager:ApiManager = {
        return ApiManager()
    }()
    
    ///应用内支付
    private lazy var iapManager:SAMIAPManager = {
        return SAMIAPManager.shared
    }()
    
    ///推送地址
    @objc public static var apnsToken: Data? {
        didSet {
            shared.apnsTokenStr = apnsToken?.map { String(format: "%02.2hhx", $0) }.joined()
        }
    }

    @objc public static var apnsTokenString: String? {
        guard let token = SAMDefaultsManager.shared.apnsTokenString else {
            return nil
        }
        return token
    }

    private var apnsTokenStr: String? {
        set {
            SAMLogManager.logMessage("Setting APNS token.")
            SAMDefaultsManager.shared.apnsTokenString = newValue
        }
        get {
            return SAMDefaultsManager.shared.apnsTokenString
        }
    }
    // MARK: - Activate SDK
    @objc public class func activate() {
        SAMLogManager.logMessage("Calling now: \(#function)")
        
        let path = Bundle.main.path(forResource: SAMConstants.AppInfoName.plistName, ofType: SAMConstants.AppInfoName.plistType)
        guard let plistPath = path else {
            return
        }
        guard let appInfoDictionary = NSMutableDictionary(contentsOfFile: plistPath) else {
            return
        }
        guard let appId = appInfoDictionary.value(forKey: SAMConstants.AppInfoName.appId) as? String, let apiKey = appInfoDictionary.value(forKey: SAMConstants.AppInfoName.apiKey) as? String else{
            return
        }
        SAMConstants.APIKeys.appId = appId
        SAMConstants.APIKeys.secretKey = apiKey
        
        shared.configure()
    }
    
    ///Configure
    private func configure() {
        performInitialRequests()
        SAMAppDelegateSwizzler.startSwizzlingIfPossible(self)
    }
    
    ///Initial requests
    private func performInitialRequests() {
        apiManager.startSession()

        iapManager.startObserverPurchase()
        
        sendAppleSearchAdsAttribution()
    }

    // MARK: - idfa
    @objc public class func reportIdfa(idfa:String) {
        SAMLogManager.logMessage("Calling now: \(#function)")
        shared.apiManager.reportIdfa(idfa: idfa) { result, error in
        }
    }

    // MARK: - device token
    @objc public class func reportDeviceToken(token:String) {
        SAMLogManager.logMessage("Calling now: \(#function)")
        shared.apiManager.reportDeviceToken(token: token) { result, error in
        }
    }

    // MARK: - Attribution
    @objc public class func reportAttribution(adjustId:String? = nil,appsFlyerId:String? = nil,amplitudeId:String? = nil) {
        SAMLogManager.logMessage("Calling now: \(#function)")
        let attributes = Attribution(adjustId: adjustId, appsFlyerId: appsFlyerId, amplitudeId: amplitudeId)
        shared.apiManager.reportAttribution(attribution: attributes) { result, error in
        }
    }
#if os(iOS)
    private func reportAppleSearchAdsAttribution() {
        UserProperties.appleSearchAdsAttribution { (attribution, error) in
            Self.reportSearchAds(attribution: attribution)
        }
    }
#endif

    private class func reportSearchAds(attribution: SAMParams) {
        let data = AnyCodable(attribution)
        shared.apiManager.updateSearchAdsAttribution(attribution: data) { result, error in
        }
    }
    
    // MARK: - Events
    @objc public class func track(event: String, extra: String? = nil, user: String? = nil) {
        SAMLogManager.logMessage("Calling now: \(#function)")
        if event != "" {
            if SAMConstants.APIKeys.appId == "" || SAMConstants.APIKeys.secretKey == "" {
                //读取SearchAds365.plist信息
                let path = Bundle.main.path(forResource: SAMConstants.AppInfoName.plistName, ofType: SAMConstants.AppInfoName.plistType)
                guard let plistPath = path else {
                    return
                }
                guard let appInfoDictionary = NSMutableDictionary(contentsOfFile: plistPath) else {
                    return
                }
                guard let appId = appInfoDictionary.value(forKey: SAMConstants.AppInfoName.appId) as? String, let apiKey = appInfoDictionary.value(forKey: SAMConstants.AppInfoName.apiKey) as? String else{
                    return
                }
                SAMConstants.APIKeys.appId = appId
                SAMConstants.APIKeys.secretKey = apiKey
            }
            shared.eventManager.track(event: event, extra: extra, user: user)
        }
    }

    //MARK: - request device unique uuid
    @objc public class func requestDeviceUUID() -> String {
        SAMLogManager.logMessage("Calling now: \(#function)")
        return UserProperties.requestUUID
    }
    
    //MARK: - private method
    private func sendAppleSearchAdsAttribution() {
        //IDFA
        if #available(iOS 14, *) {
            let state = ATTrackingManager.trackingAuthorizationStatus
            if state == .notDetermined {
                self.reportAppleSearchAdsAttribution()
                var isSendRequest = false
                NotificationCenter.default.addObserver(forName: Notification.Name.UIApplicationDidBecomeActive, object: nil, queue: .main) { notification in
                    if isSendRequest == false {
                        ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                            isSendRequest = true
                            self.reportAppleSearchAdsAttribution()
                            
                            if status == .authorized {
                                Self.reportIdfa(idfa: ASIdentifierManager.shared().advertisingIdentifier.uuidString)
                            }
                            
                        })
                    }
                }
            } else {
                reportAppleSearchAdsAttribution()
                
                if state == .authorized {
                    Self.reportIdfa(idfa: ASIdentifierManager.shared().advertisingIdentifier.uuidString)
                }
            }
        } else {
            reportAppleSearchAdsAttribution()
            
            if ASIdentifierManager.shared().isAdvertisingTrackingEnabled {
                Self.reportIdfa(idfa: ASIdentifierManager.shared().advertisingIdentifier.uuidString)
            }
        }
    }
}

extension SAMobileSDK: SAMAppDelegateSwizzlerDelegate {

    func didReceiveAPNSToken(_ deviceToken: Data) {
        Self.apnsToken = deviceToken
        if let token = self.apnsTokenStr {
            Self.reportDeviceToken(token: token)
        }
    }
}
