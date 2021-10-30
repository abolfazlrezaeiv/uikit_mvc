

import Foundation
import UIKit

struct Score {
    var point : Int = 0
    var score : Int = 0

    mutating func checkAnswer(userAnswer : String , correctAnswer : String) -> String {
        if userAnswer == correctAnswer{
            point = 20
            score += point
        }else{
            point = -5
            score += point
        }
        return String(point)
    }
        
    func getPoint() -> String {
        if point == -5 {
            return "Wrong , you lost\(point) point"
        }else{
            return "you achived \(point) more point"
        }
        
    }
        
    func getScore() -> String {
        return String(score)
    }
        
    mutating func resetScore() {
        score = 0
    }
    
}
