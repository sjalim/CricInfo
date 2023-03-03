////
////  APIFixtureHelper.swift
////  CricInfo
////
////  Created by bjit on 8/2/23.
////
import Foundation

enum APIError: Error {
    case invalidUrl
    case errorDecode
    case failed(error: Error)
    case unknownError
}

class NetworkHelper{

    static let shared = NetworkHelper()

    private init(){}

    func fetchData<T: Codable>(with endPoint: CricketAPIResources, parameters: [String:String] = [:], pathId id: Int, completion: @escaping (Result<T,APIError>) -> Void){
        
        guard let url = CricketAPIRepository.shared.getURL(with: endPoint, parameters: parameters, pathId: id
        )
        else{
            return
        }
            
        print("url:",url)
        let urlRequest = URLRequest(url: url)

        URLSession.shared.dataTask(with: urlRequest) { data, response, error  in
                    if error != nil {
                        print("dataTask error: \(error!.localizedDescription)")
                        completion(.failure(.failed(error: error!)))
                    } else if let data = data {
                        // Success request
                        do {
                            // 4. Decode json into array of User
//                            print("data:", data)
                            print("Type:",type(of: T.self))
                        let getRespose = try JSONDecoder().decode(T.self , from: data)

                            print("success")
//                            self.totalSize += getRespose.totalResults
                            completion(.success(getRespose))
                        } catch {
                            // Send error when decoding
                            print("decoding error")
                            completion(.failure(.errorDecode))
                        }
                    } else {
                        print("unknown dataTask error")
                        completion(.failure(.unknownError))
                    }
                }
                .resume()
    }
}
