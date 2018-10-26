//
//  Answer_TableViewController.swift
//  Chatference
//
//  Created by James Francis on 2018/10/25.
//  Copyright © 2018 Ryno Claassen. All rights reserved.
//

import Foundation
import UIKit

class Answer_TableViewController: UITableViewController {

    @IBOutlet weak var answersTableView: UITableView!

    var comments: [Comment] = [Comment(question: "Initial question", roomUuid: SessionService.shared.room!.uuid, state: 1, votes: 5)]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // This will cause the tableview to autolayout the height for the cell, as the content is dynamic
        tableView.estimatedRowHeight = 50.0
        tableView.rowHeight = UITableView.automaticDimension
        
        CommentApi().getComments(room: SessionService.shared.room!) { (comment) in
            self.comments.append(comment)
            self.tableView.reloadData()
        }
    }
}

//MARK: - TableView Datasource
extension Answer_TableViewController {

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear

        let label = UILabel(frame: CGRect(x: 16, y: 0, width: self.view.frame.width - 16, height: 30))
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.init(red: 37.0/255.0, green: 158.0/255.0, blue: 154.0/255.0, alpha: 1)
        label.text = "TOP QUESTIONS & COMMENTS"
        view.addSubview(label)

        let separator = UIView(frame: CGRect(x: 0, y:29, width: self.view.frame.width, height:1))
        separator.backgroundColor = UIColor(red: 214.0/255.0, green: 214.0/255.0, blue: 214.0/255.0, alpha: 1)
        view.addSubview(separator)

        return view
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

         let cell: Answer_TableViewCell = tableView.dequeueReusableCell(withIdentifier: "AnswerCellIdentifier") as! Answer_TableViewCell

        cell.answerLabel.text = comments[indexPath.row].question
        cell.nameLabel.text = comments[indexPath.row].roomUuid
        cell.voteLabel.text = ("\(comments[indexPath.row].votes)")
        
        return cell
    }
}

//MARK: - TableView Delegate
extension Answer_TableViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

