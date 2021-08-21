//
//  BusCollectionViewCell.swift
//  BusTicketApp
//
//  Created by Abdullah Coban on 26.07.2021.
//

import UIKit

class BusCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BusCollectionViewCell"
    
    let seatImage = UIImageView()
    let seatNumber = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        seatImage.image = UIImage(named: "seat")
        seatImage.translatesAutoresizingMaskIntoConstraints = false
        seatNumber.text = "45"
        seatNumber.translatesAutoresizingMaskIntoConstraints = false
        arrangeViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func arrangeViews() {
        contentView.addSubview(seatImage)
        contentView.addSubview(seatNumber)
        
        NSLayoutConstraint.activate([
            seatImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            seatImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            seatImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            seatImage.topAnchor.constraint(equalTo: self.topAnchor),
            seatNumber.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            seatNumber.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -10)
        ])
        
    }
    
    public func configure(label: String) {
        seatNumber.text = label
    }
    
    override func prepareForReuse() {
        seatNumber.text = nil
    }
}
