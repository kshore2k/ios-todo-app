//
//  AddItemDelegate.swift
//  ToDoList
//
//  Created by Kris Shore on 4/23/19.
//  Copyright © 2019 Kris Shore. All rights reserved.
//

import UIKit
import Foundation

protocol AddItemDelegate: class {
    func addItemButtonPressed(for controller: AddItemViewController, with title: String, and details: String, for date: Date)
}
