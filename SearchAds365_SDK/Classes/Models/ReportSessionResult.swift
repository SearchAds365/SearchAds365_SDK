//
// ReportSessionResult.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct ReportSessionResult: Codable, JSONEncodable, Hashable {

    public enum Status: String, Codable, CaseIterable {
        case ok = "ok"
        case fail = "fail"
    }
    public var status: Status
    public var errmsg: String?

    public init(status: Status, errmsg: String? = nil) {
        self.status = status
        self.errmsg = errmsg
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case status
        case errmsg
    }

    // Encodable protocol methods
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(status, forKey: .status)
        try container.encodeIfPresent(errmsg, forKey: .errmsg)
    }
}