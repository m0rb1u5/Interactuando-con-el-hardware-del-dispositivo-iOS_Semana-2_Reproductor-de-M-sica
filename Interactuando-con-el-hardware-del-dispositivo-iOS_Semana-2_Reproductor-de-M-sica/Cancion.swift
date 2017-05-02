//
//  Cancion.swift
//  Interactuando-con-el-hardware-del-dispositivo-iOS_Semana-2_Reproductor-de-M-sica
//
//  Created by Juan Carlos Carbajal Ipenza on 2/05/17.
//  Copyright © 2017 Juan Carlos Carbajal Ipenza. All rights reserved.
//

import Foundation
import UIKit

class Cancion {
    var nombre: String?
    var artista: String?
    var url: URL?
    var portada: UIImage?
    
    init() {
        self.nombre = nil
        self.artista = nil
        self.url = nil
        self.portada = nil
    }
    init(nombre: String?, artista: String?, url: URL?, portada: UIImage?) {
        self.nombre = nombre
        self.artista = artista
        self.url = url
        self.portada = portada
    }
    init(nombre: String?, artista: String?, recursoURL: String?, extensionURL: String?, recursoPortada: String?, extensionPortada: String?) {
        self.nombre = nombre
        self.artista = artista
        self.url = Bundle.main.url(forResource: recursoURL, withExtension: extensionURL)
        let pathPortada = Bundle.main.path(forResource: recursoPortada, ofType: extensionPortada)
        if pathPortada != nil {
            self.portada = UIImage(contentsOfFile: pathPortada!)
        }
        else {
            self.portada = nil
        }
    }
    
    func isEmpty() -> Bool {
        if (self.nombre == nil && self.artista == nil && self.url == nil && self.portada == nil) {
            return true
        }
        else {
            return false
        }
    }
}
