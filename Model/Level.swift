
import Foundation
import UIKit

struct Level {
    var currentQuestionIndex = 0
    let questions : [Person] = [
        Person(image: "yangom" , nationality: "Korean"),
        Person(image: "bruclee" , nationality: "Chinese"),
        Person(image: "jomong" , nationality: "Korean"),
        Person(image: "clothes" , nationality: "Thai"),
        Person(image: "corona" , nationality: "Thai"),
        Person(image: "fokoyama" , nationality: "Japanese"),
        Person(image: "kongfu" , nationality: "Chinese"),
        Person(image: "music" , nationality: "Thai"),
        Person(image: "oldman" , nationality: "Chinese"),
        Person(image: "orange" , nationality: "Thai"),
    ]
    
    mutating func nextQuestion(){
        currentQuestionIndex += 1
    }
    
    func showImage() -> String  {
        let person = questions[currentQuestionIndex]
        return person.image
    }
    
    mutating func resetGame() {
        currentQuestionIndex = 0
    }
    
}



