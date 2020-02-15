//
//  ViewController.swift
//  Flashcards
//
//  Created by Abdul Abdul on 2/14/20.
//  Copyright © 2020 Abdul Abdul. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        
        frontLabel.isHidden = true
    }
    
}

