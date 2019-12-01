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
    // sozdaem nowuj objekt polzowatelskoj bazu dannux po ymol4aniju
    let defaults = UserDefaults.standard

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // izwlekaem iz bazu dannux informaciju i pomes4aem ee w masiw , priwodim do tipa masiwa strok. no esli spisok dannux w baze otsytstwyet prilogenije zawisnet
        if let items = defaults.array(forKey: "TodoListArray") as? [String] { 
            itemArray = items
        }
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
//MARK: - Add New Items
    //sozdaem knopky dobawlenija nowux zapisej
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
      // sozdaem lokalnyju peremennyju dlia pereda4i wwedennoj informaciipolzowatelem  iz alert.addTextField  dlia otobragenija w tableView
        var textField = UITextField ()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
          // zdes nygno pisat powedenie action pri ego nagatii
            print(textField.text)
            //textField.text! - nikogda  ne bwaet pystum, poetomy mogno  spokoino anrapnyt
            // dobawliaem w masiw tekst wwedennuj w  alert.addTextField
            self.itemArray.append(textField.text!)
            
            //soxraniaem wwedennue dannue polzowatelem w bazy dannux.
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            // blagodaria reloadData() nowuj element masiwa bydet pokazan na ekrane
            self.tableView.reloadData()
        }
        //dobawliaem k alerty tekstowoe pole dlia wwoda nowogo zadanija
        alert.addTextField { (alertTextField) in
            // sozdaem tekst - podskazky w tekstowomy pole
        alertTextField.placeholder = "Create new item"
          textField = alertTextField
                    }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

}
    


