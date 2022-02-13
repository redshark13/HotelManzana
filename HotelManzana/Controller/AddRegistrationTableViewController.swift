//
//  AddRegistrationTableViewController.swift
//  HotelManzana
//
//  Created by Ripley Roane on 2/4/22.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController, SelectRoomTypeTableViewControllerDelegate {
    func didSelect(roomType: RoomType) {
        self.roomType = roomType
        updateRoomType()
    }
    var registrations: [Registration] = []
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    // Date Picker Section
    
    @IBOutlet weak var checkInDateLabel: UILabel!
    @IBOutlet weak var checkInDatePicker: UIDatePicker!
    @IBOutlet weak var checkOutDateLabel: UILabel!
    @IBOutlet weak var checkOutDatePicker: UIDatePicker!
    
    
    
// Number of Guests Section
    @IBOutlet weak var numberOfAdultsLabel: UILabel!
    @IBOutlet weak var numberOfAdultsStepper: UIStepper!
    @IBOutlet weak var numberOfChildrenLabel: UILabel!
    @IBOutlet weak var numberOfChildrenStepper: UIStepper!
    
// wifi Section
    @IBOutlet weak var wifiSwitch: UISwitch!
 // room Section
    @IBOutlet weak var roomTypeLabel: UILabel!
    
    var roomType: RoomType?
    
    
    func updateRoomType(){
        if let roomType = roomType {
            roomTypeLabel.text = roomType.name
        } else{
            roomTypeLabel.text = "Not Set"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let midnightToday = Calendar.current.startOfDay(for: Date())
      checkInDatePicker.minimumDate = midnightToday

        checkOutDatePicker.minimumDate = checkInDatePicker.date.addingTimeInterval(86400)
        updateDateViews()
        updateNumberOfGuests()
        updateRoomType()
    }
      
    
    // Table View Delegate Methods
    
    let checkInDatePickerCellIndexPath = IndexPath(row: 1, section: 1)
    let checkOutDatePickerCellIndexPath = IndexPath(row: 3, section: 1)
    
    var isCheckInDatePickerShown: Bool = false {
        didSet{
            checkInDatePicker.isHidden = !isCheckInDatePickerShown
        }
    }
    var isCheckOutDatePickerShown: Bool = false {
        didSet{
            checkOutDatePicker.isHidden = !isCheckOutDatePickerShown
        }
    }
    
    // Table View Height For Row At
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        switch (indexPath.section, indexPath.row) {
        case (checkInDatePickerCellIndexPath.section, checkInDatePickerCellIndexPath.row):
            if isCheckInDatePickerShown {
                return 216.0
            } else {
                return 0.0
            }
            case(checkOutDatePickerCellIndexPath.section, checkOutDatePickerCellIndexPath.row):
                if isCheckOutDatePickerShown{
                    return 216.0
                } else {
                    return  0.0
                }
        default:
            return 44.0
            }
        }
    
    // Table View didSelectRowAt
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch (indexPath.section, indexPath.row){
        case(checkInDatePickerCellIndexPath.section, checkInDatePickerCellIndexPath.row - 1):
            
            if isCheckInDatePickerShown{
                isCheckInDatePickerShown = false
            }else if isCheckOutDatePickerShown {
                isCheckOutDatePickerShown = false
                isCheckInDatePickerShown = true
            }else{
                isCheckInDatePickerShown = true
            }
            tableView.beginUpdates()
            tableView.endUpdates()
            
        case(checkOutDatePickerCellIndexPath.section, checkOutDatePickerCellIndexPath.row - 1):
            if isCheckOutDatePickerShown{
                isCheckOutDatePickerShown = false
            } else if isCheckInDatePickerShown {
                isCheckInDatePickerShown = false
                        isCheckOutDatePickerShown = true
        }else {
            isCheckOutDatePickerShown = true
        }
        tableView.beginUpdates()
        tableView.endUpdates()
        
    default:
        break
    }
}

  // prepare (for: sender)
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectRoomType" {
            let destinationViewController = segue.destination as?
            SelectRoomTypeTableViewController
            destinationViewController?.delegate = self
            destinationViewController?.roomType = roomType
        }
    }
    
    
    @IBAction func unwindFromAddRegistration(unwindSegue: UIStoryboardSegue){
        guard let addRegistrationTableViewController = unwindSegue.source as? AddRegistrationTableViewController,
              let registration = addRegistrationTableViewController.registration else
        {return}
        registrations.append(registration)
        tableView.reloadData()
    }
    
    var registration: Registration? {
    guard let roomType = roomType else {return nil}
    
        let firstName = firstNameTextField.text ?? ""
               let lastName = lastNameTextField.text ?? ""
               let email = emailTextField.text ?? ""
               let checkInDate = checkInDatePicker.date
               let checkOutDate = checkOutDatePicker.date
               let numberOfAdults = Int(numberOfAdultsStepper.value)
               let numberOfChildren = Int(numberOfChildrenStepper.value)
               let hasWifi = wifiSwitch.isOn
               
               return Registration(
                   firstName: firstName,
                   lastName: lastName,
                   emailAddress: email,
                   checkInDate: checkInDate,
                   checkOutDate: checkOutDate,
                   numberOfAdults: numberOfAdults,
                   numberOfChildren: numberOfChildren,
                   roomType: roomType,
                   wifi: hasWifi
               )
           }
           
        
    

    
    @IBAction func doneBarButtonTapped(_ sender: UIBarButtonItem){
        
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        
        // Date Picker Section
        
        let checkInDate = checkInDatePicker.date
        let checkOutDate = checkOutDatePicker.date
        
        // Number of Guests Section
        
        let numberOfAdults = Int(numberOfAdultsStepper.value)
        let numberOfChildren = Int(numberOfChildrenStepper.value)
        
        // wifi Section
        
        let hasWifi = wifiSwitch.isOn
            
            // room Choice Section
            
        let roomChoice = roomType?.name ?? "Not Set"
            
            
            print("Done Tapped")
            print("firstName: \(firstName)")
            print("lastName: \(lastName)")
            print("email: \(email)")
            
            // Printing Date Picker Section
            
            print("checkIn: \(checkInDate)")
            print("checkOut: \(checkOutDate)")
            
            // Printing Number of Guests Section
            
            print("numberOfAdults: \(numberOfAdults)")
            print("numberOfChildren: \(numberOfChildren)")
            
            // Printing Wifi Section
            
            print("wifi: \(hasWifi)")
            
            // Printing room choice
            
            print("roomType: \(roomChoice)")
            
    }
    
    // Date Picker Section UpdateView()
    
    func updateDateViews(){
       // checkOutDatePicker.minimumDate = checkInDatePicker.date.addingTimeInterval(86400)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
     checkInDateLabel.text = dateFormatter.string(from:checkInDatePicker.date)
        checkOutDateLabel.text = dateFormatter.string(from: checkOutDatePicker.date)
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker){
        updateDateViews()
    }
    
    func updateNumberOfGuests() {
        numberOfAdultsLabel.text = "\(Int(numberOfAdultsStepper.value))"
        numberOfChildrenLabel.text = "\(Int(numberOfChildrenStepper.value))"
    }
    @IBAction func stepperValueChanged(_ sender: UIStepper){
        updateNumberOfGuests()
    }
    @IBAction func wifiSwitchChanged(_ sender: UISwitch){
        // implemented later
    }
    @IBAction func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    }

