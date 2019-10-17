//
//  PlanetsCollectionViewController.swift
//  Planets
//
//  Created by Andrew R Madsen on 8/2/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class PlanetsCollectionViewController: UICollectionViewController {
    
    // MARK: - Properties
    
    let planetController = PlanetController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.observeShouldShowPluto()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.reloadData()
    }
    
    func observeShouldShowPluto() {
        NotificationCenter.default.addObserver(self, selector: #selector(refreshViews), name: .switchWasFlipped, object: nil)
    }
    
    // the @objc marjs this method was executable by the obj-C runtime, in other words, compatable with obj-C
    
    // you are not required to have the `notification` argument. It is however necessary in orger to get the `useerInfo` dictionary if you post one.
    @objc func refreshViews() {
        collectionView?.reloadData()
    }
    
    @IBAction func unwindToPlanetsCollectionViewController(_ sender: UIStoryboardSegue) {
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return planetController.planets.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlanetCell", for: indexPath) as! PlanetCollectionViewCell
        
        let planet = planetController.planets[indexPath.item]
        cell.imageView.image = planet.image
        cell.textLabel.text = planet.name
        
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowSettings" {
            let detailVC = segue.destination
            let ppc = detailVC.popoverPresentationController
            if let button = sender as? UIButton {
                ppc?.sourceView = button
                ppc?.sourceRect = button.bounds
                ppc?.backgroundColor = .black
            }
            ppc?.delegate = self
        }
        
        if segue.identifier == "ShowPlanetDetail" {
            guard let indexPath = collectionView?.indexPathsForSelectedItems?.first else { return }
            let detailVC = segue.destination as! PlanetDetailViewController
            detailVC.planet = planetController.planets[indexPath.row]
        }
    }
}

extension PlanetsCollectionViewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
