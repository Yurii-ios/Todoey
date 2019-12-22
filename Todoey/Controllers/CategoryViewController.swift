//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Yurii Sameliuk on 08/12/2019.
//  Copyright © 2019 Yurii Sameliuk. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    //inicializiryem klas Category bazu dannux
    var categories = [Category]()
    
    // podklu4aemsia  k klasy UIApplication wuzawaem y nego metod shared i delegate , priwodim k delegaty prilogenija klasa AppDelegate i podklu4aemsia k ego persistentContainer 4tobu poju4it kontejner s dannumi
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
    }
    //MARK: - TableView Datasource Methods
    // wozwras4aem dinami4eskoe koli4estwo strok dlia otobragenija na ekrane
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    // zapolniaet sozdanue stroki sootwetstwyjus4em koli4estwom elementow masiwa
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categories[indexPath.row]
        cell.textLabel?.text = category.name
        return cell
        
    }
    
    
    //MARK: - Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var texfield = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newCategories = Category(context: self.context)
            newCategories.name = texfield.text
            self.categories.append(newCategories)
            
            
            self.saveCategories()
        }
        alert.addTextField { (field) in
            field.placeholder = "Create new item"
            texfield = field
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    
    //MARK: - Data Manipulation Methods
    
    func saveCategories(){
        do {
            try context.save()
        }catch {
            print("Error saving category \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategories() {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        do {
            categories = try context.fetch(request)
        }catch {
            print("Error loading categories \(error)")
        }
        tableView.reloadData()
    }
    
    //MARK: - TableView Delegate Methods
    // opredeliaem na kotoryju stroky wubral polzomatel na ekrane
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // udaliaem wubranue  kategorii
        //        context.delete(categories[indexPath.row])
        //        categories.remove(at: indexPath.row)
        // nastraiwaem perechod na sledyjus4ij ekran
        performSegue(withIdentifier: "goToItems", sender: self)
        
        
//        self.saveCategories()
//        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // podgotowka k perechody na sledyjus4ij ekran
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVc = segue.destination as! TodoListViewController
        // yznaem kakyju stroky wubral polzowatel
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVc.selectedCategory = categories[indexPath.row]
        }
        
    }
}
