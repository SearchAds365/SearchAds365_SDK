//
//  DefaultsManager.swift
//  SearchAds365MobileSDK
//
//  Created by 靖核 on 2022/2/24.
//

import Foundation

public enum DataState: Int, Codable {
    case cached
    case synced
}

class SAMDefaultsManager {

    static let shared = SAMDefaultsManager()
    private var defaults = UserDefaults.standard

    private init() {}
    init(with defaults: UserDefaults) {
        self.defaults = defaults
    }

    var apnsTokenString: String? {
        get {
            return defaults.string(forKey: SAMConstants.UserDefaults.apnsTokenString)
        }
        set {
            defaults.set(newValue, forKey: SAMConstants.UserDefaults.apnsTokenString)
        }
    }

    var cachedVariationsIds: [String: String] {
        get {
            return defaults.dictionary(forKey: SAMConstants.UserDefaults.cachedVariationsIds) as? [String: String] ?? [:]
        }
        set {
            defaults.set(newValue, forKey: SAMConstants.UserDefaults.cachedVariationsIds)
        }
    }

    var appleSearchAdsSyncDate: Date? {
        get {
            return defaults.object(forKey: SAMConstants.UserDefaults.appleSearchAdsSyncDate) as? Date
        }
        set {
            defaults.set(newValue, forKey: SAMConstants.UserDefaults.appleSearchAdsSyncDate)
        }
    }

    var externalAnalyticsDisabled: Bool {
        get {
            return defaults.bool(forKey: SAMConstants.UserDefaults.externalAnalyticsDisabled)
        }
        set {
            defaults.set(newValue, forKey: SAMConstants.UserDefaults.externalAnalyticsDisabled)
        }
    }

    var previousResponseHashes: [String: String] {
        get {
            return (defaults.dictionary(forKey: SAMConstants.UserDefaults.previousResponseHashes) as? [String: String]) ?? [:]
        }
        set {
            defaults.set(newValue, forKey: SAMConstants.UserDefaults.previousResponseHashes)
        }
    }

    var responseJSONCaches: [String: [String: Data]] {
        get {
            return (defaults.dictionary(forKey: SAMConstants.UserDefaults.responseJSONCaches) as? [String: [String: Data]]) ?? [:]
        }
        set {
            defaults.set(newValue, forKey: SAMConstants.UserDefaults.responseJSONCaches)
        }
    }

    var postRequestParamsHashes: [String: String] {
        get {
            return (defaults.dictionary(forKey: SAMConstants.UserDefaults.postRequestParamsHashes) as? [String: String]) ?? [:]
        }
        set {
            defaults.set(newValue, forKey: SAMConstants.UserDefaults.postRequestParamsHashes)
        }
    }

    func clean() {
        defaults.removeObject(forKey: SAMConstants.UserDefaults.cachedVariationsIds)
        defaults.removeObject(forKey: SAMConstants.UserDefaults.appleSearchAdsSyncDate)
        defaults.removeObject(forKey: SAMConstants.UserDefaults.externalAnalyticsDisabled)
        defaults.removeObject(forKey: SAMConstants.UserDefaults.previousResponseHashes)
        defaults.removeObject(forKey: SAMConstants.UserDefaults.responseJSONCaches)
        defaults.removeObject(forKey: SAMConstants.UserDefaults.postRequestParamsHashes)
    }
}
