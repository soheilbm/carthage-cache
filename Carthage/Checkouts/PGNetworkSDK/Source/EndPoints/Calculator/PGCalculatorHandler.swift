//
//  PGCalculatorHandler.swift
//  PGNetworkSDK
//
//  Created by Suraj Pathak on 20/9/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import Foundation

struct PGCalculatorHandler: PGResponse {
    
    var output: Any?
    
    init?(bulldog: Bulldog) {
        output = PGCalculator(bulldog: bulldog)
    }
    
}

extension PGCalculator {
    
    init?(bulldog: Bulldog) {
        campaignId                       = bulldog.int("campaignId")
        language                         = bulldog.string("language")
        country                          = bulldog.string("country")
        region                           = bulldog.string("region")
        regionCode                       = bulldog.string("region_code")
        propertyType                     = bulldog.string("propertyType")
        location                         = bulldog.string("location")
        source                           = bulldog.string("source")
        status                           = bulldog.string("status")
        chartTitle                       = bulldog.string("chart", "title")
        chartDisclaimer                  = bulldog.string("chart", "disclaimer")
        widgetTitle                      = bulldog.string("widget", "title")
        widgetSubTitle                   = bulldog.string("widget", "subtitle")
        widgetLinkLabel                  = bulldog.string("widget", "link", "label")
        widgetLinkUrl                    = bulldog.string("widget", "link", "url")
        widgetLinkAdditionalAttributes   = bulldog.string("widget", "link", "additionalAttributes")
        widgetLinkAdditionalParameters   = bulldog.string("widget", "link", "additionalParameters")
        widgetButtonLabel                = bulldog.string("widget", "button", "label")
        widgetButtonUrl                  = bulldog.string("widget", "button", "url")
        widgetButtonPromoText            = bulldog.string("widget", "button", "promoText")
        widgetButtonStyle                = bulldog.string("widget", "button", "style")
        widgetButtonAdditionalAttributes = bulldog.string("widget", "button", "additionalAttributes")
        widgetButtonAdditionalParameters = bulldog.string("widget", "button", "additionalParameters")
        widgetLogoAltText                = bulldog.string("widget", "logo", "altText")
        widgetLogoUrl                    = bulldog.string("widget", "logo", "url")
        widgetAnalyticsEventLink         = bulldog.string("widget", "analyticsEvents", "link")
        widgetAnalyticsEventButton       = bulldog.string("widget", "analyticsEvents", "button")
        priceSymbol                      = bulldog.string("calculator", "price", "currencySymbol")
        priceLabel                       = bulldog.string("calculator", "price", "label")
        priceValue                       = bulldog.double("calculator", "price", "value")
        pricePretty                      = bulldog.string("calculator", "price", "pretty")
        priceSuffix                      = bulldog.string("calculator", "price", "suffix")
        depositLabel                     = bulldog.string("calculator", "deposit", "label")
        depositValue                     = bulldog.double("calculator", "deposit", "value")
        depositPretty                    = bulldog.string("calculator", "deposit", "pretty")
        depositSuffix                    = bulldog.string("calculator", "deposit", "suffix")
        depositPercentage                = bulldog.int("calculator", "deposit", "percentage")
        loanLabel                        = bulldog.string("calculator", "loan", "label")
        loanValue                        = bulldog.double("calculator", "loan", "value")
        loanPretty                       = bulldog.string("calculator", "loan", "pretty")
        loanSuffix                       = bulldog.string("calculator", "loan", "suffix")
        tenureLabel                      = bulldog.string("calculator", "tenure", "label")
        tenureValue                      = bulldog.double("calculator", "tenure", "value")
        tenureSuffix                     = bulldog.string("calculator", "tenure", "suffix")
        interestRateLabel                = bulldog.string("calculator", "interestRate", "label")
        interestRateValue                = bulldog.double("calculator", "interestRate", "value")
        interestRateSuffix               = bulldog.string("calculator", "interestRate", "suffix")
        monthlyRepaymentLabel            = bulldog.string("calculator", "monthlyRepayment", "label")
        monthlyRepaymentValue            = bulldog.double("calculator", "monthlyRepayment", "value")
        monthlyRepaymentPretty           = bulldog.string("calculator", "monthlyRepayment", "pretty")
        monthlyRepaymentSuffix           = bulldog.string("calculator", "monthlyRepayment", "suffix")
        principleLabel                   = bulldog.string("calculator", "principle", "label")
        principleValue                   = bulldog.double("calculator", "principle", "value")
        principleSuffix                  = bulldog.string("calculator", "principle", "suffix")
        interestLabel                    = bulldog.string("calculator", "interest", "label")
        interestValue                    = bulldog.double("calculator", "interest", "value")
        interestSuffix                   = bulldog.string("calculator", "interest", "suffix")
    }

}
