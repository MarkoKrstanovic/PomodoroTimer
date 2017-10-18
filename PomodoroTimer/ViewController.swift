//
//  ViewController.swift
//  PomodoroTimer
//
//  Created by Martin Berger on 10/13/17.
//  Copyright © 2017 Martin Berger. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var timer = Timer()
    var timeMin = 25
    var timeSec = 0
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var play: UIBarButtonItem!
    @IBOutlet weak var minusMin: UIBarButtonItem!
    @IBOutlet weak var timeIsUp: UILabel!
    @IBOutlet weak var minusSec: UIBarButtonItem!
    @IBOutlet weak var plusSec: UIBarButtonItem!
    @IBOutlet weak var plusMin: UIBarButtonItem!
    @IBOutlet weak var stop: UIBarButtonItem!
    @IBOutlet weak var secTF: UITextField!
    @IBOutlet weak var minTF: UITextField!

    @IBAction func setTimer(_ sender: Any) {
        
        if let minutesString = minTF.text {
            if let minutes = Int(minutesString) {
                if timeMin == 0 && timeSec == 0 {
                    play.isEnabled = true
                }
                if minutes <= 99 {
                timeMin = minutes
                timeLabel.text = "\(timeMin) : \(timeSec)"
                }
            }
        }
        if let secondsString = secTF.text {
            if let seconds = Int(secondsString) {
                if timeMin == 0 && timeSec == 0 {
                    play.isEnabled = true
                }
                if seconds <= 59 {
                timeSec = seconds
                timeLabel.text = "\(timeMin) : \(timeSec)"
                }
            }
        }
       
        timeIsUp.text = " "
    }
    @objc func startTicking() {
        if timeMin == 0 && timeSec == 1 {
            timer.invalidate()
            timeIsUp.text = "Time is up!"
            play.isEnabled = false
            
        }
        if timeSec < 1 {
            timeMin -= 1
            timeSec = 59
        } else {
        timeSec -= 1
        }
        if timeMin == 0 && timeSec == 0 {
            stop.isEnabled = false
        }
        
        timeLabel.text = "\(timeMin) : \(timeSec)"
    }
    
    @IBAction func reset(_ sender: Any) {
        timer.invalidate()
        timeSec = 0
        timeMin = 25
        timeLabel.text = "25:00"
        timeIsUp.text = " "
        play.isEnabled = true
        stop.isEnabled = true
       
    }
    
    @IBAction func play(_ sender: Any) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.startTicking), userInfo: nil, repeats: true)
        
        play.isEnabled = false
        stop.isEnabled = true
    }
    
    @IBAction func pause(_ sender: Any) {
       
        timer.invalidate()
        play.isEnabled = true
    }
    
    
    @IBAction func minusSec(_ sender: Any) {
        if timeSec > 15 {
            timeSec -= 15
        }  else if timeMin == 0 && timeSec <= 15 {
            
        } else if timeSec < 15 {
            let overTime = 60 - (15 - timeSec)
            timeSec = overTime
            if timeMin >= 1 {
                timeMin -= 1
            }
        }  else if timeSec == 15 {
            timeSec = 0
        }
           timeLabel.text = "\(timeMin) : \(timeSec)"
    }
    
    @IBAction func minusMin(_ sender: Any) {
        if timeMin == 1 && timeSec >= 1 || timeMin > 1 {
        timeMin -= 1
        }
        timeLabel.text = "\(timeMin) : \(timeSec)"
    }
 
    @IBAction func plusSec(_ sender: Any) {
        if timeMin <= 99 && timeSec <= 45 {
            
            if timeSec < 45 {
                timeSec += 15
                timeLabel.text = "\(timeMin) : \(timeSec)"
            } else {
                let overTime = 15 - (60 - timeSec)
                timeMin += 1
                timeSec = overTime
                timeLabel.text = "\(timeMin) : \(timeSec)"
            }
            timeIsUp.text = ""
            if timeMin == 0 && timeSec == 15 {
                play.isEnabled = true
            }
        }
    }
    @IBAction func plusMin(_ sender: Any) {
        if timeMin < 99 {
        timeMin += 1
        timeLabel.text = "\(timeMin) : \(timeSec)"
        timeIsUp.text = ""
        if timeMin == 1 && timeSec == 0 {
            play.isEnabled = true
        }
        }
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

