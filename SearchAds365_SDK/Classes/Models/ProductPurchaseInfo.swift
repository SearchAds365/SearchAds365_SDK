//
//  ProductPurchaseInfo.swift
//  SearchAds365_SDK
//
//  Created by apple on 2023/11/21.
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct ProductPurchaseInfo: Codable, JSONEncodable, Hashable {

    public var transactionId: String
    public var transactionDate: Int64?
    public var originalTransactionId: String?
    public var originalTransactionDate: Int64?
    public var quantity: Int
    public var productId: String
    public var price: String?
    public var currencyCode: String?
    public var regionCode: String?
    public var subscriptionGroupId: String?
    public var subscriptionPeriodNumberOfUnits: String?
    public var subscriptionPeriodUnit: String?
    
    init(transactionId: String, transactionDate: Int64? = nil, originalTransactionId: String? = nil, originalTransactionDate: Int64? = nil, quantity: Int, productId: String, price: String? = nil, currencyCode: String? = nil, regionCode: String? = nil, subscriptionGroupId: String? = nil, subscriptionPeriodNumberOfUnits: String? = nil, subscriptionPeriodUnit: String? = nil) {
        self.transactionId = transactionId
        self.transactionDate = transactionDate
        self.originalTransactionId = originalTransactionId
        self.originalTransactionDate = originalTransactionDate
        self.quantity = quantity
        self.productId = productId
        self.price = price
        self.currencyCode = currencyCode
        self.regionCode = regionCode
        self.subscriptionGroupId = subscriptionGroupId
        self.subscriptionPeriodNumberOfUnits = subscriptionPeriodNumberOfUnits
        self.subscriptionPeriodUnit = subscriptionPeriodUnit
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case transactionId
        case transactionDate
        case originalTransactionId
        case originalTransactionDate
        case quantity
        case productId
        case price
        case currencyCode
        case regionCode
        case subscriptionGroupId
        case subscriptionPeriodNumberOfUnits
        case subscriptionPeriodUnit
    }

    // Encodable protocol methods
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(transactionId, forKey: .transactionId)
        try container.encodeIfPresent(transactionDate, forKey: .transactionDate)
        try container.encodeIfPresent(originalTransactionId, forKey: .originalTransactionId)
        try container.encodeIfPresent(originalTransactionDate, forKey: .originalTransactionDate)
        try container.encodeIfPresent(quantity, forKey: .quantity)
        try container.encodeIfPresent(productId, forKey: .productId)
        try container.encodeIfPresent(price, forKey: .price)
        try container.encodeIfPresent(currencyCode, forKey: .currencyCode)
        try container.encodeIfPresent(regionCode, forKey: .regionCode)
        try container.encodeIfPresent(subscriptionGroupId, forKey: .subscriptionGroupId)
        try container.encodeIfPresent(subscriptionPeriodNumberOfUnits, forKey: .subscriptionPeriodNumberOfUnits)
        try container.encodeIfPresent(subscriptionPeriodUnit, forKey: .subscriptionPeriodUnit)
    }
}
