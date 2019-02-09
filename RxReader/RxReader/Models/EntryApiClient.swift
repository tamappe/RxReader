//
//  EntryApiClient.swift
//  RxReader
//
//  Created by 玉置 on 2019/02/03.
//  Copyright © 2019 Tamaoki. All rights reserved.
//

import UIKit
import Alamofire

class EntryApiClient: NSObject {
    
    let baseUrl = "https://summary-app-api.herokuapp.com"
    
    struct Path {
        static let index = "/api/index"
    }
//    func request(completion: @escaping ([Entry]?, Error?) -> Void) {
//        guard let url = URL(string: "https://summary-app-api.herokuapp.com/api/index") else { return }
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                print("クライアントエラー: \(error.localizedDescription) \n")
//                completion(nil, error)
//                return
//            }
//            guard let data = data, let response = response as? HTTPURLResponse else {
//                print("no data or no response")
//                return
//            }
//            if response.statusCode == 200 {
//                print(data)
//                let decoder: JSONDecoder = JSONDecoder()
//                do {
//                    let json = try decoder.decode(ResponseData.self, from: data)
//                    print(json)
//                    completion(json.data, nil)
//                } catch {
//                    print("error:", error.localizedDescription)
//                    completion(nil, error)
//                }
//            } else {
//                print("サーバエラー ステータスコード: \(response.statusCode)\n")
//                completion(nil, error)
//            }
//        }
//        task.resume()
//    }
    
    func request(parameters: [String: AnyObject]?, completion: @escaping ([Entry]?, Error?) -> Void) {
        guard let url = URL(string: baseUrl + Path.index) else { return }
        Alamofire.request(url, method: .get, parameters: parameters)
            .responseJSON { response in
                debugPrint(response)
                switch response.result {
                case .success:
                    print("Success!")
                    guard let data = response.data else {
                        print("no data or no response")
                        return
                    }
                    if response.response?.statusCode == 200 {
                        print(data)
                        let decoder: JSONDecoder = JSONDecoder()
                        do {
                            let json = try decoder.decode(ResponseData.self, from: data)
                            print(json)
                            completion(json.data, nil)
                        } catch {
                            print("error:", error.localizedDescription)
                            completion(nil, error)
                        }
                    }
                case .failure:
                    print("Failure!")
                }
        }
    }
}
