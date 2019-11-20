//
//  AddItemViewController.swift
//  ToDoList
//
//  Created by Kris Shore on 4/23/19.
//  Copyright © 2019 Kris Shore. All rights reserved.
//

import UIKit
import CoreData

class AddItemViewController: UIViewController {

    @IBOutlet weak var itemTitle: UITextField!
    
    @IBOutlet weak var itemDetails: UITextField!
    
    @IBOutlet weak var itemDate: UIDatePicker!
    
    weak var delegate: ToDoListViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addItemButtonPressed(_ sender: UIButton) {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MM/dd/yyyy"
//        let stringDate = dateFormatter.string(from: itemDate.date)
        
        delegate?.addItemButtonPressed(for: self, with: itemTitle.text!, and: itemDetails.text!, for: itemDate.date)
    }
    
}
