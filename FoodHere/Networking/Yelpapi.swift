//
//  File.swift
//  FoodHere
//
//  Created by O GabrielPro on 11/06/23.
//

import Alamofire

struct SearchResponse: Codable {
    let businesses: [Business]
    let total: Int
    let nextToken: String?
}

class YelpAPI {
    private let baseURL = "https://api.yelp.com/v3/businesses/search"
    private let apiKey = "itoMaM6DJBtqD54BHSZQY9WdWR5xI_CnpZdxa3SG5i7N0M37VK1HklDDF4ifYh8SI-P2kI_mRj5KRSF4_FhTUAkEw322L8L8RY6bF1UB8jFx3TOR0-wW6Tk0KftNXXYx"

    func searchRestaurants(latitude: Double, longitude: Double, categories: String = "restaurants", limit: Int = 10, sortBy: String = "rating", nextPageToken: String? = nil, completion: @escaping (Result<SearchResponse, Error>) -> Void) {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(apiKey)"
        ]

        var parameters: Parameters = [
            "latitude": latitude,
            "longitude": longitude,
            "categories": categories,
            "limit": limit,
            "sort_by": sortBy
        ]

        if let nextPageToken = nextPageToken {
            parameters["next_page_token"] = nextPageToken
        }

        AF.request(baseURL, parameters: parameters, headers: headers)
            .validate()
            .responseDecodable(of: SearchResponse.self) { response in
                switch response.result {
                case .success(let searchResponse):
                    completion(.success(searchResponse))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}


