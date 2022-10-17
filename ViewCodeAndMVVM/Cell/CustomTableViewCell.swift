//
//  CustomTableViewCell.swift
//  ViewCodeAndMVVM
//
//  Created by user218997 on 11/07/22.
//

import UIKit

protocol CustomTableViewCellDelegate: AnyObject {
    func tappedHeartButton(_ user: User)
}

class CustomTableViewCell: UITableViewCell {
    
    var viewModel: CustomCellViewModel?
    
    var screen: CustomTableViewCellScreen = CustomTableViewCellScreen()
    
    private weak var delegate: CustomTableViewCellDelegate?
    
    public func delegate(delegate: CustomTableViewCellDelegate?) {
        self.delegate = delegate
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
       /* screen.layer.borderWidth = 1
        screen.layer.cornerRadius = 20
        screen.layer.borderColor = CGColor(red: 0.82, green: 0.84, blue: 0.87, alpha: 1.0)*/
        self.screen.heartButton.addTarget(self, action: #selector(tappedHeartButton), for: .touchUpInside)
        self.screen.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.screen)
        self.configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tappedHeartButton() {
        
        guard let _viewModel = viewModel else { return }
        
        if _viewModel.getIsEnableHeart {
            self.screen.heartButton.tintColor = .blue
            self.viewModel?.exchangeHeartState(false)
        } else {
            self.screen.heartButton.tintColor = .red
            self.viewModel?.exchangeHeartState(true)
        }
        self.delegate?.tappedHeartButton(_viewModel.getUser)
        
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
        
            screen.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            screen.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            screen.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            screen.topAnchor.constraint(equalTo: self.topAnchor),
            
        ])
    }
    
    func setupCell(user: User) {
        self.viewModel = CustomCellViewModel(data: user)
        
        self.screen.userImageView.image = UIImage(systemName: self.viewModel?.getUserImage ?? "")
        self.screen.nameLabel.text = self.viewModel?.getName
        self.screen.ageLabel.text = self.viewModel?.getAge
        self.screen.professionLabel.text = self.viewModel?.getProfession
        self.screen.salaryLabel.text = self.viewModel?.getSalary
        
        if self.viewModel?.getIsEnableHeart ?? false {
            self.screen.heartButton.tintColor = .red
        } else {
            self.screen.heartButton.tintColor = .blue
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
