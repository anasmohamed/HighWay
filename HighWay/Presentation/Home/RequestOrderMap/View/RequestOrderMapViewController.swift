//
//  RequestOrderMapViewController.swift
//  HighWay
//
//  Created by no one on 11/04/2021.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation

class RequestOrderMapViewController: UIViewController,GMSMapViewDelegate,UISearchBarDelegate{
   
    @IBOutlet weak var searchBarView: UIView!
    private let locationManager = CLLocationManager()
    var  destinationMarker = GMSMarker()
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var adressView: UIView!
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var gpsBtn: UIButton!
    
    var countryLongitude = 0.0
    var countryLatitude = 0.0
    let requestOrderMapViewModel = RequestOrderMapViewModel()
    var timer : Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        gpsBtn.layer.cornerRadius = 8
        nextBtn.layer.cornerRadius = 8
        adressView.layer.cornerRadius = 8
        adressView.layer.borderWidth = 1
        adressView.layer.borderColor = UIColor.lightGray.cgColor
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        mapView.delegate = self
        setupBackButton()
        bindData()
        searchBar.delegate = self

//        searchBarView.addGestureRecognizer(tap)
//        self.navigationItem.title = "Pickup Location"

        locationManager.requestWhenInUseAuthorization()
    }
    func setupBackButton() {
        let leftBackBtn = UIButton(type: .system)
        leftBackBtn.setImage(UIImage(named: "left-arrow"), for: .normal)
        leftBackBtn.sizeToFit()
        leftBackBtn.addTarget(self, action: #selector(self.navigateToMainViewController), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBackBtn);
        navigationController?.navigationBar.tintColor = UIColor.init(red: 68/255, green: 68/255, blue: 68/255, alpha: 1.0)
    }
    @objc func navigateToMainViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func gpsBtnDidTapped(_ sender: Any) {
        mapView.settings.myLocationButton = true

    }
    
    @IBAction func nextBtnDidTapped(_ sender: Any) {
    }
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        destinationMarker.position = position.target
        destinationMarker.map = mapView
        reverseGeocodeCoordinate(position.target)
        print(position.target.latitude)
    }
    // Present the Autocomplete view controller when the button is pressed.
    func bindData() {
        requestOrderMapViewModel.countryGeolocation.bind { [self] in
            
            self.countryLatitude = $0?.latitude ?? 0.0
            self.countryLongitude = $0?.longitude ?? 0.0
            mapView.camera = GMSCameraPosition(latitude: countryLatitude, longitude: countryLongitude, zoom: 15.0)
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude:countryLongitude, longitude:countryLongitude)
            marker.map = mapView
        }
       
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

print("anaddidchange")
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(output), userInfo: searchText, repeats: false)
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("anasendedit")
    }
    @objc func output(){
        print("hello")
        if timer?.userInfo != nil {
            requestOrderMapViewModel.setCounryWith(countryName: searchBar.text ?? "")
            requestOrderMapViewModel.fetchData()
        }
        timer?.invalidate()
    }
}
extension RequestOrderMapViewController: CLLocationManagerDelegate {
  // 2
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {     // Needed for request
          print("Some error \(error)")
      }
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    // 3
    guard status == .authorizedWhenInUse else {
      return
    }
    // 4
    locationManager.startUpdatingLocation()
      
    //5
    mapView.isMyLocationEnabled = true
    mapView.settings.myLocationButton = true
  }
    
    // Camera change Position this methods will call every time
   
  // 6
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.first else {
      return
    }
      
    // 7
    print("location\(location.coordinate.latitude)")
    mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15.0, bearing: 0, viewingAngle: 0)

    // 8
    locationManager.stopUpdatingLocation()
  }
    private func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) {
        
      // 1
      let geocoder = GMSGeocoder()
        
      // 2
      geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
        guard let address = response?.firstResult(), let lines = address.lines else {
          return
        }
          
        // 3
        self.addressLbl.text = lines.joined(separator: "\n")
        print(self.addressLbl.text?.contains("Bahrain"))
        // 4
        UIView.animate(withDuration: 0.25) {
          self.view.layoutIfNeeded()
        }
      }
    }
}

extension RequestOrderMapViewController: GMSAutocompleteViewControllerDelegate {

  // Handle the user's selection.
  func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
    print("Place name: \(place.name)")
    print("Place ID: \(place.placeID)")
    print("Place attributions: \(place.attributions)")
    dismiss(animated: true, completion: nil)
  }

  func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
    // TODO: handle the error.
    print("Error: ", error.localizedDescription)
  }

  // User canceled the operation.
  func wasCancelled(_ viewController: GMSAutocompleteViewController) {
    dismiss(animated: true, completion: nil)
  }

  // Turn the network activity indicator on and off again.
  func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
  }

  func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = false
  }

}
