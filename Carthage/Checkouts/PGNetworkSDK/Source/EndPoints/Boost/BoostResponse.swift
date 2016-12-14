import Foundation

public struct BoostResponse {
    public let id: Int
    public let listingId: Int
    public let startDate: Double
    public let endDate: Double
    public let tierType: Int
    public let status: String
    public let extendableWeeks: Int
    public let repostCharge: Int
    public let bookingCharge: Int
}

public struct BoostChargeResponse {
    public let type: Int
    public let isRent: Bool
    public let bookingCharge: Int
    public let repostCharge: Int
    public let minListingQuality: Int
}

public struct CreditQueryResponse {
    public let newListingLeft: Int
    public let availableActiveSlots: Int
    public let availableCredits: Int
}
