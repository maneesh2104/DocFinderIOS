//
//  GooglePlacesManager.swift
//  DocFind
//
//  Created by Maneesh Sakthivel on 12/16/21.
//

import Foundation
import GooglePlaces
import CoreLocation

struct Place {
    let name: String
    let id: String
}


final class GooglePlacesManager{
     static let shared = GooglePlacesManager()
    
    private let client = GMSPlacesClient.shared()
    
    private init() {}
    
    enum PlacesError: Error{
        case failedToFetch
    }
    
    public func resolveLocation(for place: Place, completion: @escaping (Result<CLLocationCoordinate2D, Error>) -> Void){
        client.fetchPlace(fromPlaceID: place.id, placeFields: .coordinate, sessionToken: nil, callback: { googlePlace, error in
            
            guard let googlePlace = googlePlace, error == nil else {
                completion(.failure(PlacesError.failedToFetch))
                return
            }
            
            let cordinate = CLLocationCoordinate2D(latitude: googlePlace.coordinate.latitude, longitude: googlePlace.coordinate.longitude)
            
            completion(.success(cordinate))
            
            
        })
    }
    
    
    public func findPlaces(query: String, completion: @escaping (Result<[Place], Error>) -> Void){
        
        let filter = GMSAutocompleteFilter()
        filter.type = .geocode
        client.findAutocompletePredictions(fromQuery: query, filter: filter, sessionToken: nil, callback: {
            (results, error) in
            guard let results = results, error == nil else{
                completion(.failure(PlacesError.failedToFetch))
                return
            }
            let places = results.compactMap({
                Place(name: $0.attributedFullText.string, id: $0.placeID)
            })
            
            completion(.success(places))
        })
    }
    
    
}
