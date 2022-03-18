

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
                                        completion: @escaping (Result<T,NetworkError>) -> Void) {
                
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
                if response.statusCode == 401 {
                }
            }

            if let data = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let responseModel = try jsonDecoder.decode(T.self, from: data)
                    completion(.success(responseModel ))
                } catch {
                    //type of failure
                    completion(.failure(.decodingError))
                    print(error)
                }
            } else {
                completion(.failure(.noDataError))
            }
        }.resume()
    }
}


