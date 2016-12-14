//
//  PGResponse.swift
//  Pods
//
//  Created by Suraj Pathak on 22/3/16.
//
//

import Foundation

protocol PGResponse {
    init?(bulldog: Bulldog)
    var output: Any? { get }
}
