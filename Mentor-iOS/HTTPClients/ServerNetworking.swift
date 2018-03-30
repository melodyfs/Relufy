//
//  ServerNetworking.swift
//  Mentor-iOS
//
//  Created by Melody on 3/28/18.
//  Copyright © 2018 Melody Yang. All rights reserved.
//

import Foundation

enum Route {
    case createMentor
    case getMentor
    case updateMentor
    case createMentee
    case getMentee
    case updateMentee
    case connectPusher
    
   
    func path() -> String {
        
        switch self {
        case .createMentor, .getMentor, .updateMentor:
            return "http://localhost:3000/mentors"
        case .createMentee, .updateMentee:
            return "http://localhost:3000/mentees"
        case .connectPusher:
            return "http://localhost:3000/pushers"
        // TODO: Remove this after testing
        case .getMentee:
            return "http://localhost:3000/mentees/all"
        }
    }
    
    func headers() -> [String: String] {
        switch self {
        case .createMentor, .createMentee:
            return [:]
        default:
            let headers = ["Authorization": "Token token=6ytt7bb5b834d37135dbb61d71955fc0"]
            return headers
        }
        
    }
    
    
    func body(data: Encodable?) -> Data? {
        let encoder = JSONEncoder()
        
        switch self {
        case .connectPusher:
            return nil
        default:
            guard let model = data as? User else {return nil}
            let result = try? encoder.encode(model)
            return result
        }
    }
    
    func method() -> String {
        switch self {
        case .createMentor, .createMentee, .connectPusher:
            return "POST"
        case .updateMentor, .updateMentee:
            return "PATCH"
        default:
            return "GET"
        }
    }
}


class ServerNetworking {
    
    static var shared = ServerNetworking()
    
    let session = URLSession.shared
    var statusCode = 0
    
    func fetch(route: Route, data: Encodable?, completion: @escaping (Data) -> Void) {
        let base = route.path()
        var url = URL(string: base)!
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = route.headers()
        request.httpBody = route.body(data: data)
        request.httpMethod = route.method()
        
        session.dataTask(with: request) { (data, res, err) in
            let httpResponse = res as? HTTPURLResponse
            if let data = data {
                self.statusCode = (httpResponse?.statusCode)!
                print(self.statusCode)
                completion(data)
                print("Networking succeeded")
            }
            else {
                print(err?.localizedDescription ?? "Error")
            }
            
            }.resume()
        
    }
    
}

