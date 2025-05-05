//
//  ViewController.swift
//  iQuiz
//
//  Created by Lindsy M on 5/3/25.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
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
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("tapped here")
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(data.count)
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


