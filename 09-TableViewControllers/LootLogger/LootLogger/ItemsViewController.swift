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
        if let index = dataModel.ItemStores[newItem.section].allItems.firstIndex(of: newItem) {
            let indexPath = IndexPath(row: index, section: newItem.section)

            // Insert this new row into the table
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    private func handleMarkAsFavourite(itemAt indexPath: IndexPath){
        let item = self.dataModel.ItemStores[indexPath.section].allItems[indexPath.row]
        item.isFavorite = true

        tableView.reloadData() // Update table
        
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
        
        if item.isFavorite{
            cell.textLabel?.text = item.name + " (Favorite)"
        }else
        {
            cell.textLabel?.text = item.name
        }
        
        
        if item.valueInDollars != nil {
            cell.detailTextLabel?.text = "$\(item.valueInDollars ?? 0)"
        }else{
            cell.detailTextLabel?.text = ""
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = self.dataModel.ItemStores[indexPath.section].allItems[indexPath.row]
        
        // Hide default item if there is items
        if item.isDefault, self.dataModel.ItemStores[indexPath.section].allItems.count > 1{
            return 0
        }
        
        return self.tableView.rowHeight
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
        let item = self.dataModel.ItemStores[indexPath.section].allItems[indexPath.row]
        
        // Set default item as uneditable
        if item.isDefault, self.dataModel.ItemStores[indexPath.section].allItems.count == 1{
            return false
        }
        
        return true
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        // If the table view is asking to commit a delete command...
        let item = self.dataModel.ItemStores[indexPath.section].allItems[indexPath.row]
        
        if editingStyle == .delete, item.isDefault == false {
            let item = self.dataModel.ItemStores[indexPath.section].allItems[indexPath.row]
            // Remove the item from the store
            self.dataModel.removeItem(item)

            // Also remove that row from the table view with an animation
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView,
                            moveRowAt sourceIndexPath: IndexPath,
                            to destinationIndexPath: IndexPath) {
        let item = self.dataModel.ItemStores[sourceIndexPath.section].allItems[sourceIndexPath.row]
        
        if sourceIndexPath.section == destinationIndexPath.section, item.isDefault == false{
            // Move item in dataModel
            self.dataModel.moveItem(in: sourceIndexPath.section, from: sourceIndexPath.row, to: destinationIndexPath.row)
        }else{
            // Update table if the movement is invaild
            tableView.reloadData()
        }
        
    }
    
    override func tableView(_ tableView: UITableView,
                            leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?{
        let action = UIContextualAction(style: .normal,
                                        title: "Favourite") { [weak self] (action, view, completionHandler) in
                                            self?.handleMarkAsFavourite(itemAt: indexPath)
                                            completionHandler(true)
        }
        action.backgroundColor = .systemBlue
        
        return UISwipeActionsConfiguration(actions: [action])
    }

}
