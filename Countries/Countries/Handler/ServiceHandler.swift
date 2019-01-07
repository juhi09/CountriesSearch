//
//  ServiceHandler.swift
//  Countries
//
//  Created by Juhi Gautam on 05/01/19.
//  Copyright © 2019 Juhi Gautam. All rights reserved.
//

import UIKit

class ServiceHandler: NSObject {
    static let sharedServiceHandler = ServiceHandler()
    private override init(){}
    func fetchCountries(url : URL , withCompletion completion: @escaping (Bool) -> Void) {
        let session = URLSession(configuration: .ephemeral, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: url, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            
            guard let data = data else {
                completion(false)
                return
            }
            guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) else {
                completion(false)
                return
            }
            print(json)
            ResponseHandler.sharedResponseHandler.saveData(jsonData: json as! NSArray)
            completion(true)
        })
        task.resume()
    }

}
