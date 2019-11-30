//
//  ViewController.swift
//  Todoey
//
//  Created by Yurii Sameliuk on 29/11/2019.
//  Copyright © 2019 Yurii Sameliuk. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    // sozdaem nowuj masiw elementow
    var itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

//MARK: - TableView Datasource Mathods

     // wozwras4aem dinami4eskoe koli4estwo strok dlia otobragenija na ekrane
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
        
    }
    // zapolniaet sozdanue stroki sootwetstwyjus4em koli4estwom elementow masiwa
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        
    
        return cell
  }
//MARK: - TableView Delegate Methods
    // opredeliaem na kotoryju stroky wubral polzomatel na ekrane
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        // opredeliaem kakoj imenno element masiwa polzowatel wubral na ekrane
        let selectedTrail = itemArray[indexPath.row]
        print(selectedTrail)
        
        // nagumaja stroky na ekrane stawim galo4ky wupolnenija zadanija
        // proweriaem esli stroka imeet galo4ky pri nagatii na nee
       if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
        // esli imeet snimaem ee
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        // ili stawim ee pri powtornom nagatii
        }else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
         // delaem animirywanyju seryju polosy, posle nagatila na stroky ona 4erez sekyndy staet narmalnoj
        tableView.deselectRow(at: indexPath, animated: true)
        
        }
    
    }
    


