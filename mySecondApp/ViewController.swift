//
//  ViewController.swift
//  mySecondApp
//
//  Created by Ahmet Karamanoğlu on 8.02.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    
    
    var score = 0
    var timer = Timer()
    var hideTimer = Timer()
    var highscore = 0
    var counter = 0
    let myImage = UIImageView()
    var width = 0.00
    var height = 0.00
    override func viewDidLoad() {
        
     
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil {
            highscore = 0
            highscoreLabel.text = "Highscore: \(highscore)"
        }
        if let newHighscore = storedHighScore as? Int {
            highscore = newHighscore
            highscoreLabel.text = "Highscore: \(highscore)"
            
        }
  
        super.viewDidLoad()
        
        //UIImage set.
         width = view.frame.width
         height = view.frame.height
        
        
        myImage.image = UIImage(named: "mario")
        myImage.isUserInteractionEnabled = true
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        myImage.addGestureRecognizer(recognizer)
        view.addSubview(myImage)
        
        counter = 10
        timeLabel.text = "\(counter)"
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hidePic), userInfo: nil, repeats: true)
        
        
    }
    
    @objc func imageTapped() {
        self.score += 1
        self.scoreLabel.text = "Score: \(self.score)"
    }
    
    @objc func hidePic() {
        let randomX = Double.random(in: self.width*0.3..<self.width*0.6)
        let randomY = Double.random(in: self.height*0.4..<self.height*0.8)

        myImage.frame = CGRect(x: randomX, y: randomY, width: 100, height: 100)
    }
    
    @objc func countDown() {
        self.counter -= 1
        self.timeLabel.text = "\(self.counter)"
        
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            if (self.myImage.isHidden == false) {
                self.myImage.isHidden = true
            }
            
            if self.score > self.highscore {
                self.highscore = self.score
                self.highscoreLabel.text = "Highscore: \(self.highscore)"
                UserDefaults.standard.set(self.highscore, forKey: "highscore")
                
            }
            
            let alert = UIAlertController.init(title: "Time's Up", message: "Do you wanna to play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction.init(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction.init(title: "Replay", style: UIAlertAction.Style.default) { UIAlertAction in
                
                self.score = 0
                self.counter = 10
                self.timeLabel.text = "\(self.counter)"
                self.scoreLabel.text = "Score: \(self.score)"
                self.myImage.isHidden = false
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hidePic), userInfo: nil, repeats: true)
                
                
            }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
            
            
            
        }
        
        
    }


}

