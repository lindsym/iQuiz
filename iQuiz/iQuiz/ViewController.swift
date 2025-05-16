//
//  ViewController.swift
//  iQuiz
//
//  Created by Lindsy M on 5/3/25.
//

import UIKit

class QuizSession {
    static var globalUrl: String = "https://tednewardsandbox.site44.com/questions.json"
}

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
    
    
    var mathQuiz = Quiz(questions: ["Math choose 3", "Math choose 2"], choices: [["3", "2"],  ["3", "2"]], answers: ["3", "2"])
    var marvelQuiz = Quiz(questions: ["Marvel choose 1", "Marvel choose 2", "Marvel choose 3", "Marvel choose 4"], choices: [["1", "2", "3", "4"],  ["1", "2", "3", "4"], ["1", "2", "3", "4"], ["1", "2", "3", "4"]], answers: ["1", "2", "3", "4"])
    var scienceQuiz = Quiz(questions: ["Science choose 3", "Science choose 2"], choices: [["3", "2"],  ["3", "2"]], answers: ["3", "2"])

    
    @IBOutlet weak var settings: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    
    struct QuizCell {
        var title: String
        var imageName: String
        var desc : String
    }
    
    var data : [QuizCell] = [
        QuizCell(title: "Science", imageName: "science", desc: "science quiz not on chemistry"),
        QuizCell(title: "Marvel Super Heroes", imageName: "marvel", desc: "do you know marvel?"),
        QuizCell(title: "Math", imageName: "math", desc: "numbers")
    ]
    
    
    @IBAction func pressedSettings (_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "seg4set", sender:self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        runHttpRequest(url: QuizSession.globalUrl)
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    func runHttpRequest (url: String) {
        let url = URL(string: url)
        if url == nil {
          // TODO: Need a better error message
          NSLog("Bad address")
            let alert = UIAlertController(title: "Error", message: "Empty URL", preferredStyle: .alert)
                    alert.addAction((UIAlertAction(title: "OK", style: .default
                    )))

                    self.present(alert, animated: true, completion: {
                      NSLog("The completion handler fired")
                    })
          return
        }
        // {{## END create-url ##}}

        // {{## BEGIN create-request ##}}
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let headerFields = request.allHTTPHeaderFields
        // {{## END create-request ##}}
        
        

        // {{## BEGIN start-task ##}}
        // Move to a background thread to do some long running work
        (URLSession.shared.dataTask(with: url!) {
          data, response, error in
          
          DispatchQueue.main.async {
            if error == nil {
              NSLog(response!.description)
              
              let response = response! as! HTTPURLResponse
              
              var headers = ""
              headers = "\(response.statusCode)\n"
              for (name, value) in response.allHeaderFields {
                headers += "\(name as! String) = \(value as! String)\n"
              }
              
              if data == nil {
                print("empty data")
              }
              else {
                  NSLog("this is logging", data!.description)
                  do {
                      if let quizzes = try JSONSerialization.jsonObject(with: data!, options: []) as? [[String: Any]] {
                          for quiz in quizzes {
                              let title = quiz["title"] as! String
                              let description = quiz["desc"] as! String

                              
                              var temp = quiz["questions"] as! [[String: Any]]
                              
                              var questions: [String] = []
                              var choices: [[String]] = []
                              var answers: [String] = []
                              
                              for question in temp {
                                  if
                                    let questionText = question["text"] as? String,
                                    let answerChoices = question["answers"] as? [String],
                                    let correctAnswer = question["answer"] as? String,
                                    let correctAnswerIndex = Int(correctAnswer)
                                  {
                                      questions.append(questionText)
                                      choices.append(answerChoices)
                                      answers.append(answerChoices[Int(correctAnswerIndex - 1)])
                                  }
                              }
                              if (title.lowercased().contains("science")) {
                                  self.scienceQuiz = Quiz(questions: questions, choices: choices, answers: answers)
                                  self.data[0].title = title
                                  self.data[0].desc = description
                              } else if (title.lowercased().contains("math")) {
                                  self.mathQuiz = Quiz(questions: questions, choices: choices, answers: answers)
                                  self.data[2].title = title
                                  self.data[2].desc = description
                              } else {
                                  self.marvelQuiz = Quiz(questions: questions, choices: choices, answers: answers)
                                  self.data[1].title = title
                                  self.data[1].desc = description
                              }
                              
                          }
                          self.tableView.reloadData()
                          
                      }
                      
                  } catch {
                      print("error")
                  }
                  
              }
            } else {
                let alert = UIAlertController(title: "Error", message: "Invalid URL", preferredStyle: .alert)
                alert.addAction((UIAlertAction(title: "OK", style: .default
                                              )))
                
                self.present(alert, animated: true, completion: {
                    NSLog("The completion handler fired")
                })
            }
          }
            
        }).resume()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "seg1", sender:self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seg1" {
            if let index = tableView.indexPathForSelectedRow?.row {
                let selectedTitle = data[index].title.lowercased()
                let destinationVC = segue.destination as? SecondViewController

                if selectedTitle.contains("math") {
                    destinationVC?.quiz = mathQuiz
                } else if selectedTitle.contains("science") {
                    destinationVC?.quiz = scienceQuiz
                } else if selectedTitle.contains("marvel") {
                    destinationVC?.quiz = marvelQuiz
                }
            }
        } else if (segue.identifier == "seg4set") {
            let destinationVC = segue.destination as? FifthViewController
            destinationVC?.urlUpdate = QuizSession.globalUrl
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


