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

class RequestOrderMapViewController: UIViewController,GMSMapViewDelegate  {
   
    @IBOutlet weak var searchBarView: UIView!
    private let locationManager = CLLocationManager()
    var  destinationMarker = GMSMarker()
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var adressView: UIView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var gpsBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        gpsBtn.layer.cornerRadius = 8
        nextBtn.layer.cornerRadius = 8
        adressView.layer.cornerRadius = 8
        adressView.layer.borderWidth = 1
        adressView.layer.borderColor = UIColor.lightGray.cgColor
        searchBarView.layer.borderColor = UIColor.lightGray.cgColor
        searchBarView.layer.borderWidth = 1
        searchBarView.layer.cornerRadius = 8
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        mapView.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.autocompleteClicked(_:)))
        searchBarView.addGestureRecognizer(tap)
        locationManager.requestWhenInUseAuthorization()
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
    @objc func autocompleteClicked(_ sender: UIButton) {
      let autocompleteController = GMSAutocompleteViewController()
      autocompleteController.delegate = self

      // Specify the place data types to return.
      let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
                                                    UInt(GMSPlaceField.placeID.rawValue))
      autocompleteController.placeFields = fields

      // Specify a filter.
      let filter = GMSAutocompleteFilter()
      filter.type = .address
      autocompleteController.autocompleteFilter = filter

      // Display the autocomplete view controller.
      present(autocompleteController, animated: true, completion: nil)
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
    mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 10.0, bearing: 0, viewingAngle: 0)

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
