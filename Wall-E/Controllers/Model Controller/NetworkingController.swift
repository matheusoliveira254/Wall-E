//
//  NetworkingController.swift
//  Wall-E
//
//  Created by Matheus Oliveira on 10/27/22.
//

import Foundation
import UIKit

class NetworkingController {
    
    //MARK: - Keys
    private static let baseURL = "https://api.nasa.gov/mars-photos/api/v1/rovers/"
    private static let photosComponent = "photos"
    private static let apiKeyQueryKey = "api_key"
    private static let apiKeyValue = "mseaJA1uplRc8T1f1NfkhgNv6JTklbzGoiCsZmdn"
    private static let dateQueryKey = "earth_date"
    
    //fetch data
    static func fetch(with rover: String, date: String, completion: @escaping (Result<[Photo], ResultError>) -> Void) {
        //checking to see if a url can be created from baseURL
        guard let url = URL(string: baseURL) else {completion(.failure(.invalidURL)); return}
        let roverURL = url.appendingPathComponent(rover)
        let photosURL = roverURL.appendingPathComponent(photosComponent)
        //query items
        let dateQuery = URLQueryItem(name: dateQueryKey, value: date)
        let apiKeyQuery = URLQueryItem(name: apiKeyQueryKey, value: apiKeyValue)
        var urlComponents = URLComponents(url: photosURL, resolvingAgainstBaseURL: true)
        //combining the query items with the url
        urlComponents?.queryItems = [dateQuery,apiKeyQuery]
        // assigning the value of the url in url components to final url
        guard let finalURL = urlComponents?.url else {completion(.failure(.invalidURL)); return}
        print(finalURL)
        
        //checking for data, response or an error and handling the error.
        URLSession.shared.dataTask(with: finalURL) { data, _, error in
            if let error {
                print("❌There was a problem fetching the data from \(finalURL)")
                completion(.failure(.thrownError(error)))
                return
            }
            //checking if data came back from the url finalURL
            guard let data else {print("❌Something went wrong with the data"); completion(.failure(.noData)); return}
            
            do {
                let topLevelDictionary = try JSONDecoder().decode(TopLevelDictionary.self, from: data)
                let photos = topLevelDictionary.photos
                completion(.success(photos))
            } catch {
                print("❌Unable to decode!")
                completion(.failure(.unableToDecode))
                return
            }
        }.resume()
    }//End of func
    
    //fetch image
    static func fetchImage(with imageURL: String, completion: @escaping (Result<UIImage, ResultError>) -> Void) {
        //check to see if there is a image url.
        guard let imageSource = URL(string: imageURL) else {return}
        //checking for data, response or an error from that imageURL
        URLSession.shared.dataTask(with: imageSource) { data, _, error in
            if let error {
                print("❌Error with the image URL")
                completion(.failure(.invalidURL))
                return
            }
        //making sure the data was received from that url
        guard let data = data else {completion(.failure(.noData)); return}
        //checking to see if the a UIImage can be created from the data received and completing with either success or failure
        guard let Image = UIImage(data: data) else {completion(.failure(.noData)); return}
            completion(.success(Image))
        }.resume()
    }//End of image func
}//End of class
