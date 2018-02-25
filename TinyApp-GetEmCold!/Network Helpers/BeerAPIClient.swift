//
//  BeerAPIClient.swift
//  TinyApp-GetEmCold!
//
//  Created by C4Q on 2/23/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation

class BeerAPIClient {
    private init(){}
    static let manager = BeerAPIClient()
    
    
    //If endpoint not in APIClient you need it in funciton signature
    func getBeersWithURLString(from endPoint: String, completion: @escaping ([Beer]) -> Void, errorHandler: @escaping (Error)-> Void){
        
        //MARK: Use this when checking for multiple endpoints
        //EXAMPLE: MUST SET THE STRUCT IN THE VC before calling it in the API Client call
        
        /*
         var endPoint = String()
         if let beerLocation = BeerEndPoint.location{
         endpoint = functionCall(beerLocation)
         } else {
         //usually call these from a beerEndPoint Struct that has the parameters
         guard let abv = BeerEndPoint.abv, brewedAfterDate = BeerEndPoint.brewedAfterDate else {return}
         endPoint = setBeerEndpoint(with: abv, brewedAfterDate)
         */
    }
    
    func setBeerEndpoint(with abv: Int, _ brewedAfterDate: String) -> String {
        var baseEndpoint = URLComponents(string: "https://api.punkapi.com/v2/beers?")
        
        //Query Items == parameters i.e: clientID, clientSecret, etc
        baseEndpoint?.queryItems = [
            URLQueryItem(name: "abv_gt", value: String(abv)),
            URLQueryItem(name: "brewed_after", value: brewedAfterDate)
        ]
        let beerRequestEndpoint = baseEndpoint?.url?.absoluteString
        return beerRequestEndpoint!
    }
    
    
    //If endpoint in APIClient --> don't need it in the function signature
    func getBeersNoURLString(_ completion: @escaping ([Beer])-> Void,
                             errorHandler: @escaping (Error)-> Void){
        
        let endPoint = "https://api.punkapi.com/v2/beers?abv_gt=7&brewed_after=10-1987"
        //valid url check
        guard let url = URL(string: endPoint) else {return}
        //internet request using url string
        let request = URLRequest(url: url)
        //set completion
        let parseDataIntoBeer: (Data) -> Void = {(data) in
            do{
                let decoder = JSONDecoder()
                let results = try decoder.decode([Beer].self, from: data) // when you decode the top layer you see what's inside.
                let beers = results //[Beer]
                completion(beers)
                print("JSON Data is now an [Beer]")
            } catch {
                errorHandler(AppError.couldNotParseJSONObject(rawError: error))
                print("bad data from beer parsing")
            }
        }
        //call NetworkHelper
        NetworkHelper.manager.performDataTask(with: request,
                                              completionHandler: parseDataIntoBeer,
                                              errorHandler: errorHandler)
    }
}





























