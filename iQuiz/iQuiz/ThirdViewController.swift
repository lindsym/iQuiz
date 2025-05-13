//
//  ThirdViewController.swift
//  iQuiz
//
//  Created by Lindsy M on 5/12/25.
//

import UIKit

class ThirdViewController: UIViewController {
    var quiz : Quiz? = nil

    @IBOutlet weak var questionHere: UILabel!
    @IBOutlet weak var correctAnswer: UILabel!
    @IBOutlet weak var wrongOrRight: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBAction func nextAction() {
        quiz?.questionNum = (quiz?.questionNum ?? 0) + 1
        print(quiz?.questionNum)
        print("THIS IS QUIZ AT THREE", quiz?.questions)
        if (quiz?.questionNum != (quiz?.questions.count ?? 0)) {
            performSegue(withIdentifier: "seg4", sender: self)
        } else {
            performSegue(withIdentifier: "seg6", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "seg4" {
            let destinationVC = segue.destination as? SecondViewController
            destinationVC?.quiz = quiz
        }
        
        if segue.identifier == "seg6" {
            let destinationVC = segue.destination as? FourthViewController
            destinationVC?.quiz = quiz
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if (quiz != nil) {
            questionHere.text = quiz?.questions[quiz?.questionNum ?? 0]
            correctAnswer.text = quiz?.answers[quiz?.questionNum ?? 0]
            
           var correction = Bool(quiz?.wasCorrect ?? true)
            if (correction == true) {
                wrongOrRight.text = "correct!"
            } else {
                wrongOrRight.text = "wrong!"

            }
        
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
      }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
