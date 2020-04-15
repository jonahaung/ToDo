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
    
    private var iconImageView: UIImageView!
    private var taskTitleLabel: UILabel!
    private var detailsTaskLabel: UILabel!
    private var createdLabel: UILabel!
    private var editedLabel: UILabel!
    private var completedImageView: UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: ToDoTableViewCell.reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ToDoTableViewCell {
    
    private func setup() {
        iconImageView = UIImageView()
        imageView?.image = UIImage(systemName: "bell.fill")?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 45, weight: .light))
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        taskTitleLabel = UILabel()
        taskTitleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        taskTitleLabel.translatesAutoresizingMaskIntoConstraints = false
      
        
        detailsTaskLabel = UILabel()
        detailsTaskLabel.font = UIFont.preferredFont(forTextStyle: .body)
        detailsTaskLabel.translatesAutoresizingMaskIntoConstraints = false
        detailsTaskLabel.textColor = UIColor.secondaryLabel
      
        
        createdLabel = UILabel()
        createdLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        createdLabel.translatesAutoresizingMaskIntoConstraints = false
        createdLabel.textColor = UIColor.secondaryLabel
        
        editedLabel = UILabel()
        editedLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        editedLabel.translatesAutoresizingMaskIntoConstraints = false
        editedLabel.textColor = UIColor.secondaryLabel
        
        completedImageView = UIImageView()
        completedImageView.image = UIImage(systemName: "checkmark.circle")
        completedImageView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(iconImageView)
        contentView.addSubview(taskTitleLabel)
        contentView.addSubview(detailsTaskLabel)
        contentView.addSubview(createdLabel)
        contentView.addSubview(editedLabel)
        contentView.addSubview(completedImageView)
        
        // This is programatically layout
        contentView.addConstraints([
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            iconImageView.widthAnchor.constraint(equalToConstant: 50),
            iconImageView.heightAnchor.constraint(equalToConstant: 50),
            
            taskTitleLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 10),
            taskTitleLabel.bottomAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            
            detailsTaskLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 10),
            detailsTaskLabel.topAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            detailsTaskLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -50),
             
            createdLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 20),
            createdLabel.topAnchor.constraint(equalTo: detailsTaskLabel.bottomAnchor, constant: 0),
            createdLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            
            editedLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            editedLabel.topAnchor.constraint(equalTo: detailsTaskLabel.bottomAnchor, constant: 0),
            
            completedImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            completedImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15),
            completedImageView.widthAnchor.constraint(equalToConstant: 20),
            completedImageView.heightAnchor.constraint(equalToConstant: 20)
            
        
        ])
        
        
    }
    
    
    
    func configure(_ task: Task) {
        taskTitleLabel.text = task.title
        detailsTaskLabel.text = task.detils
        createdLabel.text = task.created?.description
        editedLabel.text = task.edited?.description
        completedImageView.image = task.isCompleted ? UIImage(systemName: "bell.circle.fill") : UIImage(systemName: "bell.circle")
    }
}
