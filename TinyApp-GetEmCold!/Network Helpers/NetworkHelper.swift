//
//  NetworkHelper.swift
//  TinyApp-GetEmCold!
//
//  Created by C4Q on 2/23/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation

//class NetworkHelper {
//    private init() {
//        urlSession.configuration.requestCachePolicy = .returnCacheDataElseLoad
//    }
//    static let manager = NetworkHelper()
//    private let urlSession = URLSession(configuration: URLSessionConfiguration.default)
//    func performDataTask(with request: URLRequest, completionHandler: @escaping (Data) -> Void, errorHandler: @escaping (Error) -> Void) {
//        //        if let response = URLCache.shared.cachedResponse(for: request) {
//        //            completionHandler(response.data)
//        //            return
//        //        }
//        self.urlSession.dataTask(with: request){(data: Data?, response: URLResponse?, error: Error?) in
//            DispatchQueue.main.async {
//                guard let data = data else {errorHandler(AppError.noData); return}
//                if let error = error {
//                    errorHandler(error)
//                }
//                completionHandler(data)
//
//            }
//            }.resume()
//    }
//}


enum HTTPVerb: String {
    case GET
    case POST
}

class NetworkHelper {
    private init() {}
    static let manager = NetworkHelper()
    let urlSession = URLSession(configuration: .default)
    
    func performDataTask(with url: URLRequest, completionHandler: @escaping ((Data) -> Void), errorHandler: @escaping ((AppError) -> Void)) {
        
        self.urlSession.dataTask(with: url){(data: Data?, response: URLResponse?, error: Error?) in
            DispatchQueue.main.async {
                guard let data = data else {
                    errorHandler(AppError.noDataReceived)
                    return
                }
                if let response = response as? HTTPURLResponse {
                    errorHandler(AppError.goodStatusCode(num: response.statusCode))
                }
                if let error = error as? URLError {
                    switch error {
                    case URLError.notConnectedToInternet:
                        errorHandler(AppError.noInternetConnection)
                        return
                    default:
                        errorHandler(AppError.urlError(rawError: error))
                    }
                }
                if let error = error {
                    let error = error as NSError
                    if error.domain == NSURLErrorDomain && error.code == NSURLErrorNotConnectedToInternet {
                        errorHandler(AppError.noInternetConnection)
                        return
                    }
                    else {
                        errorHandler(AppError.other(rawError: error))
                    }
                }
                completionHandler(data)
            }
            }.resume()
    }
}


