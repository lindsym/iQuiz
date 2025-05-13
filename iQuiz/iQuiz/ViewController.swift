//
//  ViewController.swift
//  iQuiz
//
//  Created by Lindsy M on 5/3/25.
//

import UIKit

class Quiz {
    var questions : [String]
    var choices: [[String]]
    var answers: [String]
    
    var questionNum = 0
    var numCorrect = 0
    var wasCorrect = false
    
    
    init(questions : [String], choices: [[String]], answers: [String]) {
        self.questions = questions
        self.choices = choices
        self.answers = answers
    }
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var mathQuiz = Quiz(questions: ["Math 4+4", "Math 3+3", "Math 2+2"], choices: [["8", "6", "4"], ["8", "6", "4"], ["8", "6", "4"]], answers: ["8", "6", "4"])
    var marvelQuiz = Quiz(questions: ["Marvel choose 1", "Marvel choose 2", "Marvel choose 3", "Marvel choose 4"], choices: [["1", "2", "3", "4"],  ["1", "2", "3", "4"], ["1", "2", "3", "4"], ["1", "2", "3", "4"]], answers: ["1", "2", "3", "4"])
    var scienceQuiz = Quiz(questions: ["Science choose 3", "Science choose 2"], choices: [["3", "2"],  ["3", "2"]], answers: ["3", "2"])

    
    @IBOutlet weak var settings: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    
    struct QuizCell {
        let title: String
        let imageName: String
        let desc : String
    }
    
    let data : [QuizCell] = [
        QuizCell(title: "Math", imageName: "math", desc: "includes math from k-5"),
        QuizCell(title: "Marvel Super Heroes", imageName: "marvel", desc: "do you know marvel?"),
        QuizCell(title: "Science", imageName: "science", desc: "science quiz not on chemistry")
    ]
    
    
    @IBAction func pressedSettings (_ sender: UIBarButtonItem) {
        settingsAlert()
    }
    
    func settingsAlert () {
        let alert = UIAlertController(title: "Settings go here", message: "Settings go here", preferredStyle: .alert)
        alert.addAction((UIAlertAction(title: "OK", style: .default
        )))

        self.present(alert, animated: true, completion: {
          NSLog("The completion handler fired")
        })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "seg1", sender:self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seg1" {
            if ((tableView.indexPathForSelectedRow?.row) == 0) {
                let destinationVC = segue.destination as? SecondViewController
                destinationVC?.quiz = mathQuiz
            }
             else if ((tableView.indexPathForSelectedRow?.row) == 1) {
                let destinationVC = segue.destination as? SecondViewController
                destinationVC?.quiz = marvelQuiz
            }
            else if ((tableView.indexPathForSelectedRow?.row) == 2) {
                let destinationVC = segue.destination as? SecondViewController
                destinationVC?.quiz = scienceQuiz
            }

        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let quiz = data[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.title.text = quiz.title
        cell.iconViewImage.image = UIImage(named: quiz.imageName)
        cell.describe.text = quiz.desc
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    

}


