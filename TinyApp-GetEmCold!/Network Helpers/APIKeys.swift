//
//  APIKeys.swift
//  TinyApp-GetEmCold!
//
//  Created by C4Q on 2/23/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation

//MARK: Set each parameter needed for the GET Request and interpolate it in the final endpoint. Use this when you need to plug in the           endpoint in the API clients completion in the view controller to keep best MVC practices

struct SetEnpointURL{
    //Postman request for correct get request url: "https://api.punkapi.com/v2/beers?abv_gt=7&brewed_after=10-1987"
    //baseEndpoint = "https://api.punkapi.com/v2/beers?"
    
    ////////MARK: SETTING NECESSARY PARAMETERS/////////
    
    //    private static let clientID = ""
    //    private static let clientSecret = ""
    private static let abvAmount = 7
    private static let brewedAfterDate = "10-1987"
    
    static let getRequestURL = "https://api.punkapi.com/v2/beers?abv_gt=\(SetEnpointURL.abvAmount)&brewed_after=\(SetEnpointURL.brewedAfterDate)"
}
