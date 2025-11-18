//
//  TopNavigationBarView.swift
//  RyuKoi
//
//  Created by R M on 11/16/25.
//

import UIKit

class TopNavigationBarView: UIView {
    var logo: UIButton!
    var searchBar: UISearchBar!
    var account: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupLogo()
        setupSearchBar()
        setupAccount()
        initConstraints()
    }
    
    func setupLogo() {
        logo = UIButton(type: .custom)
        logo.setImage(UIImage(named: "Logo"), for: .normal)
        logo.imageView?.contentMode = .scaleAspectFit
        logo.translatesAutoresizingMaskIntoConstraints = false
        addSubview(logo)
    }
    
    func setupSearchBar() {
        searchBar = UISearchBar()
        searchBar.placeholder = "Search lessons..."
        //searchBar.isUserInteractionEnabled = false
        searchBar.layer.cornerRadius = 10
        searchBar.backgroundColor = UIColor(red: 1.0, green: 248/255, blue: 232/255, alpha: 1.0)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        addSubview(searchBar)
    }
    
    func setupAccount() {
        account = UIButton(type: .system)
        account.setImage(UIImage(systemName: "person.crop.circle"), for: .normal)
        account.tintColor = .black
        //account.imageView?.contentMode = .scaleAspectFit
        account.translatesAutoresizingMaskIntoConstraints = false
        addSubview(account)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            logo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            logo.centerYAnchor.constraint(equalTo: centerYAnchor),
            logo.widthAnchor.constraint(equalToConstant: 40),
            logo.heightAnchor.constraint(equalToConstant: 40),
            
            account.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            account.centerYAnchor.constraint(equalTo: centerYAnchor),
            account.widthAnchor.constraint(equalToConstant: 50),
            account.heightAnchor.constraint(equalToConstant: 50),
            
            searchBar.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: 12),
            searchBar.trailingAnchor.constraint(equalTo: account.leadingAnchor, constant: -12),
            searchBar.centerYAnchor.constraint(equalTo: centerYAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 36),

        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
