//
//  NASAAPIService.swift
//  POTDProject
//
//  Created by Dev3 on 22/1/2569 BE.
//

import Foundation

final class NASAAPIService: NASAAPIServiceProtocol {
    
    private let apiKey = "lMZDypKaZNC2A8aVjRXc0vkytB9bvGgRK0N075f1"
    private let baseURL = "https://api.nasa.gov/planetary/apod"

    func fetchAPOD(
        startDate: Date,
        endDate: Date,
        completion: @escaping (Result<[APODItem], Error>) -> Void
    ) {
        
        guard let url = buildURL(start: startDate, end: endDate) else {
            completion(.failure(APIError.invalidURL))
            return
        }
        print(url)
        let request = URLRequest(url: url, timeoutInterval: 30)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let http = response as? HTTPURLResponse,
                  200..<300 ~= http.statusCode,
                  let data = data else {
                completion(.failure(APIError.invalidResponse))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let items = try decoder.decode([APODItem].self, from: data)
                completion(.success(items))
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    // MARK: - URL Builder
    private func buildURL(start: Date, end: Date) -> URL? {
        var components = URLComponents(string: baseURL)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        components?.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "start_date", value: formatter.string(from: start)),
            URLQueryItem(name: "end_date", value: formatter.string(from: end)),
        ]
        
        return components?.url
    }
}
