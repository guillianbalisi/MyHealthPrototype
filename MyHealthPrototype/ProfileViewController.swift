//
//  ProfileViewController.swift
//  MyHealthPrototype
//
//  Created by Guillian Balisi on 2016-10-12.
//  Copyright © 2016 Guillian Balisi. All rights reserved.
//

import UIKit
import ResearchKit
import HealthKit

import UIKit
import ResearchKit
import HealthKit

class ProfileViewController: UITableViewController, HealthClientType {
    // MARK: Properties
    
    let healthObjectTypes = [
        HKObjectType.characteristicType(forIdentifier: HKCharacteristicTypeIdentifier.dateOfBirth)!,
        HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!,
        HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!
    ]
    
    var healthStore: HKHealthStore?
    
    @IBOutlet var applicationNameLabel: UILabel!
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //guard let healthStore = healthStore else { fatalError("healthStore not set") }
        
        // Ensure the table view automatically sizes its rows.
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Request authrization to query the health objects that need to be shown.
        let typesToRequest = Set<HKObjectType>(healthObjectTypes)
        healthStore?.requestAuthorization(toShare: nil, read: typesToRequest) { authorized, error in
            guard authorized else { return }
            
            // Reload the table view cells on the main thread.
            OperationQueue.main.addOperation() {
                let allRowIndexPaths = self.healthObjectTypes.enumerated().map { (index, element) in return IndexPath(row: index, section: 0) }
                self.tableView.reloadRows(at: allRowIndexPaths, with: .automatic)
            }
        }
    }
    
    // MARK: UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return healthObjectTypes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileStaticTableViewCell.reuseIdentifier, for: indexPath) as? ProfileStaticTableViewCell else { fatalError("Unable to dequeue a ProfileStaticTableViewCell") }
        let objectType = healthObjectTypes[(indexPath as NSIndexPath).row]
        
        switch(objectType.identifier) {
        case HKCharacteristicTypeIdentifier.dateOfBirth.rawValue:
            configureCellWithDateOfBirth(cell)
            
        case HKQuantityTypeIdentifier.height.rawValue:
            let title = NSLocalizedString("Height", comment: "")
            configureCell(cell, withTitleText: title, valueForQuantityTypeIdentifier: objectType.identifier)
            
        case HKQuantityTypeIdentifier.bodyMass.rawValue:
            let title = NSLocalizedString("Weight", comment: "")
            configureCell(cell, withTitleText: title, valueForQuantityTypeIdentifier: objectType.identifier)
            
        default:
            fatalError("Unexpected health object type identifier - \(objectType.identifier)")
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: Cell configuration
    
    func configureCellWithDateOfBirth(_ cell: ProfileStaticTableViewCell) {
        // Set the default cell content.
        cell.titleLabel.text = NSLocalizedString("Date of Birth", comment: "")
        cell.valueLabel.text = NSLocalizedString("-", comment: "")
        
        // Update the value label with the date of birth from the health store.
        guard let healthStore = healthStore else { return }
        
        do {
            let dateOfBirth = try healthStore.dateOfBirth()
            let now = Date()
            
            let ageComponents = Calendar.current.dateComponents([.year], from: dateOfBirth, to: now)
            let age = ageComponents.year
            
            cell.valueLabel.text = "\(age)"
        }
        catch {
        }
    }
    
    func configureCell(_ cell: ProfileStaticTableViewCell, withTitleText titleText: String, valueForQuantityTypeIdentifier identifier: String) {
        // Set the default cell content.
        cell.titleLabel.text = titleText
        cell.valueLabel.text = NSLocalizedString("-", comment: "")
        
        /*
         Check a health store has been set and a `HKQuantityType` can be
         created with the identifier provided.
         */
        guard let healthStore = healthStore, let quantityType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier(rawValue: identifier)) else { return }
        
        // Get the most recent entry from the health store.
        healthStore.mostRecentQauntitySampleOfType(quantityType) { quantity, _ in
            guard let quantity = quantity else { return }
            
            // Update the cell on the main thread.
            OperationQueue.main.addOperation() {
                guard let indexPath = self.indexPathForObjectTypeIdentifier(identifier) else { return }
                guard let cell = self.tableView.cellForRow(at: indexPath) as? ProfileStaticTableViewCell else { return }
                
                cell.valueLabel.text = "\(quantity)"
            }
        }
    }
    
    // MARK: Convenience
    
    func indexPathForObjectTypeIdentifier(_ identifier: String) -> IndexPath? {
        for (index, objectType) in healthObjectTypes.enumerated() where objectType.identifier == identifier {
            return IndexPath(row: index, section: 0)
        }
        
        return nil
    }
}
