//
//  ViewController.swift
//  BritishEnglishGame
//
//  Created by Jerski on 2022/1/10.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    
    @IBOutlet weak var questionNumberLabel: UILabel!
    
    
    @IBOutlet var answerButtons: [UIButton]!
    
    var questions = Question.data
    var index = 0
    var score = 0
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            // 每次打開 APP 會更改題目順序
            questions.shuffle()
            changeContents()
        }
        
        func changeContents() {
            questionLabel.text = questions[index].question
            
            var optionArray = [questions[index].optionA,
                               questions[index].optionB,
                               questions[index].optionC,
                               questions[index].optionD]
            // 更改四個選項的順序
            optionArray.shuffle()
           
            // 設定 button title
            for i in 0...3 {
                // answerButtons[i].titleLabel?.font = UIFont(name: "", size: 36)
                answerButtons[i].setTitle(optionArray[i], for: .normal)
                answerButtons[i].tintColor = .black
            }
            questionNumberLabel.text = "\(index + 1) / 10"
            scoreLabel.text = "\(score)"
        }
        
        func restart() {
                score = 0
                index = 0
                questionNumberLabel.text = "\(index + 1) / 10"
                scoreLabel.text = "0"
                questions.shuffle()
                changeContents()
            }
    
    
    @IBAction func restartButtonAction(_ sender: Any) {
        restart()
    }

    @IBAction func checkAnswer(_ sender: UIButton) {
    
    if sender.currentTitle == questions[index].rightAnswer {
                score += 10
            }
            
            index += 1
           
            if index < 10{
                changeContents()
            } else {
                caculateScore()
            }
        }

    func alert(title: String, message: String, buttonText: String) {
        let alertController = UIAlertController (title: title, message: message, preferredStyle: .alert)
        
        let alertButton = UIAlertAction(title: buttonText, style: .default, handler: {(_)in self.restart() })
        
        let cancelAlertButton = UIAlertAction(title: "cancel", style: .destructive, handler: nil)
        
        alertController.addAction(alertButton)
        alertController.addAction(cancelAlertButton)
        
        self.present(alertController, animated: true, completion: nil)
        }
        
        
    func caculateScore() {
        if score >= 80 {
            alert(title: "Total \(score) points", message: "Brilliant！", buttonText: "Play again！")
        } else if score >= 60 && score < 80 {
            alert(title: "Total \(score) points", message: "Very good！", buttonText: "Play again！")
        } else if score >= 30 && score < 60 {
            alert(title: "Total \(score) points", message: "Keep trying！", buttonText: "Play again！")
        } else {
            alert(title: "Total \(score) points", message: "Don't give up！", buttonText: "Play again！")
            }
        }
        
}




