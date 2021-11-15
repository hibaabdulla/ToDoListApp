//
//  ToDoTableViewCell.swift
//  ToDoList
//
//  Created by Hiba on 7/17/21.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ToDoItem")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
