//
//  BeerVC.swift
//  TinyApp-GetEmCold!
//
//  Created by C4Q on 2/23/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import FirebaseAuth

class BeerVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var user: UserProfile!
    
    var beers = [Beer](){
        didSet{
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.green
        tableView.delegate = self
        tableView.dataSource = self
        loadBeers()
    }
    
    
    func loadBeers(){
        let loadBeersFromOnline: ([Beer]) -> Void = {(onlineBeers: [Beer]) in
            self.beers = onlineBeers
            print("\(self.beers[0].name) is set")
            
            //Add beers to firebase: THIS WORKS if manually added
            //HOW TO ADD THE BEER OBJECTS AS THEY COME FROM THE HTTP CALL?
            FirebaseBeerManager.manager.addBeerToFirebase(beerUID: "1", id: 2, name: "beerrrr", tagline: "cold going down", first_brewed: "1987", description: "yum", image_url: "", abv: 10)
        }
        BeerAPIClient.manager.getBeersNoURLString(loadBeersFromOnline,
                                                  errorHandler: {print($0)})
    }
    
    @IBAction func signOutAction(_ sender: Any) {
        //sign out current user
        AuthUserManager.manager.logout()
        dismiss(animated: true, completion: nil)
        print("\(Auth.auth().currentUser) is signed Out")
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailBeerVC{
            //grabbing the selected row in the tableview
            let selectedRow = self.tableView.indexPathForSelectedRow!.row
            //grabbing the object in that row
            let selectedBeer = self.beers[selectedRow]
            //setting the instance of object in DVC to the object in this VC
            destination.thisBeer = selectedBeer
        }
    }
}

extension BeerVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beers.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "beerCell", for: indexPath)
        let beer = beers[indexPath.row]
        
        //properties of custom cell
        cell.textLabel?.text = "\(beer.name)"
        return cell
    }
}

extension BeerVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(beers[0].name) is the beer in this row")
        //call configure DetailViewController func to prepare sending beer object over
        //present the detail VC
    }
}

