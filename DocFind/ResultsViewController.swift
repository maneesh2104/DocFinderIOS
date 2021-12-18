//
//  ResultsViewController.swift
//  DocFind
//
//  Created by Maneesh Sakthivel on 12/16/21.
//

import UIKit
import CoreLocation

protocol ResultsVCDelegate: AnyObject {
    func didTapPlace(with cordinate:CLLocationCoordinate2D)
}


class ResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    weak var delegate: ResultsVCDelegate?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = places[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.isHidden = true
        let place = places[indexPath.row]
        GooglePlacesManager.shared.resolveLocation(for: place, completion: {[weak self]
            result in
            switch result{
            case .success(let cordinate):
                DispatchQueue.main.async {
                    self?.delegate?.didTapPlace(with: cordinate)
                }
                break
            case .failure(let error):
                print(error)  
            }
        })
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
           // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    public func update(with place: [Place]){
        tableView.isHidden = false
        self.places = place
        tableView.reloadData()
    }
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private var places: [Place] = []
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
