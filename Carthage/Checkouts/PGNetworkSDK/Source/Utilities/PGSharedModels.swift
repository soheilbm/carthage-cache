//
//  PGSharedModels.swift
//  PGNetworkSDK
//
//  Created by Soheil on 1/6/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import Foundation

public struct PGListingImages {
    public let type: PGImageTypes
    public let imagePath: String
    public let caption: String?
    public init(type: PGImageTypes, imagePath: String, caption: String? = nil) {
        self.type = type
        self.imagePath = imagePath
        self.caption = caption
    }
    
    public static func getArrayOfImages(_ json: [String: Any]?) -> [PGListingImages]? {
        guard let json = json else {return nil}
        var images = [PGListingImages]()
        
        for i in json {
            for type in PGImageTypes.allTypes {
                guard type.rawValue == i.0 else { continue }
                let j = String(describing: i.1)
                let aImage =  PGListingImages(type: type, imagePath: j)
                images.append(aImage)
            }
        }
        
        if images.count > 0 { return images }
        return nil
    }
    
    public static func getArrayOfImages(_ json: [Any]?) -> [PGListingImages]? {
        guard let json = json else {return nil}
        var images = [PGListingImages]()
        
        for i in json {
            for type in PGImageTypes.allTypes {
                let bulldog = Bulldog(json: i)
                guard let image = bulldog.string(type.rawValue) else { continue }
                let aImage =  PGListingImages(type: type, imagePath: image)
                images.append(aImage)
            }
        }
        
        if images.count > 0 { return images }
        return nil
    }
    
    public static func getImagesUrl(_ images: [PGListingImages]?, type: PGImageTypes = .V550) -> [URL]? {
        guard let images = images , images.count > 0 else { return nil }
        
        var urls = [URL]()
        
        for image in images {
            if type == image.type {
                if let url = URL(string: image.imagePath) {
                    urls.append(url)
                }
            }
        }
        guard urls.count > 0 else { return nil }
        return urls
    }
    
}

public enum PGImageTypes: String {
    case V800 = "V800"
    case V550 = "V550"
    case V150 = "V150"
    case V120 = "V120"
    case V75B = "V75B"
    case V350 = "V350"
    case V160B = "V160B"
    
    static let allTypes = [V800, V550, V150, V120, V75B, V350, V160B]
}
