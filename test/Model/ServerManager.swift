//
//  ServerManager.swift
//  Wathakkir
//
//  Created by Abdullah on 19.11.17.
//  Copyright © 2017 Abdullah. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireImage

let base_url: String = "http://localhost:8080"

class ServerManager {
    
    static let dateFormatter = DateFormatter() // for converting Dates to string
    
    // general request to the API, each function here will use this one
    static func send(api: String, method: HTTPMethod, parameters: Parameters?, completion: @escaping (_ result: String?, _ error: NSError?)->()) -> Void {
        
        let headers = [
            "Content-Type": "application/json; charset=utf-8",
            "Accept": "application/json",
            ]
        
        let url = (base_url + api) as URLConvertible
        
        Alamofire.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseString { response in
                switch response.result {
                case .success:
                    completion(response.result.value, nil)
                case .failure(let error):
                    completion(nil, error as NSError?)
                }
        }
    }

    // getting the post from API
    static func getPost(id : Int ,completion: @escaping (_ post: Post?, _ error : NSError?) -> () ) {
        
        func response_completion( _ response_result: String? , response_error: NSError? ) -> Void {
            if response_error != nil {
                completion(nil, response_error)
                return
            }
            
            guard let postJson = response_result else {
                return
            }
            
            let post = Post(JSONString: postJson)

            completion(post, nil)
        }
        
        send(api: "/post/\(id)", method: .get, parameters: nil, completion: response_completion )
    }
    
    
    
    
}


