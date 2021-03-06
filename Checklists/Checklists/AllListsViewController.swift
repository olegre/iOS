//
//  AllListsViewController.swift
//  Checklists
//
//  Created by legr on 20/11/15.
//  Copyright © 2015 legr. All rights reserved.
//

import UIKit

class AllListsViewController: UITableViewController, ListDetailViewControllerDelegate {

    var lists: [Checklist]
    
    required init?(coder aDecoder: NSCoder) {
        self.lists = [Checklist]()
        super.init(coder: aDecoder)
        
        var list = Checklist(name: "Birthdays")
        lists.append(list)
        list = Checklist(name: "Groceries")
        lists.append(list)
        list = Checklist(name: "Cool Apps")
        lists.append(list)
        list = Checklist(name: "To Do")
        lists.append(list)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.lists.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.cellForTableView(tableView)
        let checklist = lists[indexPath.row]
        cell.textLabel!.text = checklist.name
        cell.accessoryType = .DetailDisclosureButton
        return cell
    }
    
    func cellForTableView(tableView: UITableView) -> UITableViewCell {
        let cellIdentifier = "Cell"
        if let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) {
        return cell
    } else {
        return UITableViewCell(style: .Default, reuseIdentifier: cellIdentifier)
        }
    }

    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
            lists.removeAtIndex(indexPath.row)
            
            let indexPaths = [indexPath]
            self.tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Bottom)
    }
    
    // MARK: - Segue
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            let checklist = self.lists[indexPath.row]
            performSegueWithIdentifier("ShowChecklist", sender: checklist)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowChecklist"{
            let controller = segue.destinationViewController as! ChecklistViewController
            controller.checklist = sender as! Checklist
        } else if segue.identifier == "AddChecklist" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! ListDetailViewController
            controller.delegate = self
            controller.checklistToEdit = nil
        }
    }
    
    func listDetailViewControllerDidCancel(controller: ListDetailViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func listDetailViewController(controller: ListDetailViewController, didFinishAddingChecklist checklist: Checklist) {
        let newRowIndex = lists.count
        lists.append(checklist)
        let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)
        let indexPaths = [indexPath]
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func listDetailViewController(controller: ListDetailViewController, didFinishEditingChecklist checklist: Checklist) {
        if let index = lists.indexOf(checklist) {
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            if let cell = self.tableView.cellForRowAtIndexPath(indexPath) {
                cell.textLabel!.text = checklist.name
            }
        }
        dismissViewControllerAnimated(true, completion: nil)
    }

    
}
