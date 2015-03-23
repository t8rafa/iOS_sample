//
//  SecondViewController.swift
//  Sample
//
//  Created by Rafael Alencar Trisotto on 22/03/15.
//  Copyright (c) 2015 T8 Studio de Tecnologia. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, ApiListener {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var informationView: UIView!
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var informationHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableTopConstraint: NSLayoutConstraint!
    
    let textCellIdentifier = "textCell"
    let rangeCellIdentifier = "rangeCell"
    let pickerCellIdentifier = "pickerCell"
    let textTag = 1
    let pickerTag = 3
    
    let viewModel = RegistrationViewModel()
    
    var pickerCurrentIndexPath: NSIndexPath?
    var hasInvalidData = false
    var invalidDataTextView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = NSLocalizedString("registration_title", comment: "")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: "validateData")
        
        invalidDataTextView.text = NSLocalizedString("registration_invalid", comment: "");
        invalidDataTextView.textColor = UIColor.redColor()
        invalidDataTextView.font = UIFont.preferredFontForTextStyle(UIFontTextStyleFootnote)
        invalidDataTextView.textAlignment = NSTextAlignment.Right
        invalidDataTextView.editable = false
        invalidDataTextView.selectable = false
        invalidDataTextView.textContainerInset = UIEdgeInsetsMake(10, 0, 0, 10)
        invalidDataTextView.backgroundColor = UIColor.clearColor()
        invalidDataTextView.hidden = true
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBarHidden = false
    }
    
    override func viewWillDisappear(animated: Bool) {
        navigationController?.navigationBarHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Private methods
    func indexPathHasTextBox(indexPath: NSIndexPath) -> Bool {
        return indexPath.section == 0
    }
    
    func indexPathHasRangeCell(indexPath: NSIndexPath) -> Bool {
        return indexPath.section == 1
    }
    
    func indexPathHasPicker(indexPath: NSIndexPath) -> Bool {
        if let pickerIndexPath = pickerCurrentIndexPath {
            return pickerIndexPath.row == indexPath.row
        }
        
        return false
    }
    
    func hasPickerInIndexPath(indexPath: NSIndexPath) -> Bool {
        var result = false
        
        var targetRow = indexPath.row
        ++targetRow
        
        let pickerCell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: targetRow, inSection: indexPath.section))
        
        if let picker = pickerCell?.viewWithTag(pickerTag) {
            result = true
        }
        
        return result
    }
    
    func displayInlinePickerForRowAtIndexPath(indexPath: NSIndexPath) {
        tableView.beginUpdates()
        
        var before = false
        var sameCellClicked = false
        if let pickerIndexPath = pickerCurrentIndexPath {
            before = pickerIndexPath.row < indexPath.row
            sameCellClicked = pickerIndexPath.row - 1 == indexPath.row
            
            tableView.deleteRowsAtIndexPaths([pickerIndexPath], withRowAnimation: .Fade)
            
            pickerCurrentIndexPath = nil
        }
        
        if !sameCellClicked {
            let rowToReveal = before ? indexPath.row - 1 : indexPath.row
            let indexPathToReveal = NSIndexPath(forRow: rowToReveal, inSection: indexPath.section)
            
            togglePickerForIndexPath(indexPathToReveal)
            pickerCurrentIndexPath = NSIndexPath(forRow: indexPathToReveal.row + 1, inSection: indexPathToReveal.section)
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        tableView.endUpdates()
        
        updatePicker()
    }
    
    func togglePickerForIndexPath(indexPath: NSIndexPath) {
        tableView.beginUpdates()
        
        let indexPaths = [NSIndexPath(forRow: indexPath.row + 1, inSection: indexPath.section)]
        
        if hasPickerInIndexPath(indexPath) {
            tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Fade)
        } else {
            tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Fade)
        }
        
        tableView.endUpdates()
    }
    
    func updatePicker() {
        if let pickerIndexPath = pickerCurrentIndexPath {
            let pickerCell = tableView.cellForRowAtIndexPath(pickerIndexPath)
            
            if let pickerView = pickerCell?.viewWithTag(pickerTag) {
                let item = viewModel.skillsDataSource[pickerIndexPath.row - 1]
                let picker = pickerView as UIPickerView
                picker.selectRow(item.value!, inComponent: 0, animated: true)
            }
            
        }
    }
    
    func textFieldValueForIndexPath(indexPath: NSIndexPath) -> String {
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            if let textView = cell.viewWithTag(textTag) {
                let textField = textView as UITextField
                return textField.text
            }
        }
        
        return ""
    }
    
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.candidateDataSource.count
        } else {
            var result = viewModel.skillsDataSource.count
            
            if let pickerIndexPath = pickerCurrentIndexPath {
                ++result
            }
            
            return result
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var reuseIdentifier = textCellIdentifier
        
        if indexPathHasPicker(indexPath) {
            reuseIdentifier = pickerCellIdentifier
        } else if indexPathHasRangeCell(indexPath) {
            reuseIdentifier = rangeCellIdentifier
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier) as UITableViewCell
        
        if reuseIdentifier == textCellIdentifier {
            let item = viewModel.candidateDataSource[indexPath.row]
            
            var textField = cell.viewWithTag(textTag) as UITextField
            textField.placeholder = NSLocalizedString(item.title, comment: "")
            textField.text = item.value
            
            if item.title == "registration_email" {
                textField.keyboardType = .EmailAddress
                textField.autocapitalizationType = .None
            } else {
                textField.keyboardType = .ASCIICapable
                textField.autocapitalizationType = .Words
            }
        }
        
        if reuseIdentifier == rangeCellIdentifier {
            
            var itemIndex = indexPath.row
            
            if let pickedIndexPath = pickerCurrentIndexPath {
                if pickedIndexPath.row <= indexPath.row {
                    --itemIndex
                }
            }
            
            let item = viewModel.skillsDataSource[itemIndex]
            
            cell.textLabel?.text = item.title
            cell.detailTextLabel?.text = "\(item.value!)"
        }
        
        
        return cell
    }
    
    
    // MARK: - Table View delegate
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var result = NSLocalizedString("registration_section1_title", comment: "")
        
        if section == 1 {
            result = NSLocalizedString("registration_section2_title", comment: "")
        }
        
        return result
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == 1 {
            return NSLocalizedString("registration_section2_footer", comment: "")
        }
        
        return nil
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            return invalidDataTextView
        }
        
        return nil
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 1 && indexPathHasPicker(indexPath) {
            return 162.0
        }
        
        return 44.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        if cell?.reuseIdentifier == rangeCellIdentifier {
            displayInlinePickerForRowAtIndexPath(indexPath)
        } else {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField.keyboardType == .ASCIICapable {
            
            if let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0)) {
                if let emailField = tableView.viewWithTag(textTag) {
                    emailField.becomeFirstResponder()
                }
            }
            
        }
        
        if textField.keyboardType == .EmailAddress {
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    
    // MARK: UIPickerViewDataSource
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 11
    }
    
    // MARK: UIPickerViewDelegate
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return "\(row)"
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let pickerIndexPath = pickerCurrentIndexPath {
            let itemIndex = pickerIndexPath.row - 1
            viewModel.skillsDataSource[itemIndex].value = row
            
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: itemIndex, inSection: pickerIndexPath.section))
            cell?.detailTextLabel?.text = "\(row)"
        }
    }
    
    
    // MARK: ApiListener
    
    func onSuccess(response: Response) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.informationView.backgroundColor = UIColor(red: 33/255.0, green: 206/255.0, blue: 153/255.0, alpha: 1.0)
            self.informationLabel.text = NSLocalizedString("registration_success", comment: "")
        })
    }
    
    func onError(response: Response) {
        var message = NSLocalizedString("registration_error", comment: "")
        
        if response.status == "internet_error" {
            message = response.message
        }
        
        if response.status == "rejected" {
            message = NSLocalizedString("registration_rejected", comment: "")
        }
        
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.informationView.backgroundColor = UIColor(red: 237/255.0, green: 85/255.0, blue: 101/255.0, alpha: 1.0)
            self.informationLabel.text = message
        })
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    
    // MARK: Actions
    
    func validateData() {
        viewModel.candidateDataSource[0].value = textFieldValueForIndexPath(NSIndexPath(forRow: 0, inSection: 0))
        viewModel.candidateDataSource[1].value = textFieldValueForIndexPath(NSIndexPath(forRow: 1, inSection: 0))
        
        hasInvalidData = true
    
        if let name = viewModel.candidateDataSource[0].value {
            hasInvalidData = name.isEmpty
        }
        
        if let email = viewModel.candidateDataSource[1].value {
            hasInvalidData = !email.isValidEmail()
        }
        
        if hasInvalidData {
            invalidDataTextView.hidden = false
            
        } else {
            confirmDataBeforeSubmit()
        }
    }
    
    func confirmDataBeforeSubmit() {
        let title = NSLocalizedString("registration_confirm_title", comment: "")
        let message = NSLocalizedString("registration_confirm_text", comment: "")
        
        let alert = AlertFactory.confirmationWithTitle(title, message: message) { (alertAction: UIAlertAction!) -> Void in
            self.saveButtonAction()
        }
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func saveButtonAction() {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        let candidate = Candidate()
        candidate.name = viewModel.candidateDataSource[0].value!
        candidate.email = viewModel.candidateDataSource[1].value!
        candidate.html = viewModel.skillsDataSource[0].value!
        candidate.css = viewModel.skillsDataSource[1].value!
        candidate.javaScript = viewModel.skillsDataSource[2].value!
        candidate.python = viewModel.skillsDataSource[3].value!
        candidate.django = viewModel.skillsDataSource[4].value!
        candidate.ios = viewModel.skillsDataSource[5].value!
        candidate.android = viewModel.skillsDataSource[6].value!
        
        let api = Api(listener: self)
        api.send(candidate)
        
        informationView.backgroundColor = UIColor(red: 101/255.0, green: 109/255.0, blue: 120/255.0, alpha: 1.0)
        informationLabel.text = NSLocalizedString("registration_sending", comment: "")
        
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.informationHeightConstraint.constant = 60
            self.tableTopConstraint.constant = 60
        })
    }
}