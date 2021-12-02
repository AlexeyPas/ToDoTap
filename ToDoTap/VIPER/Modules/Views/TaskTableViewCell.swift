//
//  TaskTableViewCell.swift
//  ToDoTap
//
//  Created by Pasynkov Alexey on 08.06.2021.
//

import UIKit
import PinLayout

class TaskTableViewCell: UITableViewCell {
    
        private let taskForThe = UILabel()
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            setup()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setup() {
            taskForThe.font = .systemFont(ofSize: 20, weight: .semibold)
            taskForThe.numberOfLines = 0
            backgroundColor = .clear
            
            contentView.layer.shadowColor = UIColor.black.cgColor
            contentView.layer.shadowRadius = 0.5
            contentView.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
            contentView.layer.shadowOpacity = 0.8
            contentView.layer.cornerRadius = 8
            contentView.backgroundColor = UIColor.systemOrange
            
            selectionStyle = .none
            contentView.addSubview(taskForThe)
            
            
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            
            contentView.pin
                .all(12)
            
            taskForThe.pin
                .all(15)
                .sizeToFit(.width)
            
        }
        
        func configure(textFromDB: String) {
            taskForThe.text = textFromDB
        }
        
    }

