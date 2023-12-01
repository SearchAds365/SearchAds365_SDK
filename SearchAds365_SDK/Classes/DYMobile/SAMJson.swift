//
//  DYMJson.swift
//  SearchAds365MobileSDK
//
//  Created by YaoZiLiang on 2022/4/8.
//

import UIKit

protocol SAMJSONCodable {
    init?(json: SAMParams) throws
}

struct SAMJson: SAMJSONCodable {
    let json: SAMParams
    init?(json: SAMParams) throws {
        self.json = json
    }
}

struct SAMJsonAttributed: SAMJSONCodable {
    
    let json: SAMParams
    
    init?(json: SAMParams) throws {
        let attributes: SAMParams
        do {
            attributes = try json.attributes()
        } catch {
            throw error
        }
        self.json = attributes
    }
    
}

struct SAMResponseError: SAMJSONCodable {
    
    let detail: String
    let status: Int
    let source: SAMParams
    let code: String
    
    init?(json: SAMParams) throws {
        self.detail = json["detail"] as? String ?? ""
        if let statusString = json["status"] as? String, let status = Int(statusString) {
            self.status = status
        } else {
            self.status = 0
        }
        self.source = json["source"] as? SAMParams ?? SAMParams()
        self.code = json["code"] as? String ?? ""
        
        logMissingRequiredParams()
    }
    
    var description: String {
        return "Status: \(code). Details: \(detail)"
    }
    
    private func logMissingRequiredParams() {
        var missingParams: [String] = []
        if self.detail.isEmpty { missingParams.append("detail") }
        if self.status == 0 { missingParams.append("status") }
        if self.source.count == 0 { missingParams.append("source") }
        if self.code.isEmpty { missingParams.append("code") }
        if !missingParams.isEmpty {
            SAMLogManager.logError(SAMError.missingParam("ResponseErrorModel - \(missingParams.joined(separator: ", "))")) }
    }
    
}

struct SAMResponseErrors: SAMJSONCodable {
    
    var errors: [SAMResponseError] = []
    
    init?(json: SAMParams) throws {
        guard let errors = json["errors"] as? [SAMParams] else {
            return nil
        }
        
        do {
            try errors.forEach { (params) in
                if let error = try SAMResponseError(json: params) {
                    self.errors.append(error)
                }
            }
        } catch {
            throw SAMError.invalidProperty("ResponseErrors – errors", errors)
        }
    }
}
