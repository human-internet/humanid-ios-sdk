//
//  Rest.swift
//  SDK
//
//  Created by fanni suyuti on 11/09/19.
//  Copyright © 2019 HumanID. All rights reserved.
//

import Foundation

internal class Rest {
    
    private class func dataTask(request: NSMutableURLRequest, method: String, completion: @escaping (_ success: Bool, _ object: Data?, _ errorMessage: String?) -> ()) {
        request.httpMethod = method
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            if let data = data {
                if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                    completion(true, data, nil)
                } else {
                    completion(false, data, String(data:data, encoding: .utf8))
                }
            }
            }.resume()
    }
    
    internal class func post(url: URL, data: Data? = nil, completion: @escaping (_ success: Bool, _ data: Data?, _ errorMessage: String?) -> ()) {
        
        let request = NSMutableURLRequest(url: url)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let data = data {
            request.httpBody = data
        }
        
        dataTask(request: request, method: "POST", completion: completion)
    }
    
    internal class func get(url: URL, json: String, request: NSMutableURLRequest, completion: @escaping (_ success: Bool, _ data: Data?, _ errorMessage: String?) -> ()) {
        let request = NSMutableURLRequest(url: url)
        dataTask(request: request, method: "GET", completion: completion)
    }
}
