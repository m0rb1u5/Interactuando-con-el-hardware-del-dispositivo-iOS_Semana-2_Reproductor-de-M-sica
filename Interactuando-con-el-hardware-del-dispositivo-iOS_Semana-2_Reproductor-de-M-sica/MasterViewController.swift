//
//  MasterViewController.swift
//  Interactuando-con-el-hardware-del-dispositivo-iOS_Semana-2_Reproductor-de-M-sica
//
//  Created by Juan Carlos Carbajal Ipenza on 21/04/17.
//  Copyright © 2017 Juan Carlos Carbajal Ipenza. All rights reserved.
//

import UIKit
import AVFoundation

class MasterViewController: UITableViewController {
    var detailViewController: DetailViewController? = nil
    var canciones = [Cancion]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        self.canciones.append(Cancion(nombre: "Lejos", artista: "6 Voltios", recursoURL: "6 Voltios - Lejos", extensionURL: "mp3", recursoPortada: "6 Voltios - Lejos", extensionPortada: "jpg"))
        self.canciones.append(Cancion(nombre: "Al colegio no voy más", artista: "Leuzemia", recursoURL: "Leuzemia - Al colegio no voy mas", extensionURL: "mp3", recursoPortada: "Leuzemia - Al colegio no voy mas", extensionPortada: "jpg"))
        self.canciones.append(Cancion(nombre: "Shakira y sus amigas", artista: "Los Chabelos", recursoURL: "Los Chabelos - Shakira y sus amigas", extensionURL: "mp3", recursoPortada: "Los Chabelos - Shakira y sus amigas", extensionPortada: "jpg"))
        self.canciones.append(Cancion(nombre: "Matalos a todos", artista: "No recomendable", recursoURL: "No recomendable - Matalos a todos", extensionURL: "mp3", recursoPortada: "No recomendable - Matalos a todos", extensionPortada: "jpg"))
        self.canciones.append(Cancion(nombre: "Nana", artista: "Warcry", recursoURL: "Warcry - Nana", extensionURL: "mp3", recursoPortada: "Warcry - Nana", extensionPortada: "jpg"))
    }
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let cancion = canciones[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = cancion
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.canciones.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = self.canciones[indexPath.row].nombre
        cell.detailTextLabel?.text = self.canciones[indexPath.row].artista
        if (self.canciones[indexPath.row].portada != nil) {
            cell.accessoryView = UIImageView(image: self.canciones[indexPath.row].portada)
            cell.accessoryView?.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        }
        return cell
    }
}

