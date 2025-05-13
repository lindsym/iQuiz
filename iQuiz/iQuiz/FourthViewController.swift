//
//  FourthViewController.swift
//  iQuiz
//
//  Created by Lindsy M on 5/12/25.
//

import UIKit

class FourthViewController: UIViewController {
    
    var quiz : Quiz? = nil

    @IBOutlet weak var resultDescription: UILabel!
    @IBOutlet weak var score: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if (quiz != nil) {
            let scorePercent : Double = (Double(quiz?.numCorrect ?? 0) / Double(quiz?.questions.count ?? 0))
            if scorePercent < 0.65 {
                resultDescription.text = "failed :("
            } else if scorePercent < 0.75 {
                resultDescription.text = "barely passed :/"
            } else if scorePercent < 1.0 {
                resultDescription.text = "almost perfect!"
            } else {
                resultDescription.text = "perfect!"
            }
            
            score.text = "\(quiz?.numCorrect ?? 0) out of \(quiz?.questions.count ?? 0)"
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
