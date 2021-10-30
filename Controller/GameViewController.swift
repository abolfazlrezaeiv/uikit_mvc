

import UIKit
class ViewController: UIViewController{
   
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var chineseBox: UIView!
    @IBOutlet weak var japaneseBox: UIView!
    @IBOutlet weak var thaiBox: UIView!
    @IBOutlet weak var koreanBox: UIView!
    @IBOutlet weak var touchLimitLineView: UIView!
    @IBOutlet weak var photoView: UIView!
    @IBOutlet weak var pointLabel: UILabel!
    var level = Level()
    var score = Score()
    var panAngle : CGFloat?
    var starterLocationPhoto : CGPoint?
    let K = Constants()
    
    
     
    override func viewDidLoad() {
        super.viewDidLoad()

        starterLocationPhoto  = photoView.frame.origin
        photo.image = UIImage(named: level.showImage())
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture))
        touchLimitLineView.addGestureRecognizer(gestureRecognizer)
        self.animateToDown()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        level.resetGame()
        score.resetScore()
        updateUI()
        photoView.frame.origin = starterLocationPhoto!
        self.animateToDown()
    }

    
    func getCorrectAnswerFromModel()  {
        let nationality = level.questions[level.currentQuestionIndex].nationality
        let correctAnswer = nationality
        let userAnswer = returnUserAnswer(angleOfTouch: panAngle!)
        score.checkAnswer(userAnswer: userAnswer, correctAnswer: correctAnswer)
    }
    
    func updateUI()  {
        photo.image = UIImage(named: level.showImage())
        pointLabel.text = score.getPoint()
    }
  
    func manageGame() {
        getCorrectAnswerFromModel()
        updateUI()
        fadeOut(element: photoView)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5 ) { [self] in
            photoView.frame.origin = starterLocationPhoto!
            if level.currentQuestionIndex < 9 {
                level.nextQuestion()
                updateUI()
                animateToDown()
            }else{
                performSegue(withIdentifier: K.ResultSugue, sender: self)
            }
        }
    }

    
    func returnUserAnswer(angleOfTouch : CGFloat ) -> String {
        switch angleOfTouch {
            case -73 ... -18:
                animateToBox(element: photoView , target: chineseBox, additionY: 0)
                return K.Chinese
            case -130 ... -98 :
                animateToBox(element: photoView , target: japaneseBox, additionY: 0)
                return K.Japanese
            case 98 ... 160 :
                animateToBox(element: photoView , target: koreanBox, additionY: 800)
                return K.Korean
            case 24 ... 88 :
                animateToBox(element: photoView , target: thaiBox, additionY: 800)
                return K.Thai
            default:
                animateToBox(element: photoView , target: chineseBox, additionY: 0)
                return K.Chinese
        }
    }
    // MARK: - Gesture Handler (Everything Starts From Here)
    @objc func handlePanGesture(gesture:UIPanGestureRecognizer){
        if gesture.state == .ended  {
            let velocity = gesture.velocity(in: view)
            let x = velocity.x
            let y = velocity.y
            panAngle =  atan2(y, x) * 180.0 / 3.14
            manageGame()
        }
    }
    
    // MARK: -Animations
    
    func animateToDown() {
        UIView.animate(withDuration: 12, delay: 0,options: .allowUserInteraction,animations: { [self] in
            let bottomOFScreen = CGRect(x: 96, y: 1000, width: 200, height: 200)
            photoView.frame = bottomOFScreen
            }
        )
    }
    
    func animateToBox(element : AnyObject , target : AnyObject , additionY : Int)  {
        UIView.animate(withDuration: 2, delay: 0,options: .allowUserInteraction,animations: { [self] in
            
            let nationalityBoxLocation = CGPoint(x: target.frame.origin.x, y: target.frame.origin.y + CGFloat(additionY))
            
            photoView.center = nationalityBoxLocation
        } ,completion: nil
        )
    }
      
    
    func fadeOut(element: AnyObject)  {
        let animation = CABasicAnimation(keyPath: K.Opacity )
        animation.fromValue = 1.0
        animation.toValue = 0.0
        animation.duration = 6
        element.add(animation,forKey: nil)
    }
    
    // MARK: -Navigation
    
    @IBAction func stopGame(_ sender: UIButton) {
        performSegue(withIdentifier: K.ResultSugue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! ResultViewController
        destinationVC.score = score.getScore()
    }
}
        


    


