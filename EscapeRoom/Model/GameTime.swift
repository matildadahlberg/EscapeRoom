import Foundation

class GameTime {
    
    var gameTimer = Timer()
    
    func startGameTimer() {
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameTime.updateTimer), userInfo: nil, repeats: true)
    }
    
    
    @objc func updateTimer() {
        Time.seconds += 1
    }
    
    func stopGameTimer() {
        gameTimer.invalidate()
    }
}

struct Time {
    static var seconds = 0
    static var minute = 0
}
