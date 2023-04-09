//
//  ViewController.swift
//  Part1
//
//  Created by Prachit on 04/04/23.
//

/*

- An Image container shows an image which will load via image link (server url) .
- Image Container should resize itself depending on the image ratio in terms of height .
- Image Container width will be fixed as per the device width.
- Height can vary to match the image ratio .
- Image should not Stretch / Squeeze / distort nor it should get cut in terms of height and width .

*/

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: CustomImageView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    let imageUrls = [
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMgPGhudAe6slj-eLslJqcSjKJkFDqZySD-LeR4l6LyCZlF4nVTeB_mD4t_3R2kEVwJHs&usqp=CAU",
        "https://img3.goodfon.com/wallpaper/nbig/4/41/avanger-iron-man-stark-movie.jpg",
        "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/800px-Image_created_with_a_mobile_phone.png"
        // add more URLs as needed
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
//MARK: - Helpers
    
    fileprivate func setupUI() {
        pickerView.dataSource = self
        pickerView.delegate = self
        
        let link1 = URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMgPGhudAe6slj-eLslJqcSjKJkFDqZySD-LeR4l6LyCZlF4nVTeB_mD4t_3R2kEVwJHs&usqp=CAU")! ;
        imageView.loadImage(from: link1)
    }
    
    
}

extension ViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: - UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return imageUrls.count
    }
    
    // MARK: - UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "Image \(row + 1)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let imageUrl = URL(string: imageUrls[row])
        imageView.loadImage(from: imageUrl!)
    }
    
}
