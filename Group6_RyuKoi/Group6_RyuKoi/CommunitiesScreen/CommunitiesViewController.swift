//
//  CommunitiesViewController.swift
//  RyūKoi
//
//  Created by Allison Lee on 11/13/25.
//
//MARK: TODO
// need to add plus button to event title label later...

import UIKit

class CommunitiesViewController: UIViewController {
    let communitiesScreen = CommunitiesView()
    let events = ["event", "event", "event", "event", "event", "event"]
    
    override func loadView() {
        view = communitiesScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        // remove separator line between cells
        communitiesScreen.tableViewEvents.separatorStyle = .none
        
        
        //MARK: patching the table view delegate and datasource to controller...
        communitiesScreen.tableViewEvents.delegate = self
        communitiesScreen.tableViewEvents.dataSource = self
    }
    
    @objc func openProfile() {
        let profileScreen = ProfileViewController()
        navigationController?.pushViewController(profileScreen, animated: true)
    }
}

extension CommunitiesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "events", for: indexPath) as! CommunitiesTableViewCell
        
        let leftIndex = indexPath.row * 2
        let rightIndex = leftIndex + 1
        
        cell.leftLabel.text = events[leftIndex]
        
        if rightIndex < events.count {
            cell.rightEventView.isHidden = false
            cell.rightLabel.text = events[rightIndex]
        } else {
            // Hide right box if odd number of lessons
            cell.rightEventView.isHidden = true
        }
        
        return cell
    }
}
