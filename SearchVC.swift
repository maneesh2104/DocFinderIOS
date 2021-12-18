//
//  SearchVC.swift
//  DocFind
//
//  Created by Maneesh Sakthivel on 12/15/21.
//

import UIKit
import MapKit
import MaterialComponents

class SearchVC: UIViewController, UISearchResultsUpdating, ResultsVCDelegate {
    func didTapPlace(with cordinate: CLLocationCoordinate2D) {
        searchVC.searchBar.resignFirstResponder()
        let pin = MKPointAnnotation()
        pin.coordinate = cordinate
        pin.title = "DR Pooja"
        pin.subtitle = "32 Boylston Street, Boston"
        mapView.addAnnotation(pin)
        
        //42.373467919589324, -71.11364791243348
        let newCord = CLLocationCoordinate2D(latitude: 42.373467919589324, longitude: -71.11364791243348)
        let new_pin = MKPointAnnotation()
        new_pin.coordinate = newCord
        new_pin.title = "DR Jack"
        new_pin.subtitle = "2499 Woodlawn Street, Cambridge"
        
        //42.41831314773211, -71.06245870608187
        let newCord1 = CLLocationCoordinate2D(latitude: 42.41831314773211, longitude: -71.06245870608187)
        let new_pin1 = MKPointAnnotation()
        new_pin1.coordinate = newCord1
        new_pin1.title = "DR Ram"
        new_pin1.subtitle = "32 Washnington Street, Malden"
        
        //42.22539508180443, -71.04159422476113
        let newCord2 = CLLocationCoordinate2D(latitude:  42.234776252992795, longitude: -70.97700866826099)
        let new_pin2 = MKPointAnnotation()
        new_pin2.coordinate = newCord2
        new_pin2.title = "DR Pal"
        new_pin2.subtitle = "32 Chase Street, Quincy"
        
        //41.98464585209091, -70.97165526452194
        let newCord3 = CLLocationCoordinate2D(latitude: 42.33699074697154, longitude: -71.21504544441531)
        let new_pin3 = MKPointAnnotation()
        new_pin3.coordinate = newCord3
        new_pin3.title = "DR Brooks"
        new_pin3.subtitle = "32 Chase Street, Newton"
        
        
        
        
        
        mapView.addAnnotations([pin, new_pin, new_pin1, new_pin2, new_pin3])
        mapView.setRegion(MKCoordinateRegion(center: cordinate, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)), animated: true)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let query = searchController.searchBar.text, !query.trimmingCharacters(in: .whitespaces).isEmpty, let resultsVC = searchController.searchResultsController as? ResultsViewController else {
            return
        }
        
        resultsVC.delegate = self
        
        GooglePlacesManager.shared.findPlaces(query: query, completion: { result in
            switch result{
            case.success(let places):
                DispatchQueue.main.async {
                    resultsVC.update(with: places)
                }
                print(places)
            case .failure(let error):
                print(error)
            }
            
        })
    }
    let contButton = MDCButton()
    let mapView = MKMapView()
    
    let searchVC = UISearchController(searchResultsController: ResultsViewController())
    
    override func viewDidLoad() {
        print("Search Loaded")
        title = "Search"
        view.addSubview(mapView)
        view.addSubview(contButton)
        searchVC.searchResultsUpdater = self
        contButton.setTitle("Continue", for: .normal)
        contButton.addTarget(self, action: #selector(contPessed), for: .touchDown)
        navigationItem.searchController = searchVC
    }
    
    @objc
    func contPessed(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "DocResultsTableViewController") as! DocResultsTableViewController
        
        self.navigationController?.pushViewController(resultViewController, animated: true)
        print("I am here")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapView.frame = view.bounds
        contButton.frame = CGRect(x: 0, y: mapView.bounds.height - 60, width: mapView.bounds.width, height: 40)
        contButton.setTitle("Continue", for: .normal)
        custBtn(button: contButton)
    }
    
    
    
    
    
    
    
    
}
