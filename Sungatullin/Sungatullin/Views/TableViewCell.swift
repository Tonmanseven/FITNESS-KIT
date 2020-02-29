//
//  TableViewCell.swift
//  Sungatullin
//
//  Created by Булат Сунгатуллин on 26.02.2020.
//  Copyright © 2020 Булат Сунгатуллин. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    var labelName = UILabel()
    var timeLabel = UILabel()
    var teacherLabel = UILabel()
    var placeLabel = UILabel()
    var descriptionText = UITextView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(labelName)
        addSubview(timeLabel)
        addSubview(placeLabel)
        addSubview(teacherLabel)
        addSubview(descriptionText)
        configureLabelName()
        configureTimeLabel()
        configurePlaceLabel()
        configureTecherLabel()
        configureDescriptionTextView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLabelName() {
        labelName.numberOfLines = 0
        //labelName.adjustsFontSizeToFitWidth = true
        labelName.font = UIFont(name: "Futura", size: 25)
        labelName.translatesAutoresizingMaskIntoConstraints = false
        labelName.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 3).isActive = true

    }
    
    func configureTimeLabel() {
        timeLabel.numberOfLines = 0
        timeLabel.font = UIFont(name: "Helvetica", size: 17)
        timeLabel.textAlignment = .left
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        timeLabel.centerYAnchor.constraint(equalTo: labelName.centerYAnchor).isActive = true
    }
    
    func configurePlaceLabel() {
        placeLabel.numberOfLines = 0
        placeLabel.font = UIFont(name: "Helvetica", size: 17)
        
        placeLabel.translatesAutoresizingMaskIntoConstraints = false
        placeLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 3).isActive = true
        placeLabel.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 5).isActive = true
    }
    
    func configureTecherLabel() {
        teacherLabel.numberOfLines = 0
        teacherLabel.font = UIFont(name: "Helvetica", size: 17)
        
        teacherLabel.translatesAutoresizingMaskIntoConstraints = false
        teacherLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 3).isActive = true
        teacherLabel.topAnchor.constraint(equalTo: placeLabel.bottomAnchor, constant: 5).isActive = true
    }
    
    func configureDescriptionTextView() {
        descriptionText.layer.cornerRadius = 5
        descriptionText.isEditable = false
        descriptionText.font = UIFont(name: "Helvetica", size: 14)
        descriptionText.backgroundColor = .opaqueSeparator
        descriptionText.translatesAutoresizingMaskIntoConstraints = false
        descriptionText.topAnchor.constraint(equalToSystemSpacingBelow: teacherLabel.bottomAnchor, multiplier: 1).isActive = true
        descriptionText.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        descriptionText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25).isActive = true
        descriptionText.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        descriptionText.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/3).isActive = true
        
    }
}
