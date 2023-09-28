//
//  ConnectivityModel.swift
//  DragonBall-APP
//
//  Created by Manuel Cazalla Colmenero on 25/9/23.
//

import Foundation

final class ConnectivityModel {
    enum ConectivityError: Error {
        case unknow
        case malformedUrl
        case decodingFailed
        case encodingFailed
        case noData
        case statusCode(code: Int?)
        case noToken
    }
    
    private var baseComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "dragonball.keepcoding.education"
        return components
    }
    
    private var token: String? {
        get {
            if let token = LocalData.getToken() {
                return token
            }
            return nil
        }
        set {
            if let token = newValue {
                LocalData.save(token: token)
            }
        }
    }
    
    func login (
        user: String,
        password: String,
        completion: @escaping (Result<String, ConectivityError>)-> Void){
            
            var components = baseComponents
            components.path = "/api/auth/login"
            
            guard let url = components.url else {
                completion(.failure(.malformedUrl))
                return
            }
            
            let loginString = String(format: "%@:%@", user, password)
            guard let loginData = loginString.data(using: .utf8) else {
                completion(.failure(.decodingFailed))
                return
            }
            let base64LoginString = loginData.base64EncodedString()
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
            let task = URLSession.shared.dataTask(with: request) {[weak self] data, response, error in
                guard error == nil else {
                    completion(.failure(.unknow))
                    return
                }
                
                guard let data else {
                    completion(.failure(.noData))
                    return
                }
                
                let urlResponse = response as? HTTPURLResponse
                let statusCode = urlResponse?.statusCode
                
                guard statusCode == 200 else {
                    completion(.failure(.statusCode(code: statusCode)))
                    return
                }
                
                guard let token = String(data: data, encoding: .utf8) else {
                    completion(.failure(.decodingFailed))
                    return
                }
                
                completion(.success(token))
                self?.token = token
            }
            task.resume()
        }
    
    func getHeroes(
        completion: @escaping (Result<[Heroe], ConectivityError>) -> Void) {
        var components = baseComponents
        components.path = "/api/heros/all"
        
        guard let url = components.url else {
            completion(.failure(.malformedUrl))
            return
        }
            guard let token else {
                completion(.failure(.noToken))
                return
            }
        
        
        
        var getAllHeroes = URLComponents()
        getAllHeroes.queryItems = [URLQueryItem(name: "name", value: "")]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = getAllHeroes.query?.data(using: .utf8)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            createTask(for: request,
                       using: [Heroe].self,
                       completion: completion)
    }
    
    func getTransformations(
        for hero: Heroe,
        completion: @escaping (Result<[Transformations], ConectivityError>) -> Void){
            
            var components = baseComponents
            components.path = "/api/heros/tranformations"
            
            guard let  url = components.url else {
                completion(.failure(.malformedUrl))
                return
                           
            }
            guard let token else {
                completion(.failure(.noToken))
                return
            }
            
/*         let body = GetTransformationBody(id: hero.id)
            
            guard let ecodedBody = try? JSONEncoder().encode(body) else {
                completion(.failure(.encodingFailed))
                return
            }
            */
            var urlComponents = URLComponents()
            urlComponents.queryItems = [URLQueryItem(name: "id", value: hero.id)]
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.httpBody = urlComponents.query?.data(using: .utf8)
            createTask(for: request,
                       using: [Transformations].self,
                       completion: completion)
            
        }
        
    func createTask<T: Decodable>(
        for request: URLRequest,
        using type: T.Type,
        completion: @escaping (Result<T, ConectivityError>) -> Void) {
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                let result: Result<T, ConectivityError>
                
                defer {
                    completion(result)
                }
                
                guard error == nil else {
                    result = .failure(.unknow)
                    return
                }
                guard let data else {
                    result = .failure(.noData)
                    return
                }
                guard let resource = try? JSONDecoder().decode(type, from: data) else {
                    result = .failure(.decodingFailed)
                    return
                }
                result = .success(resource)
            }
            task.resume()
    }
    
    
}
