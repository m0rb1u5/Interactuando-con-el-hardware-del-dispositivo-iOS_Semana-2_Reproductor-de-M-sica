//
//  DetailViewController.swift
//  Interactuando-con-el-hardware-del-dispositivo-iOS_Semana-2_Reproductor-de-M-sica
//
//  Created by Juan Carlos Carbajal Ipenza on 21/04/17.
//  Copyright © 2017 Juan Carlos Carbajal Ipenza. All rights reserved.
//

import UIKit
import AVFoundation

class DetailViewController: UIViewController, AVAudioPlayerDelegate {
    var reproductor: AVAudioPlayer!
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var cancion: UILabel!
    @IBOutlet weak var artista: UILabel!
    @IBOutlet weak var ahora: UILabel!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var sound: UIButton!
    @IBOutlet weak var playpause: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var shuffle: UIButton!
    @IBOutlet weak var repeatButton: UIButton!
    
    
    var volumen: Float!
    var canciones = [Cancion]()
    var timer: Timer?
    
    var detailItem: Int? {
        didSet {
            // Update the view.
            configureView()
        }
    }

    override func 	viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag == true {
            if self.shuffle.isSelected == true {
                var random: Int = Int(arc4random_uniform(UInt32(self.canciones.count)))
                while random == self.detailItem {
                    random = Int(arc4random_uniform(UInt32(self.canciones.count)))
                }
                self.detailItem = random % self.canciones.count
            }
            else {
                if self.repeatButton.isSelected == true {
                    self.detailItem = (self.detailItem! + 1) % self.canciones.count
                }
                else {
                    self.detailItem = (self.detailItem! + 1) % self.canciones.count
                    if self.reproductor.isPlaying && self.detailItem! == 0 {
                        self.reproductor.stop()
                        self.reproductor.currentTime = 0.0
                        if self.timer != nil {
                            self.timer?.invalidate()
                            self.timer = nil
                        }
                        self.ahora.text = "00:00"
                        self.progressView.progress = 0.0
                        self.playpause.isSelected = false
                    }
                }
            }
        }
    }
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if self.cancion != nil {
                self.cancion.text = self.canciones[detail].nombre
            }
            if self.artista != nil {
                self.artista.text = self.canciones[detail].artista
            }
            if self.imagen != nil {
                self.imagen.image = self.canciones[detail].portada
            }
            do {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
                try AVAudioSession.sharedInstance().setActive(true)
                try self.reproductor = AVAudioPlayer(contentsOf: self.canciones[detail].url!)
                self.reproductor.delegate = self
                if !self.reproductor.isPlaying {
                    self.reproductor.play()
                    if self.timer == nil {
                        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateProgressView), userInfo: nil, repeats: true)
                    }
                    self.volumen = self.reproductor.volume
                    if self.total != nil {
                        self.total.text = self.stringFromTimeInterval(interval: self.reproductor.duration)
                    }
                }
            }
            catch let error as NSError {
                DispatchQueue.main.async {
                    let title = NSLocalizedString("Error \(error.code)", comment: "")
                    let message = NSLocalizedString(error.localizedDescription, comment: "")
                    let cancelButtonTitle = NSLocalizedString("OK", comment: "")
                    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .cancel) { action in
                        NSLog("La alerta acaba de ocurrir.")
                    }
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    func stringFromTimeInterval(interval: TimeInterval) -> String {
        let ti = NSInteger(interval)
        let seconds = ti % 60
        let minutes = ti / 60
        return NSString(format: "%0.2d:%0.2d", minutes, seconds) as String
    }
    @objc func updateProgressView() {
        if self.ahora != nil {
            self.ahora.text = self.stringFromTimeInterval(interval: self.reproductor.currentTime)
        }
        if self.progressView != nil {
            self.progressView.progress = Float(self.reproductor.currentTime / self.reproductor.duration)
        }
    }
    
    
    
    @IBAction func shuffleAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    @IBAction func backAction(_ sender: UIButton) {
        self.detailItem = (self.canciones.count + self.detailItem! - 1) % self.canciones.count
    }
    @IBAction func playPauseAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            if !self.reproductor.isPlaying {
                self.reproductor.play()
                if self.timer == nil {
                    self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateProgressView), userInfo: nil, repeats: true)
                }
            }
        }
        else {
            if self.reproductor.isPlaying {
                self.reproductor.pause()
                if self.timer != nil {
                    self.timer?.invalidate()
                    self.timer = nil
                }
            }
        }
    }
    @IBAction func stopAction(_ sender: UIButton) {
        if self.reproductor.isPlaying {
            self.reproductor.stop()
            self.reproductor.currentTime = 0.0
            if self.timer != nil {
                self.timer?.invalidate()
                self.timer = nil
            }
            self.ahora.text = "00:00"
            self.progressView.progress = 0.0
            self.playpause.isSelected = false
        }
    }
    @IBAction func nextAction(_ sender: UIButton) {
        self.detailItem = (self.detailItem! + 1) % self.canciones.count
    }
    @IBAction func repeatAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    @IBAction func soundAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            self.slider.value = 0.0
            self.reproductor.volume = self.slider.value
        }
        else {
            self.slider.value = self.volumen
            self.reproductor.volume = self.slider.value
        }
    }
    @IBAction func cambioVolumen(_ sender: UISlider) {
        self.reproductor.volume = self.slider.value
        self.volumen = self.reproductor.volume
        if self.volumen == 0.0 {
            self.sound.isSelected = true
        }
        else {
            self.sound.isSelected = false
        }
    }
    
      
    
}

