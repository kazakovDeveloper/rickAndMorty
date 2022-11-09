//
//  ApiCaller.swift
//  RickAndMorty
//
//  Created by Kazakov Danil on 09.11.2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    struct Constants {
        static let url = "https://rickandmortyapi.com/api/character"
    }
    
    private init() {}
    
    func fetchImage(from url: String?, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: url ?? "") else {
            completion(.failure(.invalidURL))
            return
            
        }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
                
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
        
    }
    

    func getCharacterData(
        completion: @escaping (Result<Character, Error>) -> Void) {
            
            guard let url = URL(string: Constants.url) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do{
                let characters = try JSONDecoder().decode(Character.self, from: data)
                completion(.success(characters))
            }
            catch{
                completion(.failure(error))
                
            }
        }
        task.resume()
        
    }
    
    
    
}
