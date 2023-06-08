//
//  ViewController.swift
//  3m.7hw
//
//  Created by Meerim Mamatkadyrova on 5/6/23.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    private var catalog: [Catalog] = []
    private var isFiltering: Bool = false
    private var filteredMenu: [Catalog] = []
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.layer.borderColor = UIColor.white.cgColor
        searchBar.layer.borderWidth = 1.0
        searchBar.clipsToBounds = true
        searchBar.placeholder = "Search..."
        return searchBar
    }()
    
    private let buttonLabel: UILabel = {
        let label = UILabel()
        label.text = "Or Select via map?"
        label.textColor = .tintColor
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    private let view1: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray3
        return view
    }()
    
    private let view2: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray3
        return view
    }()
    
    private var mainTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        return tableView
    }()
    
    private let doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Done", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .tintColor
        button.layer.cornerRadius = 24
        button.addTarget(self, action: #selector(done), for: .touchUpInside)
        return button
    }()
    
    @objc func done() {
        print("tapped")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(searchBar)
        view.addSubview(buttonLabel)
        view.addSubview(view1)
        view.addSubview(view2)
        view.addSubview(mainTableView)
        view.addSubview(doneButton)
        
        mainTableView.dataSource = self
        mainTableView.delegate = self
        
        searchBar.delegate = self
        
        mainTableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        
        initData()
        
        searchBar.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(100)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        view1.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(searchBar.snp.bottom).offset(40)
            make.height.equalTo(1)
            make.width.equalTo(100)
        }
        
        buttonLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(view1)
        }
        
        view2.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(searchBar.snp.bottom).offset(40)
            make.height.equalTo(1)
            make.width.equalTo(100)
        }
        
        mainTableView.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(20)
            make.top.equalTo(buttonLabel.snp.bottom).offset(5)
            make.bottom.equalToSuperview().offset(0)
        }
        
        doneButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-100)
            make.trailing.leading.equalToSuperview().inset(20)
            make.height.equalTo(45)
        }
        
    }
    
    private func initData() {
        catalog = [Catalog(name: "ABC Company", address: "Jl. Merah Biru Nomor 123"),
                    Catalog(name: "PQR Company", address: "Jl. Merah Biru Nomor 456"),
                    Catalog(name: "XYZ Company", address: "Jl. Merah Biru Nomor 789"),
                    Catalog(name: "ABCD Company", address: "Jl. Merah Hijau Nomor 123"),
                    Catalog(name: "PQRS Company", address: "Jl. Biru Kuning Nomor 123"),
                    Catalog(name: "WXYZ Company", address: "Jl. Biru Hijau Nomor 123")]
    }
    
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltering ? filteredMenu.count : catalog.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.setData(name: isFiltering ?
                     filteredMenu[indexPath.row].name : catalog[indexPath.row].name,
                     address: isFiltering ?
                     filteredMenu[indexPath.row].address : catalog[indexPath.row].address)
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            isFiltering = false
        }else{
            isFiltering = true
            filteredMenu = catalog.filter({$0.name.lowercased().contains(searchText.lowercased()) || $0.address.lowercased().contains(searchText.lowercased())})
        }
        
        mainTableView.reloadData()
    }
}
