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
    
    //MARK: - Properties
    var selectedDateString: String
    var roverString: String
    private var photos: [Photo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    //MARK: - Actions
    @IBAction func photoDateDateChanged(_ sender: UIDatePicker) {
        print(sender.date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: photoDateDatePicker.date)
        selectedDateString = dateString
        print(selectedDateString)
    }
    
    @IBAction func roverSelected(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            roverString = "curiosity"
        } else if sender.selectedSegmentIndex == 1 {
            roverString = "opportunity"
        } else {
            roverString = "spirit"
        }
    }
    
    func fetchPhotos() {
        NetworkingController.fetch(with: roverString, date: selectedDateString) { [weak self] result in
            switch result {
            case .success(let photos):
                self?.photos = photos
                DispatchQueue.main.async {
//                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("❌There was an error!", error.localizedDescription!)
            }
        }
    }
    
}//End class

