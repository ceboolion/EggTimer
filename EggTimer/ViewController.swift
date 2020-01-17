import UIKit
import AVFoundation

class ViewController: UIViewController {
  @IBOutlet private var mainLabel: UILabel!
  @IBOutlet private var progressBar: UIProgressView!
  
  private let eggTime = ["Soft" : 3, "Medium" : 4, "Hard" : 7]
  private var timer = Timer()
  private var totalTime = 0
  private var secondsPassed = 0
  private var sound: AVAudioPlayer?
  
  @IBAction func hardnessSeclected(_ sender: UIButton) {
    let hardness = sender.currentTitle!
    totalTime = eggTime[hardness]!
    timer.invalidate()
    setupTimer()
    progressBar.progress = 0.0
    secondsPassed = 0
    mainLabel.text = hardness
  }
  
  private func setupTimer() {
    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(beginCountdown), userInfo: nil, repeats: true)
  }
  
  @objc private func beginCountdown() {
    if secondsPassed < totalTime {
      secondsPassed += 1
      let percentageProgress = Float(secondsPassed) / Float(totalTime)
      print(percentageProgress)
      progressBar.progress = Float(percentageProgress)
    } else {
      print("Countdown complete.")
      mainLabel.text = "Countdown complete."
      playSound()
      timer.invalidate()
    }
  }
  
  private func playSound() {
    let path = Bundle.main.path(forResource: "alarm_sound.mp3", ofType: nil)!
    let url = URL(fileURLWithPath: path)
    do {
      sound = try AVAudioPlayer(contentsOf: url)
      sound?.play()
    } catch {
      print("Couldn't find a file")
    }
  }
}
