//
//  RegisterScreenViewController.swift
//  Login-Attempt-2
//
//  Created by Brandon Swett on 10/23/20.
//

import UIKit
import Firebase
import AVFoundation

class RegisterScreenViewController: UIViewController {
    var player: AVPlayer?
    @IBOutlet weak var EmailAdressTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var SignUpButton: UIButton!
    @IBOutlet weak var ErrorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playBackgroundVideo()
        ErrorLabel.alpha = 0 // Make error label disapear.
        }
    
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // Helper funciton that determines if a password is valid
    // Requirements:
        // Length of password is 8
        // One alphabet character at least
        // One "Special Character" : (!@#$%&*) at least
    // Code found on: https://iosdevcenters.blogspot.com/2017/06/password-validation-in-swift-30.html
    func passwordValid(_ password: String) -> Bool{
        let testPassword = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return testPassword.evaluate(with: password)
    }
    
    
    // Validates user email and password, if succesful returns nil
    // If validation fails and error message is returned for error display purposes.
    func validation()->String?{
        //Ensure no text field is blank
        if EmailAdressTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Fill in email field"
        }else if PasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {"Fill in password field"}
        
        // So now we know that all fields are not blank
        
        // We need to perform password security strength check
        
        // Note: We can do forced unwrapping here because we know the textfield is not blank
        let cleanPassword = PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        // Check if password is valid
        // If false we need to display the results of the failure
        if passwordValid(cleanPassword) == false{
            return "Make sure your password has: 8 characters, 1 special character, 1 aplhabetical character"
        }
        return nil
    }
    
    // User taps the sign up button.
    @IBAction func SignUpButtonTapped(_ sender: Any) {
        // First we need to ensure the user inputs are valid
        let error = validation()
        // If error != nil => Errors occureed and validation failed.
        if error != nil{
            // We can force unwrap error because we know it is not empy
            ErrorLabel.text = error!
            ErrorLabel.alpha = 1 // Make label visible
        }
        // if error == nil we know user successfully entered correct and valid information
        // Need to add their account to authentication list. 
        else{
            Auth.auth().createUser(withEmail: EmailAdressTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines), password: PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)) { (reuslt, error) in
                    
                // There was an error if this condition was met
                if error != nil{
                    self.ErrorLabel.text = "Error creating user"
                    self.ErrorLabel.alpha = 1 // Make label visible
                }else{
                    // Testing else Statement, will need to delete later
                    self.ErrorLabel.text = "Register successful!"
                    self.ErrorLabel.alpha = 1
                }
            }
        }
        
        // Here we want to transition to the next screen. 
    }
    
}
