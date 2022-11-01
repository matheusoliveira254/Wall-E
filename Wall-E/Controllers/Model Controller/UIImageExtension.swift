//
//  UIImageExtension.swift
//  Wall-E
//
//  Created by Matheus Oliveira on 11/1/22.
//

import Foundation
import UIKit

extension UIImageView {
    
    //Func created to create an image from a URL
    func loadImageFrom(imageURL: String?) {
        guard let imageURL = imageURL else {return}
        
        let httpsURL = "https" + imageURL.dropFirst(4)
        guard let url = URL(string: httpsURL) else {return}
        
        URLSession.shared.dataTask(with: url) { imageData, _, error in
            if let error {
                DispatchQueue.main.async {
                    self.image = UIImage(named: "image_default_food")
                    print("Error Displaying Image!!")
                }
            }
            
            if let data = imageData {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
        }.resume()
    }
}
