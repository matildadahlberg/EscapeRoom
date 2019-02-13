import UIKit

class QuizViewController: UIViewController {
    
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var unlockButton: UIButton!
    
    var descriptionLabel = UILabel()
    var countLabel = UILabel()
    var questionNumber = 1
    var answer1 = UIButton()
    var answer2 = UIButton()
    var answer3 = UIButton()
    var answer4 = UIButton()
    
    struct Question {
        let question : String
        let answer : [String]
        let correctAnswer : String
    }
    
    var questions : [Question] = [
        Question(question: "What's the name of the capital in Denmark?", answer: ["Stockholm", "Oslo", "Paris", "Copenhagen"], correctAnswer: "Copenhagen"),
        Question(question: "How tall is Victoria Tower?", answer: ["118m", "176m", "88m", "200m"], correctAnswer: "118m"),
        Question(question: "When was the first iPhone released?", answer: ["2004", "2010", "2007", "2009"], correctAnswer: "2007")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupText()
        exitButton.layer.cornerRadius = 15
        unlockButton.isHidden = true
        updateQuestion()
    }
    
    @objc func checkAnswer(sender: AnyObject) {
        
        let button = sender as! UIButton
        let title = button.titleLabel?.text
        
        if title == questions[questionNumber - 1].correctAnswer {
            questionNumber += 1
            updateQuestion()
        } else {
            
            questionNumber = 1
            updateQuestion()
        }
    }
    
    func updateQuestion() {
        
        if questionNumber == 1 {
            descriptionLabel.text = questions[0].question
            countLabel.text = "Question \(questionNumber)/3"
            answer1.setTitle("\(questions[0].answer[0])", for: .normal)
            answer2.setTitle("\(questions[0].answer[1])", for: .normal)
            answer3.setTitle("\(questions[0].answer[2])", for: .normal)
            answer4.setTitle("\(questions[0].answer[3])", for: .normal)
        }
        if questionNumber == 2 {
            descriptionLabel.text = questions[1].question
            countLabel.text = "Question \(questionNumber)/3"
            answer1.setTitle("\(questions[1].answer[0])", for: .normal)
            answer2.setTitle("\(questions[1].answer[1])", for: .normal)
            answer3.setTitle("\(questions[1].answer[2])", for: .normal)
            answer4.setTitle("\(questions[1].answer[3])", for: .normal)
        }
        if questionNumber == 3 {
            descriptionLabel.text = questions[2].question
            countLabel.text = "Question \(questionNumber)/3"
            answer1.setTitle("\(questions[2].answer[0])", for: .normal)
            answer2.setTitle("\(questions[2].answer[1])", for: .normal)
            answer3.setTitle("\(questions[2].answer[2])", for: .normal)
            answer4.setTitle("\(questions[2].answer[3])", for: .normal)
        }
        
        if questionNumber == 4 {
            descriptionLabel.text = ""
            countLabel.text = ""
            unlockButton.isHidden = false
            answer1.isHidden = true
            answer2.isHidden = true
            answer3.isHidden = true
            answer4.isHidden = true
            unlockButton.layer.cornerRadius = 15
        }
    }
    
    func setupText(){
        countLabel = UILabel(frame: CGRect(x: self.view.frame.width/2 - 150 , y: 100, width: 300, height: 50))
        countLabel.textAlignment = .center
        countLabel.text = "Question 1/3"
        countLabel.font = UIFont(name: "Helvetica", size: 20)
        self.view.addSubview(countLabel)
        
        descriptionLabel = UILabel(frame: CGRect(x: self.view.frame.width/2 - 175 , y: 200, width: 350, height: 100))
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 2
        descriptionLabel.text = "Question"
        descriptionLabel.font = UIFont(name: "Helvetica", size: 30)
        self.view.addSubview(descriptionLabel)
        
        answer1 = UIButton(frame: CGRect(x: self.view.frame.width/2 - 145, y: 500, width: 125, height: 75))
        answer1.backgroundColor = UIColor.black
        answer1.setTitle("A", for: .normal)
        answer1.layer.cornerRadius = 15
        answer1.addTarget(self, action: #selector(checkAnswer), for: .touchDown)
        self.view.addSubview(answer1)
        
        answer2 = UIButton(frame: CGRect(x: self.view.frame.width/2 + 20, y: 500, width: 125, height: 75))
        answer2.backgroundColor = UIColor.black
        answer2.setTitle("B", for: .normal)
        answer2.layer.cornerRadius = 15
        answer2.addTarget(self, action: #selector(checkAnswer), for: .touchDown)
        self.view.addSubview(answer2)
        
        answer3 = UIButton(frame: CGRect(x: self.view.frame.width/2 - 145, y: 610, width: 125, height: 75))
        answer3.backgroundColor = UIColor.black
        answer3.setTitle("C", for: .normal)
        answer3.layer.cornerRadius = 15
        answer3.addTarget(self, action: #selector(checkAnswer), for: .touchDown)
        self.view.addSubview(answer3)
        
        answer4 = UIButton(frame: CGRect(x: self.view.frame.width/2 + 20, y: 610, width: 125, height: 75))
        answer4.backgroundColor = UIColor.black
        answer4.setTitle("D", for: .normal)
        answer4.layer.cornerRadius = 15
        answer4.addTarget(self, action: #selector(checkAnswer), for: .touchDown)
        self.view.addSubview(answer4)
        
    }
}
