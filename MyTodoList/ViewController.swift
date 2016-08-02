//
//  ViewController.swift
//  MyTodoList
//
//  Created by Miguh Ruiz on 31/7/16.
//  Copyright © 2016 Miguh Ruiz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addButtonPressed(sender: UIButton) {
        print("Agregado un elemento a la lista: \(itemTextField.text)")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

