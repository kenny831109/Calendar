//
//  CalendarCell.swift
//  Calendar
//
//  Created by 逸唐陳 on 2018/8/21.
//  Copyright © 2018年 逸唐陳. All rights reserved.
//

import UIKit

class CalendarCell: UICollectionViewCell {
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    let dotView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.layer.cornerRadius = 1
        return view
    }()
    
    var event: [String] = [] {
        didSet {
            if event.count > 0 {
                dotView.isHidden = false
            }else {
                dotView.isHidden = true
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(dateLabel)
        dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        contentView.addSubview(dotView)
        dotView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        dotView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        dotView.widthAnchor.constraint(equalToConstant: 2).isActive = true
        dotView.heightAnchor.constraint(equalToConstant: 2).isActive = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dotView.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
