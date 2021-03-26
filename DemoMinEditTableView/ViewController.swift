//
//  ViewController.swift
//  DemoMinEditTableView
//
//  Created by Manas Mishra on 26/03/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var contentTableView: UITableView!
    
    var nums: [Int] = [1, 2, 3, 4, 5, 6]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureTableView()
    }
    
    func configureTableView() {
        let nib = UINib(nibName: "MinEditTableViewCell", bundle: nil)
        contentTableView.register(nib, forCellReuseIdentifier: "MinEditTableViewCell")
        contentTableView.delegate = self
        contentTableView.dataSource = self
    }
    
    @IBAction func reload(_ sender: Any) {
        let newNums = [1, 4, 5, 9, 10, 2, 8]
        
        let shifts = minimumEditIndexpathsForUpdate(nums, newNums)
        nums = newNums

        contentTableView.performBatchUpdates {
            self.contentTableView.deleteRows(at: shifts.deletes, with: .fade)
            self.contentTableView.insertRows(at: shifts.inserts, with: .automatic)

        } completion: { (_) in
            self.contentTableView.reloadRows(at: shifts.replaces, with: .automatic)
        }

    }
    


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MinEditTableViewCell", for: indexPath) as! MinEditTableViewCell
        cell.configureCell(nums[indexPath.row])
        return cell
    }
    
    
}

