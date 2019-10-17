//
//  PlanetDetailViewController.swift
//  Planets
//
//  Created by Andrew R Madsen on 9/20/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class PlanetDetailViewController: UIViewController {
    
    var planet: Planet? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    private func updateViews() {
        guard let planet = planet, isViewLoaded else {
            imageView?.image = nil
            label?.text = nil
            return
        }
        
        imageView.image = planet.image
        label.text = planet.name
    }
    
    override func encodeRestorableState(with coder: NSCoder) {
        defer { super.encodeRestorableState(with: coder) }
        
        //planet -> Data -> Encode in coder
        var planetData: Data?
        
        do {
            planetData = try PropertyListEncoder().encode(planet)
        } catch {
            NSLog("Error encoding planet:\(error)")
        }
        
        guard let planet = planetData else { return }
        coder.encode(planet, forKey: "planetData")
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        defer { super.decodeRestorableState(with: coder) }
        
        // Data -> PLanet -> Put in var planet
        
        guard let planetData = coder.decodeObject(forKey: "planetData") as? Data else { return }
        
        self.planet = try? PropertyListDecoder().decode(Planet.self, from: planetData)
    }
}
