//
//  ViewController.swift
//  testSPMTechMeeting
//
//  Created by Vincent Berihuete on 2019-11-22.
//  Copyright © 2019 Vincent Berihuete. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    let decoder = JSONDecoder()
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .blue
        label.font = .systemFont(ofSize: 23)
        label.numberOfLines = 0
        label.text = "loading..."
        return label
    }()
    
    var employee: Employee? {
        didSet {
            guard let employee =  employee else { return }
            label.text = "Hey my name is \(employee.name) and I earn \(employee.salary)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
//        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        AF.request("http://dummy.restapiexample.com/api/v1/employee/1").response { (response) in
            guard let data = response.data else { return }
            do {
                self.employee = try self.decoder.decode(Employee.self, from: data)
            }catch(let error){
                print(error)
            }
            
        }
    }
    
    
}


struct Employee: Codable {
    let id: String
    let name: String
    let salary: String
    let age: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "employee_name"
        case salary = "employee_salary"
        case age = "employee_age"
    }
    
}
