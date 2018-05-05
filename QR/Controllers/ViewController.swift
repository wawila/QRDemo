//
//  ViewController.swift
//  QR
//
//  Created by David Chavarria on 5/5/18.
//  Copyright © 2018 David Chavarria. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var GenerateButton: UIButton!
    @IBOutlet weak var ReadButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func GenerateAction(_ sender: Any) {
        performSegue(withIdentifier: "mainToGenerator", sender: self)
    }
    
    @IBAction func ReadAction(_ sender: Any) {
        performSegue(withIdentifier: "mainToReader", sender: self)
    }
    
}

