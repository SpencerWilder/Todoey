//
//  CategoryViewControllerTableViewController.swift
//  Todoey
//
//  Created by Spencer Wilder on 5/29/18.
//  Copyright © 2018 Spencer Wilder. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewControllerTableViewController: UITableViewController {

    var categoryArray = [Category]()//[String]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
    }
    


    //MARK: - TableView Datasource Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categoryArray[indexPath.row].name
        return cell
    }

    
    //MARK: - Data Manipulation
    
    
    //MARK: - Add new Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Enter Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text
            self.categoryArray.append(newCategory)
            
            self.saveCategories()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Enter Category"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func loadCategories(with requests : NSFetchRequest<Category> = Category.fetchRequest()) {
        
        do {
            try categoryArray = context.fetch(requests)
        } catch {
            print("Error Fetching Data: \(error)")
        }
        
    }
    
    func saveCategories() {
        
        do {
            try context.save()
        } catch {
            print("Error when saving: \(error)")
        }
        
        tableView.reloadData()
    }
    
    //MARK: - TableView Delegate Methods
    
    
    
    
    
}
