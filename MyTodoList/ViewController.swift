//
//  ViewController.swift
//  MyTodoList
//
//  Created by Miguh Ruiz on 31/7/16.
//  Copyright © 2016 Miguh Ruiz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {
    
    let todoList = TodoList()
    
    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addButtonPressed(sender: UIButton) {
        print("Agregado un elemento a la lista: \(itemTextField.text)")
        todoList.addItem(itemTextField.text!)
        tableView.reloadData()
        self.itemTextField?.resignFirstResponder()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = todoList
        tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Métodos del table view delegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.itemTextField?.resignFirstResponder()
        
        
    }


}

