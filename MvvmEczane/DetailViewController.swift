//
//  DetailViewController.swift
//  MvvmEczane
//
//  Created by Tuncay FORMA on 18.05.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    var selectedName = ""
    var selectedAddress = ""
    var selectedPhone = ""
    var selectedLocation = ""
    var image = UIImage(named: "eczane_logo")
    private let nameText = UILabel()
    private let addressText = UILabel()
    private let phoneText = UILabel()
    private let mapButton = UIButton()
    private let eczaneLogo = UIImageView()

    override func viewDidLoad() {
        let screenSize: CGRect = UIScreen.main.bounds
        super.viewDidLoad()
        
        nameText.text = "Eczane Adı: " + selectedName
        nameText.frame = CGRect(x: 0, y: (screenSize.height/2)-(screenSize.height*0.1), width: screenSize.width, height: screenSize.height*0.1)
        nameText.textAlignment = .center
        
        addressText.text = "Adresi: " + selectedAddress
        addressText.frame = CGRect(x: 0, y: screenSize.height/2-(screenSize.height*0.05), width: screenSize.width, height: screenSize.height*0.1)
        addressText.textAlignment = .center
        addressText.numberOfLines = 3
        phoneText.text = "Numarası: 0" + selectedPhone
        phoneText.frame = CGRect(x: 0, y: (screenSize.height/2), width: screenSize.width, height: screenSize.height*0.1)
        phoneText.textAlignment = .center
        
        mapButton.setTitle("Haritada Gör", for:.normal)
        mapButton.backgroundColor = .red
        mapButton.frame = CGRect(x: (screenSize.width-150)/2, y: screenSize.height/2+(screenSize.height*0.1), width: 150, height: 30)
        mapButton.addTarget(self, action: #selector(getMapView), for: .touchUpInside)
        
        mapButton.layer.cornerRadius = 5
        mapButton.layer.borderWidth = 1
        mapButton.layer.borderColor = UIColor.black.cgColor
        
        eczaneLogo.frame = CGRect(x: (screenSize.width-250)/2, y: (screenSize.height/2) - 300, width: 250 ,height: 250)
        
        eczaneLogo.image = image
        
        view.addSubview(nameText)
        view.addSubview(addressText)
        view.addSubview(phoneText)
        view.addSubview(mapButton)
        view.addSubview(eczaneLogo)
        
    
        
        
    }
    @objc func getMapView(sender:UIButton!){
        performSegue(withIdentifier: "getMapView", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "getMapView"{
            let mapVC = segue.destination as! MapViewController
            mapVC.selectedLocation = selectedLocation
            mapVC.selectedName = selectedName
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
