// 
//  Copyright © 2020 Big Nerd Ranch
//

import UIKit

class ItemsViewController: UITableViewController {
    
    var dataModel: DataModel!
    
    @IBAction func toggleEditingMode(_ sender: UIButton) {
        // If you are currently in editing mode...
        if isEditing {
            // Change text of button to inform user of state
            sender.setTitle("Edit", for: .normal)

            // Turn off editing mode
            setEditing(false, animated: true)
        } else {
            // Change text of button to inform user of state
            sender.setTitle("Done", for: .normal)

            // Enter editing mode
            setEditing(true, animated: true)
        }
    }
    
    @IBAction func addNewItem(_ sender: UIButton) {
        // Create a new item and add it to the store
        let newItem = dataModel.createItem()

        // Figure out where that item is in the array
        if let index = dataModel.ItemStores[0].allItems.firstIndex(of: newItem) {
            let indexPath = IndexPath(row: index, section: 0)

            // Insert this new row into the table
            tableView.insertRows(at: [indexPath], with: .automatic)
        }else if let index = dataModel.ItemStores[1].allItems.firstIndex(of: newItem){
            let indexPath = IndexPath(row: index, section: 1)

            // Insert this new row into the table
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataModel.ItemStores.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataModel.ItemStores[section].allItems.count
    }
    
    override func tableView(_ tableView: UITableView,
        titleForHeaderInSection section: Int) -> String? {
        return self.dataModel.ItemStores[section].name
    }

    
    override func tableView(_ tableView: UITableView,
            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get a new or recycled cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell",
            for: indexPath)
        
        // Set the text on the cell with the description of the item
        // that is at the nth index of items, where n = row this cell
        // will appear in on the table view
        let item = self.dataModel.ItemStores[indexPath.section].allItems[indexPath.row]

        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "$\(item.valueInDollars)"

        return cell
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        // If the table view is asking to commit a delete command...
        if editingStyle == .delete {
            let item = self.dataModel.ItemStores[indexPath.section].allItems[indexPath.row]
            // Remove the item from the store
            self.dataModel.ItemStores[indexPath.section].removeItem(item)

            // Also remove that row from the table view with an animation
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView,
                            moveRowAt sourceIndexPath: IndexPath,
                            to destinationIndexPath: IndexPath) {
        // Update the model
        
        if sourceIndexPath.section == destinationIndexPath.section{
            self.dataModel.ItemStores[sourceIndexPath.section].moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
        }else{
            tableView.reloadData()
        }
        
    }

}
