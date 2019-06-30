//
//  ResultsCell.swift
//  Cubee
//
//  Created by Tomasz Kielar on 28/06/2019.
//  Copyright © 2019 Tomasz Kielar. All rights reserved.
//

import UIKit

class ResultsCell: UITableViewCell {
    let insideView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let timeLabel : UILabel = {
        let label = UILabel()
        label.text = "You have no results yet."
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    func setView() {
        addSubview(insideView)
        insideView.addSubview(timeLabel)
        self.selectionStyle = .none
        
        NSLayoutConstraint.activate([
            insideView.topAnchor.constraint(equalTo: self.topAnchor),
            insideView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            insideView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            insideView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            timeLabel.centerXAnchor.constraint(equalTo: insideView.centerXAnchor),
            timeLabel.centerYAnchor.constraint(equalTo: insideView.centerYAnchor)

            ])
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
