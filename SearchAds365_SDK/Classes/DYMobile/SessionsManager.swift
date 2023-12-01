//
//  SessionsManager.swift
//  SearchAds365MobileSDK
//
//  Created by 靖核 on 2022/2/11.
//

import Foundation
#if canImport(UIKit)
import UIKit
#endif

class SessionsManager {
    ///跟踪计时器
    private var liveTrackerTimer: Timer?
    
    private lazy var eventManager: SAMEventManager = {
        return SAMEventManager.shared
    }()

    init() {
        #if canImport(UIKit)
        ///应用进入后台
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIApplicationDidEnterBackground, object: nil, queue: .main) { [weak self] (_) in
            self?.trackLiveEventInBackground()
        }
        #endif
    }

    deinit {
        invalidateTimers()
    }
    
    ///注销计时器
    func invalidateTimers() {
        invalidateLiveTrackerTimer()
    }
    
    ///开启跟踪计时器
    func startTrackingLiveEvent() {
        guard liveTrackerTimer == nil else {
            return
        }

        trackLiveEvent()
        ///每一分钟触发一次应用存活统计
        liveTrackerTimer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(fireTrackLiveEvent), userInfo: nil, repeats: true)
    }
    ///注销跟踪计时器
    func invalidateLiveTrackerTimer() {
        liveTrackerTimer?.invalidate()
        liveTrackerTimer = nil
    }
    ///触发应用存活统计
    @objc private func fireTrackLiveEvent() {
        trackLiveEvent()
    }
    ///应用存活统计
    private func trackLiveEvent(completion: ErrorCompletion? = nil) {
//        eventManager.trackEvent(.live, completion:completion )
//        kinesisManager.trackEvent(.live, completion: completion)
    }
    ///应用进入后台统计
    private func trackLiveEventInBackground() {
        #if canImport(UIKit)
        var eventBackgroundTaskID: UIBackgroundTaskIdentifier = UIBackgroundTaskInvalid
        eventBackgroundTaskID = UIApplication.shared.beginBackgroundTask (withName: "AdaptyTrackLiveBackgroundTask") {
            // End the task if time expires.
            UIApplication.shared.endBackgroundTask(eventBackgroundTaskID)
            eventBackgroundTaskID = UIBackgroundTaskInvalid
        }

        assert(eventBackgroundTaskID != UIBackgroundTaskInvalid)

        DispatchQueue.global().async {
            self.trackLiveEvent(){ _ in
                UIApplication.shared.endBackgroundTask(eventBackgroundTaskID)
                eventBackgroundTaskID = UIBackgroundTaskInvalid
            }
        }
        #endif
    }
}
