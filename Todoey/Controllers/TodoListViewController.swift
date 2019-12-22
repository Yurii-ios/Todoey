//
//  ViewController.swift
//  Todoey
//
//  Created by Yurii Sameliuk on 29/11/2019.
//  Copyright © 2019 Yurii Sameliuk. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    
    // sozdaem nowuj masiw elementow ispolzyja DataModel.klas Item
    var itemArray = [Item]()
    // sozdaem peremennyju i priswaiwaem ej Category? ,i posle zagryzaem dannue iz Item w Category. eto nygo dlia togo 4tobu imet wozmognost zagryzit pri nazatii na kategoriju
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
    }
    // podklu4aemsia  k klasy UIApplication wuzawaem y nego metod shared i delegate , priwodim k delegaty prilogenija klasa AppDelegate i podklu4aemsia k ego persistentContainer 4tobu poju4it kontejner s dannumi
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // sozdaem nowuj objekt polzowatelskoj bazu dannux po ymol4aniju.
        // let defaults = UserDefaults.standard
        
        //propisuwaem pyt k direktorii proekta , gde sosergutsia fail s soxranennmi dannumi prilogenijaci podklu4aemsi k nemy
        //mu mogem sozdat "Name".plist stolko skolko nam nado. dlia togo 4tobu ne delat a posli ne zagrygat bolshoj fajl s dannumi.
        // FileManager - интерфейс к содержимому файловой системы и основным средствам взаимодействия с ней.Этот метод всегда представляет один и тот же объект файлового менеджера                                                                   // sozdaem nowuj dokyment daw emy nazwanie , 4tobu                                                                                                  soxraniat w nego polzowatelskie dannue
        //         let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
        //
        // pe4ataem w debagkonsol mestonaxhogdenie failow bazu dannux proekta
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        // etot kod otnositsia k wersii prilogenija s .plist
        //        let newItem = Item()
        //        newItem.title = "Find Mike"
        //        itemArray.append(newItem)
        //wuzuwaem na ekran zagrygenue dannue iz bazu
        
        
        // izwlekaem iz bazu dannux informaciju i pomes4aem ee w masiw , priwodim do tipa masiwa strok. no esli spisok dannux w baze otsytstwyet prilogenije zawisnet
        //                if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
        //                    itemArray = items
        //                }
    }
    
    //MARK: - TableView Datasource Methods
    
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
        // shablon - value = condition ? valueTrue : valueFalse
        
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
        // ydaliaem dannue iz nasego wremennogo konteksta
        // pri napisanii koda posledowatelnost wuzowow dolgna but imenno takoj, 4tobu izegat oshubki kompiliacii context.delete i potom itemArray.remove
        //context.delete(itemArray[indexPath.row])
        
        // ispolzuem metod ydalenija po indeksy.eta stroka ni4ego ne delaet dla nasux osnwnux dannux, ona prosto obnowliaet masiw elementow kotoruj ispolzyetsia dlia zapolnenija Tableiew
        // ydaliaet tekys4ij element iz masiwa elementow(postolannogo)
        //itemArray.remove(at: indexPath.row)
        
        // proweriaem na rawenstwo
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        //itemArray[indexPath.row].setValue("Complited", forKey: "title")
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
            //print(textField.text)
            
            
            // prinimaem kontejner context s bazoj dannux
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            //mu dolgnu ykazat roditelskeju kategoriju "parentCategory" (parentCategory- eto swiaz kotoryju mu sozdali w DataModel, swiazali Category i Item )
            newItem.parentCategory = self.selectedCategory
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
        //let encoder = PropertyListEncoder()
        do {
            //         // 4tobu itemArray sootwetstwowal kodiryemomy topy w klase Items nygno dobawit Encodable
            //         let data = try encoder.encode( itemArray)
            //         try data.write(to: dataFilePath!)
            try context.save()
            
        }catch {
            print("Error saving context \(error)")
            
            //         print("Error encoding item array,\(error.localizedDescription)")
        }
        
        
        //soxraniaem wwedennue dannue polzowatelem w bazy dannux.
        //iz za togo 4to mu ispolzyem kastomnoe reshenije ispolzyja itemArray a ne nastrojki po ymol4aniju ,prilogenije zawershaetsia s oshubkoj
        // self.defaults.set(self.itemArray, forKey: "TodoL istArray")
        
        // blagodaria reloadData() nowuj element masiwa bydet pokazan na ekrane
        tableView.reloadData()
    }
    
        //narygnuj parametr // wnytrennij parametr
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
        //4tobu zagryzalsia spisok del toj kategorii na kotoryju mu nazali mu otfiltrowyem poly4enue dannue
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        if let addtionalPredicate = predicate {
            //sozdaem sostawnoj predicat kotoruj prinimaet drygie predikatu
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,addtionalPredicate])
        }else {
            request.predicate = categoryPredicate
        }
        

        // NSFetchRequest<Item> obizatelno ykazuwaem tip dannux (w nashem sly4ae eto <Item>)kotorue mu xotim zagryzit ina4e pri zapuske prilogenija polu4im oshubky
        //prostoj zapros kotoruj wozwras4aet wse 4to naxoditsia na danuj moment w kontejnere
        do {
            // sochraniaem poly4enuj rezyltat w nashem masiwe itemArray
            itemArray = try context.fetch(request)
        }catch {
            print("Error fetching data context \(error)")
        }
        tableView.reloadData()
        //        // dekodiryem dannue iz ykazanogo puti
        //        if  let data = try? Data(contentsOf: dataFilePath!) {
        //            print(dataFilePath)
        //            let decoder = PropertyListDecoder()
        //            do {
        //                itemArray = try decoder.decode([Item].self, from: data)
        //            }catch{
        //                print("Error decoding item array \(error.localizedDescription)")
        //            }
        //        }
    }
    
}
//MARK: - Search bar methods
//razshuriaem wozmognosti nashej bazu dannux
extension TodoListViewController: UISearchBarDelegate {
    // kak tolko polzowatelnagumaet klawishy poiska mu zaprashuwaem rezyltat s nashej bazu dannux i wizwras4sem rezyltat kotoruj polzowatel iskal
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // sobiraemsia wernut masiw elementow
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        // ispolzyem predicate dlia zaprosa objektow iz bazu. "title CONTAINS %@" - prosmatriwaem kagduj zagolowok w elementach masiwa , mu tyt sami opredeliaem 4to i kak bydem iskat
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        // dobawliaem deskriptor sortirowki poly4enogo rezyltata
        //sortiryem poly4enue rezyltatu w masiwe s dannumi
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        //wuzuwaem funkciju
        loadItems(with: request)
 
        // print(searchBar.text)
    }
    // wozwras4aet k na4alnomy sostojaniju spisok na ekrane , kotoruj bul pered poiskom
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // esli polle poiska pystoe , pojawliawtsia izna4alnuj spisok na ekrane
        //loadItems()
        // es4e mogno zapisat s prowerkoj
        if searchBar.text?.count == 0 {
            loadItems()
            // 4tobu  searchBar.resignFirstResponder() srabotal ego nygno opredelit w osnownoj potok
            DispatchQueue.main.async {
                // yberaem klawiatyry i migajus4ij kyrsor w stroke pioska
                searchBar.resignFirstResponder()
            }
            
        }
    }
}
