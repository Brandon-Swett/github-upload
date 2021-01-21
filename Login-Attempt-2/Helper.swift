//
//  Helper.swift
//  Login-Attempt-2
//
//  Created by Brandon Swett on 11/14/20.
//

import UIKit

   
   

    func styleTextField(_ textField : UITextField){
    //label.backgroundColor = .systemGreen
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.black.cgColor
}


    func styleButton(_ button : UIButton){
    //label.backgroundColor = .systemGreen
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.black.cgColor
    }

/*
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
 */
 
