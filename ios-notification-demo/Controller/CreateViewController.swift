//
//  CreateViewController.swift
//  ios-notification-demo
//
//  Created by Mavin on 10/13/20.
//

import UIKit

class CreateViewController: UIViewController {
    
    @IBOutlet weak var pickerView: UIDatePicker!
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var contentText: UITextField!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func goBackButtonPress(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func savePressed(_ sender: Any) {
        let reminder = Reminder(context: context)
        reminder.title = titleText.text
        reminder.content = contentText.text
        reminder.identifier = "LocalNotification"
        reminder.date = pickerView.date
        
        self.requestNotification()
        
        try? context.save()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func requestNotification() {
        let content = UNMutableNotificationContent()
        content.title = titleText.text ?? "No Title"
        content.body = contentText.text ?? "No Content"
        content.sound = UNNotificationSound.default
        content.badge = 1
        
        let date = pickerView.date
        //Create Date Component
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        //Create Triger
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        //Schedule notification
        //Create request
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateString = formatter.string(from: pickerView.date)
        print("\(dateString)\(Int.random(in: 1...10))")
        
        let identifier = "\(dateString)\(Int.random(in: 1...10))"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if error != nil {
                print("Something when wrong")
            }
        }
        
    }
    
}
