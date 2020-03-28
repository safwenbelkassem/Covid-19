//
//  MapViewController.swift
//  Covid-19-Demo
//
//  Created by MacBook on 3/27/20.
//  Copyright © 2020 MacBookSafwen. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Alamofire

struct MyPlace {
    var name: String
    var lat: Double
    var long: Double
}

class MapViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate, GMSAutocompleteViewControllerDelegate, UITextFieldDelegate {

    let currentLocationMarker = GMSMarker()
    var locationManager = CLLocationManager()
    var chosenPlace: MyPlace?
    
    let customMarkerWidth: Int = 50
    let customMarkerHeight: Int = 70
    
    var country: String = ""
    var totCases: Int = 0
    
    var coutryForSearch : String?
    var previewDemoData = [(title: "", img: #imageLiteral(resourceName: "90-1"), stat: "Cases: ", value: 0)]
   
    override func viewDidLoad() {
       
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        myMapView.delegate=self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        
        getStatTunisiaMap(coutry: coutryForSearch ?? "tunisia")
        setupViews()
        
        initGoogleMaps()
        
        txtFieldSearch.delegate=self
        
        
        // Do any additional setup after loading the view.
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
           let autoCompleteController = GMSAutocompleteViewController()
           autoCompleteController.delegate = self
           
           let filter = GMSAutocompleteFilter()
           autoCompleteController.autocompleteFilter = filter
           
           self.locationManager.startUpdatingLocation()
           self.present(autoCompleteController, animated: true, completion: nil)
           return false
       }
       
       // MARK: GOOGLE AUTO COMPLETE DELEGATE
       func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
           let lat = place.coordinate.latitude
           let long = place.coordinate.longitude
           
           showPartyMarkers(lat: lat, long: long)
           
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 2.0)
           myMapView.camera = camera
           txtFieldSearch.text=place.formattedAddress
           chosenPlace = MyPlace(name: place.formattedAddress!, lat: lat, long: long)
           let marker=GMSMarker()
           marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
           marker.title = "\(place.name ?? "Unkown")"
           marker.snippet = "\(place.formattedAddress!)"
           marker.map = myMapView
           coutryForSearch = txtFieldSearch.text
           self.dismiss(animated: true, completion: nil) // dismiss after place selected
       }
       
