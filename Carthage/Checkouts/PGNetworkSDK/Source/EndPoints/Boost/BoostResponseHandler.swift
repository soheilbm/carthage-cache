import Foundation

struct BoostCreateResponseHandler: PGResponse {
    var output: Any?
    
    init?(bulldog: Bulldog) {
        guard let stat = bulldog.string("stat") else { return }
        if stat == "error", let code = bulldog.int("code"), let message = bulldog.string("message") {
            output = PGNetworkError(code: code, message: message)
        } else {
          output = BoostResponse(bulldog: bulldog)
        }
    }
    
}

extension BoostResponse {
    
    init?(bulldog: Bulldog) {
        guard let _id = bulldog.int("id"),
            let _listingId = bulldog.int("listingId"),
            let _startDate = bulldog.string("startDateTimestamp"),
            let _endDate = bulldog.string("endDateTimestamp"),
            let _repostCharge = bulldog.int("repostCharge"),
            let _bookingCharge = bulldog.int("bookingCharge"),
            let _extendableWeeks = bulldog.int("extendableWeeks"),
            let _tierType = bulldog.int("tierType"),
            let _status = bulldog.string("status") else { return nil }
        id = _id
        listingId = _listingId
        startDate = Double(_startDate) ?? 0
        endDate = Double(_endDate) ?? 0
        repostCharge = _repostCharge
        bookingCharge = _bookingCharge
        extendableWeeks = _extendableWeeks
        tierType = _tierType
        status = _status
    }
    
}

struct BoostChargeResponseHandler: PGResponse {
    var output: Any?
    
    init?(bulldog: Bulldog) {
        guard let array = bulldog.array() else { return }
        output = array.flatMap { item -> BoostChargeResponse? in
            let bd = Bulldog(json: item)
            guard let type = bd.int("type"), let listingtype = bd.string("listingType"), let bookingCharge = bd.int("bookingCharge"), let repostCharge = bd.int("repostCharge"), let minQuality = bd.int("minListingQuality") else { return nil }
            return BoostChargeResponse(type: type, isRent: listingtype == "rent", bookingCharge: bookingCharge, repostCharge: repostCharge, minListingQuality: minQuality)
        }
    }
    
}

struct BoostActiveResponseHandler: PGResponse {
    var output: Any?
    
    init?(bulldog: Bulldog) {
        guard let status = bulldog.string("status"), status == "ok", let array = bulldog.array("records"), let first = array.first else { return nil }
        let bd = Bulldog(json: first)
        output = BoostResponse(bulldog: bd)
    }
    
}

struct CreditQueryResponseHandler: PGResponse {
    var output: Any?
    
    init?(bulldog: Bulldog) {
        guard let stat = bulldog.string("stat"), stat == "ok", let listLeft = bulldog.int("new_listing_remaining"), let slots = bulldog.int("available_active_slots"), let creds = bulldog.int("available_credits") else { return nil }
        output = CreditQueryResponse(newListingLeft: listLeft, availableActiveSlots: slots, availableCredits: creds)
    }
    
}
