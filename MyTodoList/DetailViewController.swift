//
//  DetailViewController.swift
//  MyTodoList
//
//  Created by Miguh Ruiz on 5/8/16.
//  Copyright © 2016 Miguh Ruiz. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var item: TodoItem?
    
    var todoList: TodoList?
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBAction func addNotification(sender: AnyObject) {
        if let dateString = self.dateLabel.text {
            if let date = parseDate(dateString) {
                self.item?.dueDate = date
                self.todoList!.saveItems()
                scheduleNotification(self.item!.todo!, date: date)
                self.navigationController?.popViewControllerAnimated(true)
            }
        }
    }

    @IBAction func addImage(sender: UIBarButtonItem) {
        let photosPicker = UIImagePickerController()
        photosPicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        photosPicker.delegate = self
        //      photosPicker.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(photosPicker, animated: true, completion: nil)
    }
    
    func scheduleNotification(message: String, date: NSDate) {
        let localNotification = UILocalNotification()
        localNotification.fireDate = date
        localNotification.timeZone = NSTimeZone.defaultTimeZone()
        localNotification.alertBody = message
        localNotification.alertTitle = "Tienes pendiente..."
        localNotification.applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + 1;
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }
    
    @IBAction func dateSelected(sender: UIDatePicker) {
        print("Fecha seleccionada \(sender.date)")
        self.dateLabel.text = formatDate(sender.date)
        self.datePicker.hidden = true
        toggleDatePicker()
    }
    
    func formatDate(date: NSDate) -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        return formatter.stringFromDate(date)
    }
    
    func parseDate(string: String) -> NSDate? {
        let parser = NSDateFormatter()
        parser.dateFormat = "dd/MM/yyyy HH:mm"
        return parser.dateFromString(string)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(item)")
        showItem()
        let tapGestureRecogniser = UITapGestureRecognizer()
        tapGestureRecogniser.numberOfTapsRequired = 1
        tapGestureRecogniser.numberOfTouchesRequired = 1
        tapGestureRecogniser.addTarget(self, action: "toggleDatePicker")
        self.dateLabel.addGestureRecognizer(tapGestureRecogniser)
        self.dateLabel.userInteractionEnabled = true
    }
    
    func showItem() {
        self.descriptionLabel.text = item?.todo
        if let date = item?.dueDate {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "dd/MM/yyyy HH:mm"
            self.dateLabel.text = formatter.stringFromDate(date)
        }
        if let img = item?.image {
            self.imageView.image = img
        }
    }
    
    func toggleDatePicker() {
        self.imageView.hidden = !self.imageView.hidden
        self.datePicker.hidden = !self.datePicker.hidden
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Image Picker Controller Methods
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.item?.image = image
            self.todoList?.saveItems()
            self.imageView.image = image
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
