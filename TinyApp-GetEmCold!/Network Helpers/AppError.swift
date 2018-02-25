//
//  AppError.swift
//  TinyApp-GetEmCold!
//
//  Created by C4Q on 2/23/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation

enum AppError: Error {
    case invalidImage
    case goodStatusCode(num: Int)
    case unauthenticated
    case invalidJSONResponse
    case couldNotParseJSONObject(rawError: Error)
    case noInternetConnection
    case badURL(str: String)
    case noDataReceived
    case notAnImage
    case other(rawError: Error)
    case badData
    case codingError(rawError: Error)
    case badStatusCode(num: Int)
    case urlError(rawError: Error)
    case noData
}

