//
//  PGReferenceDataResponsesHandler.swift
//  PGNetworkSDK
//
//  Created by Suraj Pathak on 20/9/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import Foundation

struct ReferenceBaseResponseHandler: PGResponse {
    var output: Any?
    
    init?(bulldog: Bulldog) {
        output = ReferenceBaseResponse(bulldog: bulldog)
    }

}

extension ReferenceBaseResponse {
    
    init?(bulldog: Bulldog) {
        stat = bulldog.string("stat")
        guard let dataDict = bulldog.dictionary("data") else { return nil }
        for (key, _) in dataDict {
            if let itemArray = bulldog.array("data", key) {
                data[key] = itemArray.flatMap { return ReferenceBaseItem(bulldog: Bulldog(json: $0)) }
            }
        }
    }
    
}

struct ReferencePropertyTypeCodeResponseHandler: PGResponse {
    var output: Any?
    
    init?(bulldog: Bulldog) {
        output = ReferencePropertyTypeCodeResponse(bulldog: bulldog)
    }
    
}

extension ReferencePropertyTypeCodeResponse {
    
    init?(bulldog: Bulldog) {
        stat = bulldog.string("stat")
        if let propertyTypes = bulldog.array("property_type") {
            self.propertyTypes = propertyTypes.flatMap { PropertyTypeCode.init(bulldog: Bulldog(json: $0)) }
        } else {
            self.propertyTypes = nil
        }
    }

}

struct ReferenceInterestsResponseHandler: PGResponse {
    var output: Any?
    
    init?(bulldog: Bulldog) {
        output = ReferenceInterestsResponse(bulldog: bulldog)
    }

}

extension ReferenceInterestsResponse {
    
    init?(bulldog: Bulldog ) {
        stat = bulldog.string("stat")
        if let dict = bulldog.dictionary("mrt_stns") {
            self.mrtStations = [Interests]()
            for i in dict.keys {
                if let row = dict[i] {
                    if let model = Interests(bulldog: Bulldog(json: row)) {
                        self.mrtStations?.append(model)
                    }
                }
            }
        } else {
            self.mrtStations = nil
        }
        
        if let dict = bulldog.dictionary("schools") {
            self.schools = [Interests]()
            
            for i in dict.keys {
                if let row = dict[i] {
                    if let model = Interests(bulldog: Bulldog(json: row)) {
                        self.schools?.append(model)
                    }
                }
            }
        } else {
            self.schools = nil
        }
    }
}
struct ReferenceDistrictResponseHandler: PGResponse {
    var output: Any?
    
    init?(bulldog: Bulldog) {
        output = ReferenceDistrictResponse(bulldog: bulldog)
    }
    
}

extension ReferenceDistrictResponse {
    
    init?(bulldog: Bulldog ) {
        stat = bulldog.string("stat")
        if let dict = bulldog.dictionary("districts") {
            self.districts = [District]()
            
            for i in dict.keys {
                let row = String(describing: dict[i]!)
                let model = District(code: i, info: row)
                self.districts?.append(model)
            }
        } else {
            self.districts = nil
        }
    }
}


struct ReferenceGeographicAreaResponseHandler: PGResponse {
    var output: Any?
    
    init?(bulldog: Bulldog) {
        output = ReferenceGeographicAreaResponse(bulldog: bulldog)
    }

}

extension ReferenceGeographicAreaResponse {
    
    init?(bulldog: Bulldog) {
        stat = bulldog.string("stat")
        if let areas = bulldog.array("geographic_area") {
            self.areas = areas.flatMap { return GeographicArea(bulldog: Bulldog(json: $0)) }
        } else {
            self.areas = nil
        }
    }

}

struct ReferenceGeographicDistrictResponseHandler: PGResponse {
    var output: Any?
    
    init?(bulldog: Bulldog) {
        output = ReferenceGeographicDistrictResponse(bulldog: bulldog)
    }

}

extension ReferenceGeographicDistrictResponse {
    
    init?(bulldog: Bulldog) {
        stat = bulldog.string("stat")
        if let areas = bulldog.array("geographic_area") {
            self.districts = areas.flatMap { return GeographicDistrict(bulldog: Bulldog(json: $0)) }
        } else {
            self.districts = nil
        }
    }

}

struct ReferenceRegionCodeResponseHandler: PGResponse {
    var output: Any?
    init?(bulldog: Bulldog) {
        output = ReferenceRegionCodeResponse(bulldog: bulldog)
    }
}

extension ReferenceRegionCodeResponse {
    
    init?(bulldog: Bulldog) {
        stat = bulldog.string("stat")
        if let dict = bulldog.dictionary("region_code") {
            self.regions = [Region]()
            for i in dict.keys {
                let row = String(describing: dict[i]!)
                let model = Region(code: i, info: row)
                self.regions?.append(model)
            }
        } else {
            self.regions = nil
        }
    }

}

/// Models for Reference Datas

struct ReferenceBaseItemHandler: PGResponse {
    var output: Any?
    
    init?(bulldog: Bulldog) {
        output = ReferenceBaseItem(bulldog: bulldog)
    }

}

extension ReferenceBaseItem {
    
    init?(bulldog: Bulldog) {
        code = bulldog.string("code")
        descriptionCode = bulldog.string("description")
        sortOrder = bulldog.int("sort_order")
    }

}


struct PropertyTypeCodeHandler: PGResponse {
    var output: Any?
    
    init?(bulldog: Bulldog) {
        output = PropertyTypeCode(bulldog: bulldog)
    }
    
}

extension PropertyTypeCode {
    
    init?(bulldog: Bulldog) {
        guard let code = bulldog.string("code"),
        	let descriptionCode = bulldog.string("description"),
        	let groupCode = bulldog.string("group_code"),
            let sortOrder = bulldog.int("sort_order") else { return nil }
        self.code = code
        self.descriptionCode = descriptionCode
        self.groupCode = groupCode
        self.sortOrder = sortOrder
    }

}

struct InterestsHandler: PGResponse {
    var output: Any?
    
    init?(bulldog: Bulldog) {
        output = Interests(bulldog: bulldog)
    }

}

extension Interests {
    
    init?(bulldog: Bulldog) {
        name = bulldog.string("name")
        lat = bulldog.double("latitude")
        lng = bulldog.double("longitude")
    }

}

extension District {
    
    init(code: String, info: String){
        self.code = code
        self.districtInfo = info
    }
    
}


struct GeographicAreaHandler: PGResponse  {
    var output: Any?
    
    init?(bulldog: Bulldog) {
        output = GeographicArea(bulldog: bulldog)
    }

}

extension GeographicArea {
    
    init?(bulldog: Bulldog) {
        guard let code = bulldog.string("code"),
        	let areaInfo = bulldog.string("description"),
            let parent = bulldog.string("parent") else { return nil }
        self.code = code
        self.areaInfo = areaInfo
        self.parent = parent
    }

}

struct GeographicDistrictHandler: PGResponse {
    var output: Any?
    init?(bulldog: Bulldog) {
        output = GeographicDistrict(bulldog: bulldog)
    }
}

extension GeographicDistrict   {
    
    init?(bulldog: Bulldog) {
        guard let code = bulldog.string("code"),
            let areaInfo = bulldog.string("description"),
            let parent = bulldog.string("parent") else { return nil }
        self.code = code
        self.districtInfo = areaInfo
        self.parent = parent
    }

}

extension Region {
    
    init(code: String, info: String){
        self.code = code
        self.regionInfo = info
    }

}
