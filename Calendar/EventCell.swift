//
//  EventCell.swift
//  Calendar
//
//  Created by 逸唐陳 on 2018/9/6.
//  Copyright © 2018年 逸唐陳. All rights reserved.
//

import Foundation
import UIKit

class EventCell: UICollectionViewCell {
    
    let eventTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .blue
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(eventTitle)
        eventTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25).isActive = true
        eventTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25).isActive = true
        eventTitle.heightAnchor.constraint(equalToConstant: 22).isActive = true
        eventTitle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
