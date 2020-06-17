//
//  WeatherViewController.swift
//  AnAmericanDream
//
//  Created by Hugues Fils Caparos on 07/02/2020.
//  Copyright © 2020 Hugues Fils Caparos. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate {
    
    // MARK: - Properties
    
    @IBOutlet weak var defaultLocName: UILabel!
    @IBOutlet weak var defaultLocMain: UILabel!
    @IBOutlet weak var defaultLocTemp: UILabel!
    @IBOutlet weak var defaultLocImageView: UIImageView!
    @IBOutlet weak var currentLocName: UILabel!
    @IBOutlet weak var currentLocMain: UILabel!
    @IBOutlet weak var currentLocTemp: UILabel!
    @IBOutlet weak var currentLocImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let locationManager = CLLocationManager()
    private var currentLocation: CLLocation!
    
    let service = WeatherService()
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else if CLLocationManager.authorizationStatus() == .denied {
            print("OUPS")
        } else {
            locationManager.requestLocation()
        }
        customLayout()
        getWeatherNewYork(nil)
    }
    
    // MARK: - Functions
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.getCurrentLocWeather(nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("authorized")
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            manager.requestLocation()
        }
    }
    
    func getWeatherNewYork(_ sender: Any?) {
        service.getWeather(defaultLocation: "New York", latitude: nil, longitude: nil) { (response, error) in
            // you can set the default location here and line 81
            guard error == nil else {
                return
            }
            guard
                let iconId = response?.weather.first?.icon,
                let main = response?.weather.first?.main,
                let temp = response?.main.temp
                else {
                    return
            }
            self.defaultLocName.text = "New York"
            self.defaultLocImageView.loadImageFromURL(url: "http://openweathermap.org/img/wn/\(iconId)@2x.png")
            self.defaultLocMain.text = main
            self.defaultLocTemp.text = "\(temp)° c"
            
        }
    }
    
    func getCurrentLocWeather(_ sender: Any?) {
        guard let exposedLocation = self.locationManager.location else {
            print("*** Error in \(#function): exposedLocation is nil")
            return
        }
        self.locationManager.getPlace(for: exposedLocation) { placemark in
            guard let placemark = placemark else { return }
            
            var output = ""
            if let town = placemark.locality {
                output = "\(town)"
            }
            self.currentLocName.text = output
        }
        service.getWeather(defaultLocation: nil, latitude: exposedLocation.coordinate.latitude,
            longitude: exposedLocation.coordinate.longitude) { (response, error) in
            defer {
               self.activityIndicator.isHidden = true
            }
            guard error == nil else {
                return
            }
            guard
                let iconId = response?.weather.first?.icon,
                let main = response?.weather.first?.main,
                let temp = response?.main.temp
                else {
                    return
            }
            self.currentLocImageView.loadImageFromURL(url: "http://openweathermap.org/img/wn/\(iconId)@2x.png")
            self.currentLocMain.text = main
            self.currentLocTemp.text = "\(temp)° c"
        }
    }
    
    private func customLayout() {
        defaultLocName.customLocName()
        currentLocName.customLocName()
        defaultLocTemp.customTemp()
        defaultLocMain.customMain()
        currentLocTemp.customTemp()
        currentLocMain.customMain()
    }
}

// MARK: - Get Placemark

extension CLLocationManager {
    
    func getPlace(for location: CLLocation,
                  completion: @escaping (CLPlacemark?) -> Void) {
        
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            guard error == nil else {
                print("*** Error in \(#function): \(error!.localizedDescription)")
                completion(nil)
                return
            }
            guard let placemark = placemarks?[0] else {
                print("*** Error in \(#function): placemark is nil")
                completion(nil)
                return
            }
            completion(placemark)
        }
    }
}
