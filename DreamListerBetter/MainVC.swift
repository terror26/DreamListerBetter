//
//  MainVC.swift
//  DreamListerBetter
//
//  Created by Bhawna Verma on 21/05/1939 Saka.
//  Copyright © 1939 Saka Bhawna Verma. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController,UITableViewDelegate,UITableViewDataSource,NSFetchedResultsControllerDelegate {

    @IBOutlet weak var seg: UISegmentedControl!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    
    var Controller:NSFetchedResultsController<Item>!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
     //   generateTestData()
        attemptfetch()

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let obs = Controller.fetchedObjects , obs.count > 0 {
            let item = obs[indexPath.row]
            performSegue(withIdentifier: "itemDetailVC", sender: item)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "itemDetailVC" {
            if let destination = segue.destination as? itemDetailsVC {
                if let item = sender as?Item {
                    destination.itemToEdit = item
                }
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! itemCell
            configurecell(cell: cell, indexpath: indexPath as NSIndexPath)
            return cell
    }
    
    func configurecell(cell:itemCell , indexpath :NSIndexPath) {
        let item = Controller.object(at: indexpath as IndexPath)
        cell.configurecell(item: item)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = Controller.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        return  0
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = Controller.sections {
            return sections.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func attemptfetch() {
        let fetchrequest:NSFetchRequest<Item> = Item.fetchRequest()
        
        let DateSort = NSSortDescriptor(key: "created", ascending: false)
        let PriceSort = NSSortDescriptor(key: "price", ascending: true)
        let titleSort = NSSortDescriptor(key: "title", ascending: true)
        
        if  segment.selectedSegmentIndex == 0 {
        fetchrequest.sortDescriptors = [DateSort]
        } else if segment.selectedSegmentIndex == 1 {
            fetchrequest.sortDescriptors = [PriceSort]
        } else if segment.selectedSegmentIndex == 2 {
            fetchrequest.sortDescriptors = [titleSort]
        }
        
        let controller = NSFetchedResultsController(fetchRequest: fetchrequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
       controller.delegate = self
        
        self.Controller = controller
    
        do {
            try self.Controller.performFetch()
            
        } catch {
            let error = error as NSError
            print("\(error)")
            
        }
    }
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableview.beginUpdates()
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableview.endUpdates()
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch(type) {
        case.insert:
            if let indexpath = newIndexPath {
                tableview.insertRows(at: [indexpath], with: .fade)
            }
            break
        case.delete :
            if let indexpath = indexPath {
                tableview.deleteRows(at: [indexpath], with: .fade)
            }
            break
        case.update:
            if let indexpath = indexPath {
            let cell = tableview.cellForRow(at: indexpath) as!itemCell
            configurecell(cell: cell, indexpath: indexpath as NSIndexPath)
            }
            break
        case.move:
            if let indexpath = indexPath {
                tableview.deleteRows(at: [indexpath], with: .fade)
            }
            if let indexpath = newIndexPath {
                tableview.insertRows(at: [indexpath], with: .fade)
            }
            break
            
        }
        
        
    }
    func generateTestData() {
    let item = Item(context: context)
        item.details = "What do u want "
        item.price = 999
        item.title = "Bose Headphones"
    
        let item1 = Item(context: context)
        item1.details = "kanishk verma is the best guy"
        item1.price = 788888
        item1.title = "Kanishk"
        
        let item2 = Item(context: context)
        item2.details = "amazing ferrarinwith the top speed of 255 mph and its the first car to have reached the top speed of 250 in 2010"
        item2.price = 100000
        item2.title = "Ferrari S Class Mode 110092"
    }
    
    @IBAction func pressed(_ sender: UISegmentedControl) {
        attemptfetch()
        tableview.reloadData()
    }
    
    
    
    
    
    
    
    
    
}

