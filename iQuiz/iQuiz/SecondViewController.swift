//
//  SecondViewController.swift
//  iQuiz
//
//  Created by Lindsy M on 5/12/25.
//

import UIKit

class StringPickerModel : NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    var data : [String] = ["temp"]
  
  private var selectedRow : Int = 0
  var selectedData : String {
    get { return data[selectedRow] }
  }

  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return data.count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return data[row]
  }
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    self.selectedRow = row
  }
}

class SecondViewController: UIViewController, UIPickerViewDelegate {

    @IBOutlet weak var question: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var answerChoices: UIPickerView!
    
    var quiz : Quiz? = nil
    
    
    
    let stringPickerModel : StringPickerModel = StringPickerModel()
    
    
    @IBAction func nextButtonClicked() {
        let selectedRow = answerChoices.selectedRow(inComponent: 0)
        let selected = stringPickerModel.data[selectedRow]
        
        if (selected == quiz?.answers[quiz?.questionNum ?? 0]) {
            quiz?.numCorrect = (quiz?.numCorrect ?? 0) + 1
            quiz?.wasCorrect = true
        } else {
            quiz?.wasCorrect = false
        }
        
        performSegue(withIdentifier: "seg3", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seg3" {
            let destinationVC = segue.destination as? ThirdViewController
            destinationVC?.quiz = quiz
        }
    }


    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        answerChoices.delegate = stringPickerModel
        answerChoices.dataSource = stringPickerModel
        
        if (quiz != nil ) {
            question.text = quiz?.questions[quiz?.questionNum ?? 0]
            stringPickerModel.data = quiz?.choices[quiz?.questionNum ?? 0] ?? ["error"]
            
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
