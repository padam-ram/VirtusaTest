//
//  PeopleViewController.swift
//  VirtusaTest
//
//  Created by Apple on 17/03/22.
//

import UIKit

class PeopleViewController: UIViewController {
    
    @IBOutlet weak var peopleTable:UITableView!
    
    var peopleArray = [People]()
    
    //MARK: - Init

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationController?.navigationBar.isHidden = false
        self.title = "Colleagues"
       
        peopleTable.delegate   = self
        peopleTable.dataSource = self
        peopleTable.tableFooterView = UIView()
        peopleTable.tableHeaderView = UIView()
        
        getUserslist()
       
    }

    //MARK: - API Calls
    
    func getUserslist() {
        self.lodingindicator()
        let URL =  NSURL(string:kBaseURL + kPeople)
        let request = RequestModelForGet(url:URL!,querryItems: nil,httpHeaderField: nil, httpHeaderField_userInputContent: nil)
        APIWapperClass.ServicerequestForGetMethod(request, [People].self) { result in
            self.hideindicator()
            switch result {
            case .success(let model):
                model.forEach({ (model) in
                    DispatchQueue.main.async { [self] in
                        peopleArray.append(model)
                        peopleArray = peopleArray.sorted(by: { $0.firstName! < $1.firstName! })
                        peopleTable.reloadData()
                    }
                })
            case .failure(let error):
                print("Error  = > ", error.localizedDescription.debugDescription)
            }
            
        }
    }

}

//MARK: - Table View Data Source & Delegate Mathods

extension PeopleViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView,numberOfRowsInSection section: Int) -> Int {
                   
        return self.peopleArray.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PeopleTableViewCell.identifier,for: indexPath) as! PeopleTableViewCell
        if self.peopleArray.count > 0 {
            cell.bindData(people: self.peopleArray[indexPath.row])
        }
        return cell
    }
    
}
