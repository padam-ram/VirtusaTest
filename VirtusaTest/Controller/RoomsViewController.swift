//
//  RoomsViewController.swift
//  VirtusaTest
//
//  Created by Apple on 17/03/22.
//

import UIKit

class RoomsViewController: UIViewController {
        
    var roomsArray = [Rooms]()
    
    @IBOutlet weak var roomsTable:UITableView!

    //MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationController?.navigationBar.isHidden = false
        self.title = "Rooms Availability"
        
        roomsTable.delegate   = self
        roomsTable.dataSource = self        
        roomsTable.tableFooterView = UIView()
        roomsTable.tableHeaderView = UIView()
        
        getRoomsList()
    }
    
    
    //MARK: - API Calls
    
    func getRoomsList() {
        self.lodingindicator()
        let URL =  NSURL(string:kBaseURL + kRooms)
        let request = RequestModelForGet(url:URL!,querryItems: nil,httpHeaderField: nil, httpHeaderField_userInputContent: nil)
        APIWapperClass.ServicerequestForGetMethod(request, [Rooms].self) { result,response  in
            self.hideindicator()
            switch result {
            case .success(let model):
                model.forEach({ (model) in
                    self.roomsArray.append(model)
                })
                DispatchQueue.main.async {
                    if self.roomsArray.count > 0 {
                    self.roomsTable.reloadData()
                  }
                }
                
            case .failure(let error):
                print("Error  = > ", error.localizedDescription.debugDescription)
            }
        }
    }
    
 }


//MARK: - Table View Data Source & Delegate Mathods

extension RoomsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView,numberOfRowsInSection section: Int) -> Int {
                   
        return self.roomsArray.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RoomsTableViewCell.identifier,for: indexPath) as! RoomsTableViewCell
        if self.roomsArray.count > 0 {
            cell.bindData(rooms: self.roomsArray[indexPath.row])
        }
        return cell
    }
}
