//
//  DirectoryViewController.swift
//  VirtusaTest
//
//  Created by Apple on 17/03/22.
//

import UIKit

class DirectoryViewController: UIViewController {
    
    @IBOutlet weak var roomsBtn:UIButton!
    
    @IBOutlet weak var colleaguesBtn:UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        roomsBtn.layer.cornerRadius = 4
        roomsBtn.clipsToBounds = true
        colleaguesBtn.layer.cornerRadius = 4
        colleaguesBtn.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    

}
