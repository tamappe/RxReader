//
//  EntryApiClient.swift
//  RxReader
//
//  Created by 玉置 on 2019/02/03.
//  Copyright © 2019 Tamaoki. All rights reserved.
//

import UIKit
import Alamofire
import CocoaLumberjack

class EntryApiClient: NSObject {
    
    let baseUrl = "https://summary-app-api.herokuapp.com"
    
    struct Path {
        static let index = "/api/index"
    }
    
    func request(parameters: [String: AnyObject]?, completion: @escaping ([Entry], Error?) -> Void) {
        guard let url = URL(string: baseUrl + Path.index) else { return }
        Alamofire.request(url, method: .get, parameters: parameters)
            .responseJSON { response in
                DDLogInfo(response.description)
                switch response.result {
                case .success:
                    DDLogInfo("Success!")
                    guard let data = response.data else {
                        DDLogInfo("no data or no response")
                        completion([], response.error)
                        return
                    }
                    if response.response?.statusCode == 200 {
                        DDLogInfo(data.description)
                        let decoder: JSONDecoder = JSONDecoder()
                        do {
                            let json = try decoder.decode(ResponseData.self, from: data)
                            completion(json.data, nil)
                        } catch {
                            DDLogError("error: \(error.localizedDescription)")
                            completion([], error)
                        }
                    }
                case .failure:
                    DDLogError("Failure!")
                    completion([], response.error)
                }
        }
    }
}
