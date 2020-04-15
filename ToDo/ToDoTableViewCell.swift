//
//  ToDoTableViewCell.swift
//  ToDo
//
//  Created by Aung Ko Min on 11/4/20.
//  Copyright © 2020 Aung Ko Min. All rights reserved.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "ToDoTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: ToDoTableViewCell.reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
