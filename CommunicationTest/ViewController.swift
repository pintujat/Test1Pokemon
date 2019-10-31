//
//  ViewController.swift
//  CommunicationTest
//
//  Created by Parrot on 2019-10-26.
//  Copyright © 2019 Parrot. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate  {
    
    var pokNameWatch : String = ""
    var pokSelected : String = ""
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var selectlabel: UILabel!
    @IBOutlet weak var sleeppok1: UILabel!
    @IBOutlet weak var hungrypok1: UILabel!
    @IBOutlet weak var sleeppok2: UILabel!
    @IBOutlet weak var hungrypok2: UILabel!
    @IBOutlet weak var healthpok1: UILabel!
    @IBOutlet weak var healthpok2: UILabel!
    
    
    var seconds = 0;
    var startTime = 100;
    var currennttime = 0;
    var timeDuration = 0;
    var timer = Timer();
    var hungerTimerpok1 = Timer();
    var hungerTimerpok2 = Timer();
    var hungerpok1value = 0;
    var hungerpok2value = 0;
    var healthpok1value = 100;
    var healthpok2value = 100;
    
    
    
    @objc func timerAction() {
        if(self.seconds<200){
        self.seconds += 1
        timeLabel.text = "\(self.seconds)"
        }
      }
    
    var pok1 : String = "pok1"
    var pok2 : String = "pok2"
    
    @IBOutlet weak var outputLabel: UITextView!
    @IBOutlet weak var pokemon1: UILabel!
    @IBOutlet weak var pokemon2: UILabel!
    
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any])
    {
        self.pokNameWatch = message["pokename"] as! String
        self.pokSelected = message["pokselected"] as! String
        print(self.pokNameWatch)
        
        if(self.pokSelected == self.pok1){
            self.pokemon1.alpha = 1.0
            self.pokemon1.text = self.pokNameWatch
//        playGame();
        }else{
            self.pokemon2.alpha = 1.0
            self.pokemon2.text = self.pokNameWatch
//        playGame();
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // 1. Check if phone supports WCSessions
        print("view loaded")
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
        else {
            print("Phone does not support WCSession")
        }
        
        self.pokemon1.alpha = 0.0
        self.pokemon2.alpha = 0.0
     
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    @IBAction func pokemonButtonPressed(_ sender: Any) {
        print("You pressed the pokemon button")
//        self.pokNameWatch = "pikachu"
        
        
        self.selectlabel.alpha = 0.0
         
        if (WCSession.default.isReachable) {
            let message = ["pokemon": "pok1"] as [String : Any]
                   WCSession.default.sendMessage(message, replyHandler: nil)
                   print("Message sent to watch")
               }
               else {
                   print("PHONE: Cannot reach watch")
               }
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        hungerTimerpok1 = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(hungerAction1), userInfo: nil, repeats: true)
        hungerTimerpok2 = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(hungerAction), userInfo: nil, repeats: true)
   
    }
    @IBAction func caterpieButtonPressed(_ sender: Any) {
        print("You pressed the caterpie button")
//        self.pokNameWatch = "caterpie"
        self.selectlabel.alpha = 0.0
         timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        hungerTimerpok1 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(hungerAction1), userInfo: nil, repeats: true)
        hungerTimerpok2 = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(hungerAction), userInfo: nil, repeats: true)
        
        if (WCSession.default.isReachable) {
            let message = ["pokemon": "pok2"] as [String : Any]
                   WCSession.default.sendMessage(message, replyHandler: nil)
                   print("Message sent to watch")
               }
               else {
                   print("PHONE: Cannot reach watch")
               }
        
    }

    @objc func hungerAction1() {
      if(self.hungerpok1value<100){
      self.hungerpok1value += 10
      hungrypok1.text = "\(self.hungerpok1value)"
      healthpok1.text = "\(self.healthpok1value)"
        if(self.hungerpok1value > 80){
            self.healthpok1value -= 5
            self.healthpok1.text = "\(self.healthpok1value)"
         }
      }
    }
    @objc func hungerAction() {
      if(self.hungerpok2value<100){
      self.hungerpok2value += 10
      hungrypok2.text = "\(self.hungerpok2value)"
      healthpok2.text = "\(self.healthpok2value)"
        if(self.hungerpok2value > 80){
            self.healthpok2value -= 5
            self.healthpok2.text = "\(self.healthpok2value)"
        }
      }
    }
    
//    public func playGame(){
//
////        self.hungrypok1.text = "\(self.hungerpok1value)"
//        self.healthpok1.text = "\(self.healthpok1value)"
//                   self.healthpok2.text = "\(self.healthpok2value)"
//                   self.hungrypok2.text = "\(self.hungerpok2value)"
//
//    }
   
    
    
}

