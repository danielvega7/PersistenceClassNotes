//
//  ViewController.swift
//  PersistenceClassNotes
//
//  Created by DANIEL VEGA on 10/22/21.
//

import UIKit

public struct Contact: Codable {
   public var name: String
   public var age: Int
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    @IBOutlet weak var nameOutlet: UITextField!
    @IBOutlet weak var ageOutlet: UITextField!
    
    //let defaults = UserDefaults.standard

    @IBOutlet weak var tableViewOutlet: UITableView!
    
    var contacts: [Contact] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewOutlet.delegate = self
        tableViewOutlet.dataSource = self
        
        contacts.append(Contact(name: "Brian", age: 27))
        contacts.append(Contact(name: "Tracy", age: 47))
        
        if let items = UserDefaults.standard.data(forKey: "theContacts2") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Contact].self, from: items){
                contacts = decoded
                print("reading data")
            }
        }
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewOutlet.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = contacts[indexPath.row].name
        cell.detailTextLabel?.text = String(contacts[indexPath.row].age)
        return cell
    }

    //SAVE ACTION
    @IBAction func addAction(_ sender: UIButton) {
     
        let encoder = JSONEncoder()
        
        if let encoded = try? encoder.encode(contacts) {
            
            UserDefaults.standard.set(contacts, forKey: "theContacts2")
            
        }
    }
    
    @IBAction func frAddAction(_ sender: UIButton) {
        contacts.append(Contact(name: nameOutlet.text!, age: Int(ageOutlet.text!)!))
        
        let encoder = JSONEncoder()
        
        if let encoded = try? encoder.encode(contacts) {
            
            UserDefaults.standard.set(contacts, forKey: "theContacts2")
            
        }
        
        tableViewOutlet.reloadData()
    }
}

