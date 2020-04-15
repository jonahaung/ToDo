//
//  DatePickerViewController.swift
//  ToDo
//
//  Created by Aung Ko Min on 16/4/20.
//  Copyright © 2020 Aung Ko Min. All rights reserved.
//

import UIKit
import CoreData

protocol DatePickerViewControllerDelegate: class {
    func datePickerViewController(_ controller: DatePickerViewController, didFinishPicking date: Date)
    func datePickerViewController(datePickerDidCancel controller: DatePickerViewController)
}

class DatePickerViewController: UIViewController {
    
    // This is a viewController // Simple
    weak var delegate: DatePickerViewControllerDelegate?
    private var pickedDate: Date?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Pick Target Date"
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDoneButton))
        navigationItem.rightBarButtonItem = doneButton
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancelButton))
        navigationItem.leftBarButtonItem = cancelButton
        
        // so let's add actual datePicker
        addDatePicker()
    }
    
    @objc private func didTapDoneButton() {
        if let pickedDate = self.pickedDate {
            
            // when done button pressed, will will also have to dismiss the datePicker
            self.dismiss(animated: true) {
                self.delegate?.datePickerViewController(self, didFinishPicking: pickedDate)
            }
        }else {
            // If date is not picked, we will show error
            self.showError(title: "Error", message: "Date is not picked")
        }
        
    }
    @objc private func didTapCancelButton() {
        // we call the delegate
        delegate?.datePickerViewController(datePickerDidCancel: self)
        
        // when cancel pressed, we will dismiss the datePicker
        self.dismiss(animated: true, completion: nil)
    }
}
extension DatePickerViewController {
    
    private func addDatePicker() {
        let datePicker = UIDatePicker(frame: view.bounds)
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        view.addSubview(datePicker)
    }
    
    
    @objc private func datePickerValueChanged(_ sender: UIDatePicker) {
        self.pickedDate = sender.date
    }
}
