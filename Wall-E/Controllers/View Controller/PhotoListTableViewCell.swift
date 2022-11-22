//
//  PhotoDetailTableViewCell.swift
//  Wall-E
//
//  Created by Matheus Oliveira on 11/22/22.
//

import UIKit

class PhotoListTableViewCell: UITableViewCell {

    @IBOutlet weak var photoCellImageImageView: UIImageView!
    @IBOutlet weak var photoCellIDLabel: UILabel!
    @IBOutlet weak var photoCellDateLabel: UILabel!
    
    func updateCell(with photo: Photo?) {
        guard let photo else {return}
        DispatchQueue.main.async{
            self.photoCellImageImageView.loadImageFrom(imageURL: photo.image)
            self.photoCellIDLabel.text = "Photo ID: \(photo.id ?? 0)"
            self.photoCellDateLabel.text = PhotoSearchViewController.sharedInstance.selectedDateString
        }
    }
}
