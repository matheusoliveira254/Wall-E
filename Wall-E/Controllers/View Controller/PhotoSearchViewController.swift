//
//  ViewController.swift
//  Wall-E
//
//  Created by Matheus Oliveira on 10/15/22.
//

import UIKit

class PhotoSearchViewController: UIViewController {

    //MARK: - IBOutles
    @IBOutlet weak var photoDateDatePicker: UIDatePicker!
    @IBOutlet weak var roverSelectionSegmentedControl: UISegmentedControl!
    @IBOutlet weak var photosListTableView: UITableView!
    
    //MARK: - Properties
    var selectedDateString: String = "2015-06-03"
    var roverString: String = "curiosity"
    var photosArray: [Photo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photosListTableView.delegate = self
        photosListTableView.dataSource = self

    }


    //MARK: - Actions
    @IBAction func photoDateDateChanged(_ sender: UIDatePicker) {
        photosArray = []
        print(sender.date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: photoDateDatePicker.date)
        selectedDateString = dateString
        print(selectedDateString)
        fetchPhotos()
    }
    
    @IBAction func roverSelected(_ sender: UISegmentedControl) {
        photosArray = []
        if sender.selectedSegmentIndex == 0 {
            roverString = "curiosity"
        } else if sender.selectedSegmentIndex == 1 {
            roverString = "opportunity"
        } else {
            roverString = "spirit"
        }
        fetchPhotos()
    }
    
    func fetchPhotos() {
        NetworkingController.fetch(with: roverString, date: selectedDateString) { [weak self] result in
            switch result {
            case .success(let photo):
                self?.photosArray = photo.photos
                DispatchQueue.main.async {
                    self?.photosListTableView.reloadData()
                }
            case .failure(let error):
                print("❌There was an error!", error.localizedDescription)
            }
        }
    }
    
    func fetchImages(with imageURL: String) {
        NetworkingController.fetchImage(with: imageURL) { [weak self] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
//                    self?.photosListTableView.cell = image
                }
            case .failure(let error):
                print("There was an error with the image!", error.errorDescription!)
            }
        }
    }
}//End class

extension PhotoSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Photos Taken on That Date:"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photosArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoListCell", for: indexPath)
        let photoIndex = photosArray[indexPath.row]
        cell.textLabel?.text = "Photo ID: \(photoIndex.id ?? 0)"
        cell.detailTextLabel?.text = selectedDateString
//        cell.imageView?.image =
        return cell
    }
}
