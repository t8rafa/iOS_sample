//
//  Api.swift
//  Sample
//
//  Created by Rafael Alencar Trisotto on 21/03/15.
//  Copyright (c) 2015 T8 Studio de Tecnologia. All rights reserved.
//

import Foundation

public class Api {
    let url = NSURL(string: "http://workerapi.azurewebsites.net/api/values/")!
    let listener: ApiListener
    var connection: Connectable
    
    public init(listener: ApiListener) {
        self.listener = listener
        self.connection = Connection()
    }
    
    public init(listener: ApiListener, andConnection connection: Connectable) {
        self.listener = listener
        self.connection = connection
    }
    
    public func send(candidate: Candidate) {
        let jsonData = candidate.toJsonString()
        
        let request = NSMutableURLRequest(URL: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPMethod = "POST"
        request.HTTPBody = candidate.toJson()
        
        connection.sendRequest(request, withCompletionHandler: { (response, data, error) -> Void in
            if error != nil {
                let response = Response()
                response.status = "connection_error"
                response.code = error.code
                response.message = error.localizedDescription
                
                self.listener.onError(response)
            } else {
                if let response = self.parseData(data) {
                    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                        if response.status == "success" {
                            self.listener.onSuccess(response)
                        } else {
                            self.listener.onError(response)
                        }
                    })
                }
            }
        })
    }
    
    private func parseData(data: NSData) -> Response? {
        var result: Response? = nil
        
        let json: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil)
        
        if let candidateJson = json as? NSDictionary {
            result = Response()
            
            if let status = candidateJson["status"] as? String {
                result!.status = status
            }
            
            if let code = candidateJson["code"] as? Int {
                result!.code = code
            }
            
            if let message = candidateJson["message"] as? String {
                result!.message = message
            }
        }
        
        return result
    }
}