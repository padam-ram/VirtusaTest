
//
//  APIWapperClass.swift
//  VirtusaTest
//
//  Created by Apple on 17/03/22.
//


import Foundation
import UIKit

    
//MARK: - Request Type

enum RequestType: String {
    case GET
    case POST
}

//MARK: - Request Error

enum NetworkError: Error {
    case domainError
    case decodingError
    case noDataError 
}


//MARK: - Request Model For Get

struct RequestModelForGet  {
    let url : NSURL
    let serviceType : RequestType     = .GET
    var querryItems : [URLQueryItem]? = nil
    let httpBody    : [String:Any]?   = nil
    var param       : [String:Any]?   = nil
    let httpHeaderField  : [String : String]?
    var httpHeaderField_userInputContent : [String : String]?
}


//MARK: - APIWapperClass

class APIWapperClass : NSObject {
    
    //MARK: - Get Method
    
    class func ServicerequestForGetMethod<T:Decodable>(_ requestModel:RequestModelForGet,
                                        _ modelType: T.Type,
                                        completion: @escaping (Result<T,NetworkError>,HTTPURLResponse) -> Void) {
                
        if !Reachability.isConnectedToNetwork(){
            print("No Internet Acess")
            return
        }
        let session = URLSession.shared
        var serviceUrl = URLComponents(string: requestModel.url.description)
        print("RequestUrl  = >",serviceUrl!)
        serviceUrl?.queryItems =  requestModel.querryItems
        guard let componentURL = serviceUrl?.url else { return }
        var request = URLRequest(url: componentURL)
        request.httpMethod = requestModel.serviceType.rawValue
       // request.allHTTPHeaderFields =  requestModel.httpHeaderField
        request.allHTTPHeaderFields =  requestModel.httpHeaderField_userInputContent
        if let parameterDictionary  = requestModel.httpBody  {
            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
                return
            }
            request.httpBody = httpBody
        }
        
        session.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 404 {
                    completion(.failure(.noDataError), response )
                    return
                }
            }

            if let data = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let responseModel = try jsonDecoder.decode(T.self, from: data)
                    completion(.success(responseModel), response as! HTTPURLResponse)
                } catch {
                    //type of failure
                    completion(.failure(.decodingError), response as! HTTPURLResponse)
                    print(error)
                }
            } else {
                completion(.failure(.noDataError), response as! HTTPURLResponse)
            }
        }.resume()
    }
}


