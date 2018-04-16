//
//  ViewController.swift
//  audio-player
//
//  Created by Rick on 4/15/18.
//  Copyright © 2018 Pearce. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class ViewController: UIViewController {

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var artworkImg: UIImageView!
    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet weak var albumNameLbl: UILabel!
    
    var player: AVAudioPlayer!
    let filePath = Bundle.main.path(forResource: "Welcome Aboard", ofType: "mp3")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        do {
            
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: filePath!))
            
           
        } catch {
            print(error)
        }
    }
    
    @IBAction func restartBtnPressed(_ sender: Any) {
        player.currentTime = 0
    }
    
    @IBAction func playBtnPressed(_ sender: Any) {
        player.play()
        let playerItem = AVPlayerItem(url: URL(fileURLWithPath: filePath!))
        let metadataList = playerItem.asset.metadata
        let durationAsSeconds = playerItem.asset.duration.seconds
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        let duration = formatter.string(from: TimeInterval(durationAsSeconds))
        
        for item in metadataList {
            guard let key = item.commonKey, let value = item.value else { continue }

            switch key.rawValue {
            case "title": songTitle.text = "\(value as! String) - \(duration!)"
            case "albumName": albumNameLbl.text = value as? String
            case "artwork" where value is Data: artworkImg.image = UIImage(data: value as! Data)
            default: continue
            }
        }
        
    }
    
    @IBAction func pauseBtnPressed(_ sender: Any) {
        player.pause()
    }
    
    
    @IBAction func sliderChanged(_ sender: Any) {
        player.volume = slider.value
    }
}

