//
//  PlayingViewController.swift
//  UIKit Nano
//
//  Created by Willian Magnum Albeche on 23/06/21.
//

import UIKit
import AVFoundation

class PlayingViewController: UIViewController {
    
    var musicService: MusicService?
    var player: AVAudioPlayer!

    @IBOutlet weak var progressBar: UISlider!
    @IBOutlet weak var playButtonOutlet: UIButton!
    
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // init player
        let url = Bundle.main.url(forResource: "audio", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        
        // setting the progress bar size to the player's music duration
        progressBar.maximumValue = Float(player.duration)
        
        // updating the progress bar every 100 ms
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.updateSlider), userInfo: nil, repeats: true)
        
        // updating cover image and labels to the music beeing played into the queue...
        updateLayout(to: (musicService?.queue.nowPlaying)!)
    }
    
    func updateLayout(to selectedMusic: Music){
        coverImage.image = musicService?.getCoverImage(forItemIded: selectedMusic.id)
        titleLabel.text  = selectedMusic.title
        artistLabel.text = selectedMusic.artist
    }
    
    @IBAction func playButton(_ sender: UIButton) {
        // FIXME: change button img here...
        if !player.isPlaying {
            player.play()
        } else {
            player.pause()
        }
    }
    
    @IBAction func skipButton(_ sender: Any) {
        musicService?.skipQueue()
        guard let nowPlaying = musicService?.queue.nowPlaying else { return }
        updateLayout(to: nowPlaying)
    }
    
    
    @IBAction func progressAction(_ sender: UISlider) {
        player.currentTime = TimeInterval(progressBar.value)
    }
    
    @objc func updateSlider(){
        progressBar.value = Float(player.currentTime)
    }
    
    
    
    
    @IBAction func favoriteButton(_ sender: UIButton) {
       
        
    }
    
    
}
