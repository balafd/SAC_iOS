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
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    func createForm(){
        let form = FormDescriptor()
        form.title = "Example form"
        
        // Define first section
        let section1 = FormSectionDescriptor(headerTitle: "Create shop", footerTitle: "");
        
        var row = FormRowDescriptor(tag: "name", type: .email, title: "Name")
        section1.rows.append(row)
        
        row = FormRowDescriptor(tag: "phone", type: .phone, title: "Phone Number")
        section1.rows.append(row)

        row = FormRowDescriptor(tag: "address", type: .phone, title: "Address")
        section1.rows.append(row)

        row = FormRowDescriptor(tag: "owner", type: .phone, title: "Owner")
        section1.rows.append(row)

        row = FormRowDescriptor(tag: "tags", type: .phone, title: "Tags")
        section1.rows.append(row)
        
        row = FormRowDescriptor(tag: "button", type: .button, title: "Submit")
        row.configuration.button.didSelectClosure = { _ in
            
//            self.form.formValues().forEach({ (<#(key: String, value: AnyObject)#>) in
//                <#code#>
//            })

            
        }
        section1.rows.append(row)
        
        form.sections = [section1]
        
        self.form = form
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
