//
//  MapViewController.swift
//  MvvmEczane
//
//  Created by Tuncay FORMA on 18.05.2022.
//

import UIKit
import MapKit
class MapViewController: UIViewController , MKMapViewDelegate{

    var selectedLocation = ""
    var selectedName = ""
    var locationX :Double = 0.0
    var locationY :Double = 0.0
    let mapView = MKMapView()
    override func viewDidLoad() {
        super.viewDidLoad()
        let locationArray = selectedLocation.components(separatedBy: ",")
        
        if let x = Double(locationArray[0]){
            locationX = x
        }
        if let y = Double(locationArray[1]){
            locationY = y
        }
        self.configureMap()
        self.placePins()
        
        // Do any additional setup after loading the view.
    }
   
    
   
    
    func configureMap() {
        let leftMargin:CGFloat = 0
        let topMargin:CGFloat = 0
        let mapWidth:CGFloat = view.frame.size.width
        let mapHeight:CGFloat = view.frame.size.height
        let center = CLLocationCoordinate2D(latitude: locationX, longitude: locationY)
        let span = MKCoordinateSpan(latitudeDelta: 0.125, longitudeDelta: 0.125)
        let region = MKCoordinateRegion(center: center, span: span)
        mapView.frame = CGRect(x: leftMargin, y: topMargin, width: mapWidth, height: mapHeight)

        mapView.setRegion(region, animated: true)
        view.addSubview(mapView)
        self.placePins()
        mapView.delegate = self
    }
    
    func placePins() {
        let coords = CLLocationCoordinate2D(latitude: locationX, longitude: locationY)
        let title = selectedName
        let annotation = MKPointAnnotation()
        annotation.coordinate = coords
        annotation.title = title
        mapView.addAnnotation(annotation)
        mapView.showAnnotations(mapView.annotations, animated: true)

    }
   
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let reuseId = "myAnnotation"
            var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
            
            if pinView == nil {
                pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                pinView?.canShowCallout = true
                pinView?.animatesDrop = true
                pinView?.tintColor = UIColor.blue
                pinView?.pinTintColor = UIColor.blue
                let button = UIButton(type: UIButton.ButtonType.detailDisclosure)
                pinView?.rightCalloutAccessoryView = button
                
            } else {
                pinView?.annotation = annotation
            }
            return pinView
        }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            if selectedName != ""{
                let requestLocation = CLLocation(latitude: locationY, longitude: locationY)
                CLGeocoder().reverseGeocodeLocation(requestLocation){(placemarks,erorr) in
                    if let placemark = placemarks{
                        if placemark.count > 0 {
                            let newPlacemark = MKPlacemark(placemark: placemark[0])
                            let item = MKMapItem(placemark: newPlacemark)
                            item.name = self.selectedName
                            let launchOption = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
                            item.openInMaps(launchOptions: launchOption)
                            
                        }
                    }
                }
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
