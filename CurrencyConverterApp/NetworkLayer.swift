//
//  NetworkLayer.swift
//  CurrencyConverterApp
//
//  Created by Designer on 2023/06/27.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case badStatus
}

struct NetworkLayer {
    // closure 방식
    static func fetchJson(completion : @escaping (CurrencyModel) -> Void) {
        // 함수가 끝나도 나중에 값을 가져올수 있도록 @escaping을 해야한다.
        let urlString = "https://open.er-api.com/v6/latest/USD"
        guard let url = URL(string: urlString) else {
            return
        }

        // data task
        URLSession.shared.dataTask(with: url) { data, response, error in
           
            guard let data = data else {
                return
            }
            do{
                let currencyModel = try JSONDecoder().decode(CurrencyModel.self, from: data)
                // [key : value]
//                let rates1 = currencyModel.rates?.map { [$0 : $1] }
//                let rates2 : [(String, Double)]? = currencyModel.rates?.sorted(by: { dic1, dic2 in
//                    dic1.key < dic2.key
//                })
                
                completion(currencyModel)
                
            }catch{
                print("error",error)
            }
        }.resume()
    }
    
    // async 타입
    static func fetchJsonAsyncAwait() async throws -> CurrencyModel {
        let urlString = "https://open.er-api.com/v6/latest/USD"
        guard let url = URL(string: urlString) else {
            throw NetworkError.badUrl
        }
        do{
            let (data, response) = try await URLSession.shared.data(from: url)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                throw NetworkError.badStatus
            }
            
            let currencyModel = try JSONDecoder().decode(CurrencyModel.self, from: data)
            
            return currencyModel
            
        }catch{
            throw error
        }
    }
}
