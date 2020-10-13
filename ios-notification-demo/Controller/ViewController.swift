//
//  ViewController.swift
//  ios-notification-demo
//
//  Created by Mavin on 10/13/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var reminders: [Reminder] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadReminder()
    }
    
    func loadReminder() {
        self.reminders = try! context.fetch(Reminder.fetchRequest())
        self.tableView.reloadData()
    }
    
    
    @IBAction func createReminderPressed(_ sender: Any) {
        let createVc = storyboard?.instantiateViewController(identifier: "CreateVC") as! CreateViewController
        createVc.modalPresentationStyle = .fullScreen
        present(createVc, animated: true, completion: nil)
    }
    
    @IBAction func testPressed(_ sender: Any) {
        
        let content = UNMutableNotificationContent() //Create content for notification
        content.title = "Notification"
        content.body = "Demo Notification"
        content.sound = UNNotificationSound.default
        
        let date = Date().addingTimeInterval(5)
    
        //Create Date Component
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        
        //Create Triger
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        //Schedule notification
        //Create request
        let identifier = "Local Notification"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if error != nil {
                print("Something when wrong")
            }
        }
        
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        reminders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.config(reminder: reminders[indexPath.row])
        return cell
    }
    
    
}

