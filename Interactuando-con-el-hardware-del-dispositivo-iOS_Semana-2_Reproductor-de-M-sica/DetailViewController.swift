//
//  DetailViewController.swift
//  Interactuando-con-el-hardware-del-dispositivo-iOS_Semana-2_Reproductor-de-M-sica
//
//  Created by Juan Carlos Carbajal Ipenza on 21/04/17.
//  Copyright © 2017 Juan Carlos Carbajal Ipenza. All rights reserved.
//

import UIKit
import AVFoundation

class DetailViewController: UIViewController {
    var reproductor: AVAudioPlayer!
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var cancion: UILabel!
    @IBOutlet weak var artista: UILabel!
    @IBOutlet weak var ahora: UILabel!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    
    var detailItem: Cancion? {
        didSet {
            // Update the view.
            configureView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if self.imagen != nil {
                self.imagen.image = detail.portada
            }
            if self.cancion != nil {
                self.cancion.text = detail.nombre
            }
            if self.artista != nil {
                self.artista.text = detail.artista
            }
            do {
                try self.reproductor = AVAudioPlayer(contentsOf: detail.url!)
                if !self.reproductor.isPlaying {
                    self.reproductor.play()
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
            if self.total != nil {
                self.total.text = self.stringFromTimeInterval(interval: self.reproductor.deviceCurrentTime)
            }
        }
    }
    func stringFromTimeInterval(interval: TimeInterval) -> String {
        let ti = NSInteger(interval) / 1000
        let seconds = ti % 60
        let minutes = ti / 60
        return NSString(format: "%0.2d:%0.2d", minutes, seconds) as String
    }
    
    @IBAction func shuffleAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    @IBAction func backAction(_ sender: UIButton) {
    }
    @IBAction func playPauseAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            if !self.reproductor.isPlaying {
                self.reproductor.play()
            }
        }
        else {
            if self.reproductor.isPlaying {
                self.reproductor.pause()
            }
        }
    }
    @IBAction func stopAction(_ sender: UIButton) {
        if self.reproductor.isPlaying {
            self.reproductor.stop()
            self.reproductor.currentTime = 0.0
        }
    }
    @IBAction func nextAction(_ sender: UIButton) {
    }
    @IBAction func repeatAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    @IBAction func soundAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            if self.reproductor.isPlaying {
                self.reproductor.volume = 0.0
            }
        }
        else {
            if self.reproductor.isPlaying {
                self.reproductor.volume = self.slider.value
            }
        }
    }
    @IBAction func cambioVolumen(_ sender: UISlider) {
        self.reproductor.volume = self.slider.value
    }
    
    
    
    
      
    
}

