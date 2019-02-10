//
//  ViewController.swift
//  local Notification
//
//  Created by Mac on 10/02/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController ,UNUserNotificationCenterDelegate{

    
    @IBOutlet weak var lblnotification: UILabel!
    var lbl = ""
    
    @IBOutlet weak var lblcnt: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().delegate = self
        notification()
        label()
        startTimer()
    }
    
// we get notification when app is in running condition
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.sound,.badge])
    }
    
  func notification()
  {
    let center = UNUserNotificationCenter.current()
    center.requestAuthorization(options: [.alert,.badge,.sound]) { (Allowed, error) in
        if error != nil
        {
            print("Not Allowed")
        }
        else
        {
            print("Allowed")
        }
    }
    let date = Date().addingTimeInterval(10)

    let dateComponent = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
    print("\(dateComponent)")
    print("\(date)")
   
    
// Notification Content
    
    let content = UNMutableNotificationContent()
    content.title = "Wake Up"
    content.subtitle = "Swapnil"
    content.body = "\(date)"
    content.sound = UNNotificationSound.default()
    lbl.append("\(date)")
    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)

    
//Create request
    
    let uuidString = UUID().uuidString
    let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        center.add(request) { (error) in
        //print("error")
    }
   
    }
    func label() {
        var start = true
        let deadlineTime = DispatchTime.now() + .seconds(10)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: {
            self.lblnotification.text = self.lbl
        })
        
    
    }
    
    // Timer Countdown
    var timer: Timer?
    var totalTime = 60
    
    private func startTimer() {
        self.totalTime = 10
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        print(self.totalTime)
        lblcnt.text = String(totalTime) // will show timer
        if totalTime != 0 {
            totalTime -= 1  // decrease counter timer
        } else {
            if let timer = self.timer {
                timer.invalidate()
                self.timer = nil
            }
        }
    }
}

