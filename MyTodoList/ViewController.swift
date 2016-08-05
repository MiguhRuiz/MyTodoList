//
//  ViewController.swift
//  MyTodoList
//
//  Created by Miguh Ruiz on 31/7/16.
//  Copyright © 2016 Miguh Ruiz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITextFieldDelegate {
    
    let todoList = TodoList()
    
    
    var selectedItem: TodoItem?
    
    static let MAX_TEXT_SIZE = 50
    
    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addButtonPressed(sender: UIButton) {
        print("Agregado un elemento a la lista: \(itemTextField.text)")
        let todoItem = TodoItem()
        todoItem.todo = itemTextField.text!
        todoList.addItem(todoItem)
        tableView.reloadData()
        self.itemTextField.text = nil
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showItem", sender: self)
        self.selectedItem = self.todoList.getItem(indexPath.row)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let DetailViewController = segue.destinationViewController as? DetailViewController {
            DetailViewController.item = self.selectedItem
            DetailViewController.todoList = self.todoList
        }
    }
    
    //MARK: Método del text field delegate
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if let tareaString = textField.text as? NSString {
            let updatedString = tareaString.stringByReplacingCharactersInRange(range, withString: string)
            return updatedString.characters.count <= ViewController.MAX_TEXT_SIZE
        }
        else {
            return true
        }
}

}

