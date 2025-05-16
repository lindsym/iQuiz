//
//  FifthViewController.swift
//  iQuiz
//
//  Created by Lindsy M on 5/15/25.
//

import UIKit

class FifthViewController: UIViewController {
    var urlUpdate = ""
    
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var urlCheck: UITextField!
    
    @IBOutlet weak var backButton: UIButton!
    @IBAction func goBack () {
        performSegue(withIdentifier: "seg4set2", sender: self)
    }
    
    
    
    @IBAction func goPushed(_ sender: Any) {
        let url = URL(string: urlCheck.text ?? "")
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
        
        // {{## BEGIN create-request ##}}
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let headerFields = request.allHTTPHeaderFields
        // {{## END create-request ##}}
        
        
        
        // {{## BEGIN start-task ##}}
        // Move to a background thread to do some long running work
        URLSession.shared.dataTask(with: request) {
            data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("error")
                    let alert = UIAlertController(title: "Error", message: "Invalid URL", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert, animated: true)
                    return
                }
                
                self.urlUpdate = self.urlCheck.text ?? ""
                QuizSession.globalUrl = self.urlUpdate
                self.performSegue(withIdentifier: "seg4set2", sender: self)
            }
         }.resume()
     }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "seg4set2" {
            let destinationVC = segue.destination as? ViewController
        }
        

    }

    override func viewDidLoad() {
        super.viewDidLoad()
    

        // Do any additional setup after loading the view.
        urlCheck.text = urlUpdate
        urlCheck.placeholder = "enter url here"
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
