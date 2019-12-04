//
//  ViewController.swift
//  Todoey
//
//  Created by Yurii Sameliuk on 29/11/2019.
//  Copyright © 2019 Yurii Sameliuk. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    // sozdaem nowuj masiw elementow ispolzyja klass Item
    var itemArray = [Item] ()
    // sozdaem nowuj objekt polzowatelskoj bazu dannux po ymol4aniju. 
   // let defaults = UserDefaults.standard
    
    //propisuwaem pyt k direktorii proekta , gde sosergutsia fail s soxranennmi dannumi prilogenijaci podklu4aemsi k nemy
    //mu mogem sozdat "Name".plist stolko skolko nam nado. dlia togo 4tobu ne delat a posli ne zagrygat bolshoj fajl s dannumi.
    // FileManager - интерфейс к содержимому файловой системы и основным средствам взаимодействия с ней.Этот метод всегда представляет один и тот же объект файлового менеджера                                                                   // sozdaem nowuj dokyment daw emy nazwanie , 4tobu                                                                                                  soxraniat w nego polzowatelskie dannue
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        //wuzuwaem na ekran zagrygenue dannue iz bazu
        loadItems()
        
        // izwlekaem iz bazu dannux informaciju i pomes4aem ee w masiw , priwodim do tipa masiwa strok. no esli spisok dannux w baze otsytstwyet prilogenije zawisnet
//                if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//                    itemArray = items
//                }
    }
    
    //MARK: - TableView Datasource Mathods
    
    // wozwras4aem dinami4eskoe koli4estwo strok dlia otobragenija na ekrane
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
        
    }
    // zapolniaet sozdanue stroki sootwetstwyjus4em koli4estwom elementow masiwa
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        // Ternary operator ==>
        // value = condition ? valueTrue : valueFalse
        
        cell.accessoryType = item.done ?  .checkmark : .none
       // priwjazuwaem checkmark k konkretnomy elementy masiwa. esle mu etogo ne sdelaem to checkmark bydet powtoriatsia na tex elementax masiwa na kotorue mu ego ne stawili, potomy 4to ja4ejki tablicu powtoriajutsia kak tolko starue elementu propadajut iz wida ma ekrane
//        if item.done == true {
//
//            // nagumaja stroky na ekrane stawim galo4ky wupolnenija zadanija
//            // stroka imeet galo4ky pri nagatii na nee
//            cell.accessoryType = .checkmark
//        }else {
//            // esli imeet snimaem ee
//            cell.accessoryType = .none
//        }
        
        return cell
    }
    //MARK: - TableView Delegate Methods
    // opredeliaem na kotoryju stroky wubral polzomatel na ekrane
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // proweriaem na rawenstwo
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        //wse eti 5 strok koda mogno zaminit odnoj wushe
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        }else {
//            itemArray[indexPath.row].done = false
//        }
        self.saveItems()
        // opredeliaem kakoj imenno element masiwa polzowatel wubral na ekrane
//        let selectedTrail = itemArray[indexPath.row]
//        print(selectedTrail)
//        // blagodaria reloadData() nowuj element masiwa bydet pokazan na ekrane
//        tableView.reloadData()
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
            
            let newItem = Item()
            newItem.title = textField.text!
            //textField.text! - nikogda  ne bwaet pystum, poetomy mogno  spokoino anrapnyt
            // dobawliaem w masiw tekst wwedennuj w  alert.addTextField
            self.itemArray.append(newItem)
            
            self.saveItems()
            
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
    

//MARK: - Model Manupulation Methods

func saveItems() {
    //sozdaem kodirows4ika dlia kodirowanija nashux dannux , a minno nash sozdanuj fail Items.plist
     let encoder = PropertyListEncoder()
     do {
         // 4tobu itemArray sootwetstwowal kodiryemomy topy w klase Items nygno dobawit Encodable
         let data = try encoder.encode( itemArray)
         try data.write(to: dataFilePath!)
     }catch {
         print("Error encoding item array,\(error.localizedDescription)")
     }
     
     
     //soxraniaem wwedennue dannue polzowatelem w bazy dannux.
     //iz za togo 4to mu ispolzyem kastomnoe reshenije ispolzyja itemArray a ne nastrojki po ymol4aniju ,prilogenije zawershaetsia s oshubkoj
    // self.defaults.set(self.itemArray, forKey: "TodoL istArray")
     
     // blagodaria reloadData() nowuj element masiwa bydet pokazan na ekrane
     tableView.reloadData()
}
    
    func loadItems() {
        // dekodiryem dannue iz ykazanogo puti
        if  let data = try? Data(contentsOf: dataFilePath!) {
            print(dataFilePath)
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            }catch{
                print("Error decoding item array \(error.localizedDescription)")
            }
        }
    }
    
}
