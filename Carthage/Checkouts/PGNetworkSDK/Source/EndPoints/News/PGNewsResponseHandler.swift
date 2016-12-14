//
//  PGNewsResponseHandler.swift
//  PGNetworkSDK
//
//  Created by Suraj Pathak on 19/9/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import Foundation

struct PGNewsListHandler: PGResponse {
    
    var output: Any?
    
    init?(bulldog: Bulldog) {
        var newsList = PGNewsList()
        newsList.totalPosts = bulldog.int("totalPosts")
        newsList.totalPages = bulldog.int("totalPages")
        newsList.currentPage = bulldog.int("currentPage")
        if let newsArray = bulldog.array("news") {
            newsList.news = newsArray.flatMap { return  PGNewsSummaryHandler(bulldog: Bulldog(json: $0))?.output as? PGNewsSummary}
        }
        output = newsList
    }
}

public struct PGNewsCategoryListHandler: PGResponse {
    
    var output: Any?

    init?(bulldog: Bulldog) {
        if let array = bulldog.array() {
            let categories = array.flatMap { PGNewsCategoryHandler(bulldog: Bulldog(json: $0))?.output as? PGNewsCategory }
            output = PGNewsCategoryList(categories: categories)
        }
    }

}

struct PGNewsCategoryHandler: PGResponse {
    var output: Any?
    
    init?(bulldog: Bulldog) {
        output = PGNewsCategory(slug: bulldog.string("slug"), name: bulldog.string("name"))
    }
}

struct PGNewsSummaryHandler: PGResponse {
    
    var output: Any?
    
    init?(bulldog: Bulldog) {
        guard let id = bulldog.int("id") else { return nil }
        var summary = PGNewsSummary(id: id)
        summary.headline = bulldog.string("headline")
        summary.publication = bulldog.string("publication")
        summary.status = bulldog.string("status")
        summary.thumbnail = bulldog.string("thumbnail")
        summary.imageUrl = bulldog.string("imageUrl")
        summary.name = bulldog.string("name")
        summary.excerpt = bulldog.string("excerpt")
        if let date = bulldog.string("publicationDate") {
        	summary.publicationDate = formatDate(date)
        }
        output = summary
    }
    
    func formatDate(_ inputDate: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: inputDate)
        guard let validDate = date else { return nil }
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        return dateFormatter.string(from: validDate)
    }
    
}

public struct PGNewsFullHandler: PGResponse {
    
    var output: Any?
    
    public init?(bulldog: Bulldog) {
        var newsFull = PGNewsFull()
        newsFull.summary = PGNewsSummaryHandler(bulldog: bulldog)?.output as? PGNewsSummary
        newsFull.categories = bulldog.array("category")?.flatMap { PGNewsCategoryHandler(bulldog: Bulldog(json: $0))?.output as? PGNewsCategory }
        newsFull.relatedNews = bulldog.array("related_news")?.flatMap { PGNewsSummaryHandler(bulldog: Bulldog(json: $0))?.output as? PGNewsSummary }
        newsFull.webUrl = bulldog.string("webUrl")
        newsFull.text = bulldog.string("text")
        output = newsFull
    }
}