       func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
           print("ERROR AUTO COMPLETE \(error)")
       }
       
       func wasCancelled(_ viewController: GMSAutocompleteViewController) {
           self.dismiss(animated: true, completion: nil)
       }
       
       func initGoogleMaps() {
           let camera = GMSCameraPosition.camera(withLatitude: 28.7041, longitude: 77.1025, zoom: 17.0)
           self.myMapView.camera = camera
           self.myMapView.delegate = self
           self.myMapView.isMyLocationEnabled = true
       }
       
       // MARK: CLLocation Manager Delegate
       
       func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
           print("Error while getting location \(error)")
       }
       
       func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           locationManager.delegate = nil
           locationManager.stopUpdatingLocation()
           let location = locations.last
           let lat = (location?.coordinate.latitude)!
           let long = (location?.coordinate.longitude)!
           let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 17.0)
           
           self.myMapView.animate(to: camera)
           
           showPartyMarkers(lat: lat, long: long)
       }
       
       // MARK: GOOGLE MAP DELEGATE
       func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
           guard let customMarkerView = marker.iconView as? CustomMarkerView else { return false }
           let img = customMarkerView.img!
           let customMarker = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: customMarkerWidth, height: customMarkerHeight), image: img, borderColor: UIColor.white, tag: customMarkerView.tag)
           
           marker.iconView = customMarker
           
           return false
       }
       
       func mapView(_ mapView: GMSMapView, markerInfoContents marker: GMSMarker) -> UIView? {
           guard let customMarkerView = marker.iconView as? CustomMarkerView else { return nil }
           let data = previewDemoData[customMarkerView.tag]
        restaurantPreviewView.setData(title: self.country, img: data.img, stat: data.stat, value: self.totCases)
           return restaurantPreviewView
       }
      
       
       func mapView(_ mapView: GMSMapView, didCloseInfoWindowOf marker: GMSMarker) {
           guard let customMarkerView = marker.iconView as? CustomMarkerView else { return }
           let img = customMarkerView.img!
           let customMarker = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: customMarkerWidth, height: customMarkerHeight), image: img, borderColor: UIColor.darkGray, tag: customMarkerView.tag)
           marker.iconView = customMarker
       }
       
       func showPartyMarkers(lat: Double, long: Double) {
           myMapView.clear()
//           for i in 0..<3 {
//               let randNum=Double(arc4random_uniform(30))/10000
//               let marker=GMSMarker()
//               let customMarker = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: customMarkerWidth, height: customMarkerHeight), image: previewDemoData[i].img, borderColor: UIColor.darkGray, tag: i)
//               marker.iconView=customMarker
//               let randInt = arc4random_uniform(4)
//               if randInt == 0 {
//                   marker.position = CLLocationCoordinate2D(latitude: lat+randNum, longitude: long-randNum)
//               } else if randInt == 1 {
//                   marker.position = CLLocationCoordinate2D(latitude: lat-randNum, longitude: long+randNum)
//               } else if randInt == 2 {
//                   marker.position = CLLocationCoordinate2D(latitude: lat-randNum, longitude: long-randNum)
//               } else {
//                   marker.position = CLLocationCoordinate2D(latitude: lat+randNum, longitude: long+randNum)
//               }
//               marker.map = self.myMapView
//           }
        
        let marker=GMSMarker()
        let customMarker = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: customMarkerWidth, height: customMarkerHeight), image: previewDemoData[0].img, borderColor: UIColor.darkGray, tag: 0)
                       marker.iconView=customMarker
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
        marker.map = self.myMapView
    }
       
       @objc func btnMyLocationAction() {
           let location: CLLocation? = myMapView.myLocation
           if location != nil {
               myMapView.animate(toLocation: (location?.coordinate)!)
           }
       }
       
      
       
       func setupTextField(textField: UITextField, img: UIImage){
        textField.leftViewMode = UITextField.ViewMode.always
           let imageView = UIImageView(frame: CGRect(x: 5, y: 5, width: 20, height: 20))
           imageView.image = img
           let paddingView = UIView(frame:CGRect(x: 0, y: 0, width: 30, height: 30))
           paddingView.addSubview(imageView)
           textField.leftView = paddingView
       }
       
       func setupViews() {
           view.addSubview(myMapView)
           myMapView.topAnchor.constraint(equalTo: view.topAnchor).isActive=true
           myMapView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive=true
           myMapView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive=true
           myMapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 60).isActive=true
           
           self.view.addSubview(txtFieldSearch)
           txtFieldSearch.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive=true
           txtFieldSearch.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive=true
           txtFieldSearch.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive=true
           txtFieldSearch.heightAnchor.constraint(equalToConstant: 35).isActive=true
           setupTextField(textField: txtFieldSearch, img: #imageLiteral(resourceName: "Unknown"))
           
           restaurantPreviewView=RestaurantPreviewView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 190))
           
           self.view.addSubview(btnMyLocation)
        btnMyLocation.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive=true
           btnMyLocation.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive=true
           btnMyLocation.widthAnchor.constraint(equalToConstant: 50).isActive=true
           btnMyLocation.heightAnchor.constraint(equalTo: btnMyLocation.widthAnchor).isActive=true
       }
       
       let myMapView: GMSMapView = {
           let v=GMSMapView()
           v.translatesAutoresizingMaskIntoConstraints=false
           return v
       }()
       
       let txtFieldSearch: UITextField = {
           let tf=UITextField()
           tf.borderStyle = .roundedRect
           tf.backgroundColor = .white
           tf.layer.borderColor = UIColor.darkGray.cgColor
           tf.placeholder="Search for a location"
           tf.translatesAutoresizingMaskIntoConstraints=false
           return tf
       }()
       
       let btnMyLocation: UIButton = {
           let btn=UIButton()
           btn.backgroundColor = UIColor.white
           btn.setImage(#imageLiteral(resourceName: "my_location"), for: .normal)
           btn.layer.cornerRadius = 25
           btn.clipsToBounds=true
           btn.tintColor = UIColor.gray
           btn.imageView?.tintColor=UIColor.gray
           btn.addTarget(self, action: #selector(btnMyLocationAction), for: .touchUpInside)
           btn.translatesAutoresizingMaskIntoConstraints=false
           return btn
       }()
       
       var restaurantPreviewView: RestaurantPreviewView = {
           let v=RestaurantPreviewView()
           return v
       }()
    


}
extension MapViewController{
    
    func getStatTunisiaMap(coutry: String) {
           let url = "https://coronavirus-monitor.p.rapidapi.com/coronavirus/latest_stat_by_country.php"
              let parameters: [String: String] = ["country": coutry]
               let headers: HTTPHeaders = ["Content-Type":"application/x-www-form-urlencoded",
                                           "x-rapidapi-host": "coronavirus-monitor.p.rapidapi.com",
                                           "X-RapidAPI-Key" : "e97cfa035fmsh2761fac59ec1463p11c314jsn0cdd30264103"
           ]
           AF.request(url,parameters: parameters, headers: headers)
               .responseDecodable(of:LatestStatModel.self) { response in
                   guard let json = String(data: response.data!, encoding: String.Encoding.utf8) else {
                                      print("hh")
                                      return
                                  }
                   let decoder = JSONDecoder()
                   let jsonData = Data(json.utf8)
                   do {
                       let stat = try decoder.decode(LatestStatModel.self, from: jsonData)
                      
                       DispatchQueue.main.async {
                        self.totCases = Int(stat.latest_stat_by_country[0].total_cases)!
                        self.country = stat.country
                       
                       }
       
                   } catch {
                       print(error.localizedDescription)
                   }
           }
       }
}
