//
//  LoginScreenViewController.swift
//  Login-Attempt-2
//
//  Created by Brandon Swett on 10/23/20.
//

import UIKit
import FirebaseAuth
import Firebase
import AVFoundation

class LoginScreenViewController: UIViewController {
    var player: AVPlayer?
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var LogInButton: UIButton!
    @IBOutlet weak var ErrorMessageLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playBackgroundVideo()
        ErrorMessageLabel.alpha = 0
        // Do any additional setup after loading the view.
    }
    
    func initalize(){
        ErrorMessageLabel.alpha = 0
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func playBackgroundVideo(){
        let path = Bundle.main.path(forResource: "IMG_0395", ofType: ".mp4")
        player = AVPlayer(url: URL(fileURLWithPath: path!))
        player!.actionAtItemEnd = AVPlayer.ActionAtItemEnd.none
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.frame
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.view.layer.insertSublayer(playerLayer, at: 0)
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player!.currentItem)
        player!.seek(to: CMTime.zero)
        player!.play()
        self.player?.isMuted = true
    }
    
    @objc func playerItemDidReachEnd(){
        player!.seek(to: CMTime.zero)
    }
    
    func validation()->String?{
        //Ensure no text field is blank
        if EmailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Fill in email field"
        }else if PasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {"Fill in password field"}
        
        return nil
    }

    @IBAction func LogInButtonTapped(_ sender: Any) {
        
        // We need to make sure the fields are not blank
        let error = validation()
        // If error != nil => Errors occureed and validation failed.
        if error != nil{
            // We can force unwrap error because we know it is not empy
            ErrorMessageLabel.text = error!
            ErrorMessageLabel.alpha = 1 // Make label visible
        }else{
        // We need to make sure the credentials match a user the in the database
            Auth.auth().signIn(withEmail: EmailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines), password: PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)) { (result, error) in
                if error != nil{
                    self.ErrorMessageLabel.text = "Error in log in"
                    self.ErrorMessageLabel.alpha = 1
                }else{
                    self.ErrorMessageLabel.text = "Log in successful!"
                    self.ErrorMessageLabel.alpha = 1
                }
            }
        }
        
    }
}
