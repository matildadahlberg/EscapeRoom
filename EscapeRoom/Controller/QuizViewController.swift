import UIKit
import AudioToolbox

class QuizViewController: UIViewController, ShowsAlert{
    
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerA: UIButton!
    @IBOutlet weak var answerB: UIButton!
    @IBOutlet weak var answerC: UIButton!
    @IBOutlet weak var answerD: UIButton!
    
    var questionNumber = 1
    var updateTimeLabel = Timer()
    let segue = "quizSegue"
    
    struct Question {
        let question : String
        let answer : [String]
        let correctAnswer : String
    }
    
    var questions : [Question] = [
        Question(question: "Which year did Mark Zuckerberg launch Facebook?", answer: ["1999", "2004", "2006", "2000"], correctAnswer: "2004"),
        Question(question: "The tsunami that swept 2004 into various coastal parts of Asia was one of the largest natural catastrophe so far, how many people died?", answer: ["230 000", "70 000", "150 000", "500 000"], correctAnswer: "230 000"),
        Question(question: "What does MMIV stand for in Roman numerals?", answer: ["2006", "1004", "2004", "106"], correctAnswer: "2004")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTimeLabel = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        updateQuestion()
    }
    
    @IBAction func answerButton(_ sender: Any) {
        
        let button = sender as! UIButton
        let title = button.titleLabel?.text
        
        if title == questions[questionNumber - 1].correctAnswer {
            questionNumber += 1
            updateQuestion()
        } else {
            AudioServicesPlayAlertSound(1519)
            questionNumber = 1
            updateQuestion()
        }
    }
    
    
    func updateQuestion() {
        
        if questionNumber == 1 {
            questionLabel.text = questions[0].question
            answerA.setTitle("\(questions[0].answer[0])", for: .normal)
            answerB.setTitle("\(questions[0].answer[1])", for: .normal)
            answerC.setTitle("\(questions[0].answer[2])", for: .normal)
            answerD.setTitle("\(questions[0].answer[3])", for: .normal)
        }
        if questionNumber == 2 {
            questionLabel.text = questions[1].question
            answerA.setTitle("\(questions[1].answer[0])", for: .normal)
            answerB.setTitle("\(questions[1].answer[1])", for: .normal)
            answerC.setTitle("\(questions[1].answer[2])", for: .normal)
            answerD.setTitle("\(questions[1].answer[3])", for: .normal)
        }
        if questionNumber == 3 {
            questionLabel.text = questions[2].question
            answerA.setTitle("\(questions[2].answer[0])", for: .normal)
            answerB.setTitle("\(questions[2].answer[1])", for: .normal)
            answerC.setTitle("\(questions[2].answer[2])", for: .normal)
            answerD.setTitle("\(questions[2].answer[3])", for: .normal)
        }
        
        if questionNumber == 4 {
            showAlert(title: "You answered all question correct!", segue: segue)
        }
    }
    
    @objc func updateTime() {
        
        if Time.seconds < 10 {
            timeLabel.text = "\(Time.minute):0\(Time.seconds)"
        }
        
        if Time.seconds == 10 || Time.seconds > 10 &&  Time.seconds < 60 {
            timeLabel.text = "\(Time.minute):\(Time.seconds)"
        }
        if Time.seconds == 60 {
            Time.minute += 1
            Time.seconds = 0
            timeLabel.text = "\(Time.minute):0\(Time.seconds)"
        }
    }
    
    @IBAction func exitButton(_ sender: Any) {
        exitAlert()
    }
}
