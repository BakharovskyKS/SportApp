//
//  DataRequest.swift
//  SportApp
//
//  Created by Кирилл Бахаровский on 11/10/24.
//

import Foundation

class NetworkService {
    private let baseURL = "https://api.api-ninjas.com/v1/exercises"
    private let apiKey = "Vhcf8bKicFCR2N+c2kRDvQ==OPDEHb85Js8GiCgf"
    
    static let shared = NetworkService()
    private init() {}
    
    func fetchExercises(name: String? = nil, type: String? = nil, muscle: String? = nil, difficulty: String? = nil, offset: Int? = nil, completion: @escaping (Result<[ExercisesModel], Error>) -> Void) {
        var urlComponents = URLComponents(string: baseURL)!
        
        var queryItems = [URLQueryItem]()
        if let name = name {
            queryItems.append(URLQueryItem(name: "name", value: name))
        }
        if let type = type {
            queryItems.append(URLQueryItem(name: "type", value: type))
        }
        if let muscle = muscle {
            queryItems.append(URLQueryItem(name: "muscle", value: muscle))
        }
        if let difficulty = difficulty {
            queryItems.append(URLQueryItem(name: "difficulty", value: difficulty))
        }
        if let offset = offset {
            queryItems.append(URLQueryItem(name: "offset", value: "\(offset)"))
        }
        urlComponents.queryItems = queryItems
        
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        request.addValue(apiKey, forHTTPHeaderField: "X-Api-Key")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            do {
                let exercises = try JSONDecoder().decode([ExercisesModel].self, from: data)
                print(exercises)
                completion(.success(exercises))
            } catch let decodingError {
                completion(.failure(decodingError))
            }
        }.resume()
    }
}
