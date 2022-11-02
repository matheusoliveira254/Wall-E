//
//  PhotoViewController.swift
//  Wall-E
//
//  Created by Matheus Oliveira on 10/27/22.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    //MARK: - IBOutlets
    
    @IBOutlet weak var photoDetailImageView: UIImageView!
    @IBOutlet weak var photoIDLabel: UILabel!
    @IBOutlet weak var phtoDateDetailLabel: UILabel!
    
    var photoDetailToReceive: Photo? {
        didSet {
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func updateViews() {
        photoIDLabel.text = "ID: \(photoDetailToReceive?.id ?? 0)"
        phtoDateDetailLabel.text = "Date: \(photoDetailToReceive?.date ?? "0000-00-00")"
        photoDetailImageView.loadImageFrom(imageURL: photoDetailToReceive?.image)
    }
}
