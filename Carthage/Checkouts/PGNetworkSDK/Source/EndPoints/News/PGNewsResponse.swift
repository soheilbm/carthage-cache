//
//  PGNews.swift
//  Pods
//
//  Created by Suraj Pathak on 11/3/16.
//
//

import Foundation

public struct PGNewsList {
    public var totalPosts: Int?
    public var totalPages: Int?
    public var currentPage: Int?
    public var news: [PGNewsSummary]?
}

public struct PGNewsCategoryList {
    public var categories: [PGNewsCategory]?
}

public struct PGNewsCategory {
    public var slug: String?
    public var name: String?
}

public struct PGNewsSummary {
    public var id: Int
    public var headline: String?
    public var publication: String?
    public var status: String?
    public var publicationDate: String?
    public var thumbnail: String?
    public var imageUrl: String?
    public var name: String?
    public var excerpt: String?
    
    init(id: Int) {
        self.id = id
    }

}

public struct PGNewsFull {
    public var summary: PGNewsSummary?
    public var categories: [PGNewsCategory]?
    public var relatedNews: [PGNewsSummary]?
    public var webUrl: String?
    public var text: String?
}
