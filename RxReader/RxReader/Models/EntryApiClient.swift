//
//  EntryApiClient.swift
//  RxReader
//
//  Created by 玉置 on 2019/02/03.
//  Copyright © 2019 Tamaoki. All rights reserved.
//

import UIKit

class EntryApiClient: NSObject {
    func request(completion: @escaping ([Entry]?, Error?) -> Void) {
        guard let url = URL(string: "https://summary-app-api.herokuapp.com/") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("クライアントエラー: \(error.localizedDescription) \n")
                completion(nil, error)
                return
            }
            guard let data = data, let response = response as? HTTPURLResponse else {
                print("no data or no response")
                return
            }
            if response.statusCode == 200 {
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
            } else {
                print("サーバエラー ステータスコード: \(response.statusCode)\n")
                completion(nil, error)
            }
        }
        task.resume()
    }
}
