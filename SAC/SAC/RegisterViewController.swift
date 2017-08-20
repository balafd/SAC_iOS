//
//  RegisterViewController.swift
//  SAC
//
//  Created by Girish Koundinya on 20/08/17.
//  Copyright © 2017 ShopAroundTheCorner. All rights reserved.
//

import UIKit
import SwiftForms

class RegisterViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none
        createForm()
    }
    
    func createForm(){
        var form = FormDescriptor()
        form.title = "Example form"
        
        // Define first section
        var section1 = FormSectionDescriptor(headerTitle: "Create shop", footerTitle: "");
        
        var row = FormRowDescriptor(tag: "name", type: .email, title: "Name")
        section1.rows.append(row)
        
        row = FormRowDescriptor(tag: "phone", type: .phone, title: "Phone Number")
        section1.rows.append(row)

        row = FormRowDescriptor(tag: "address", type: .phone, title: "Address")
        section1.rows.append(row)

        row = FormRowDescriptor(tag: "owner", type: .phone, title: "Owner")
        section1.rows.append(row)
        
        row = FormRowDescriptor(tag: "button", type: .button, title: "Submit")
        section1.rows.append(row)
        
        form.sections = [section1]
        
        self.form = form
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
