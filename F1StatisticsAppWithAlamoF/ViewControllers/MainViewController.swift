//
//  MainViewController.swift
//  F1StatisticsAppWithAlamoF
//
//  Created by Mac on 04.05.2021.
//

import UIKit

class MainViewController: UITableViewController {
    
    private let bridge = Network.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bridge.delegate = self
        bridge.fetch(with: "2020")
    }

    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = bridge.statisticsData?.mrData?.standingsTable?.standingsLists?.first?.driverStandings?.count else { return 0 }
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FOneViewCell
        let path = bridge.statisticsData?.mrData?.standingsTable?.standingsLists?.first?.driverStandings?[indexPath.row]
        
        cell.positionLabel.text = "Position: \(path?.position ?? "")"
        cell.driverLabel.text = "Driver: \(path?.driver?.familyName ?? "")"
        cell.pointsLabel.text = "Points: \(path?.points ?? "")"
        cell.winsLabel.text = "Wins: \(path?.wins ?? "")"
        
        return cell
    }
    
    @IBAction func seasonButtonTapped(_ sender: UIBarButtonItem) {
        sender.title = "Сезон"
        showAlert()
    }
    
    private func showAlert() {
        let ac = UIAlertController(title: "Введите год", message: "Введите год сезона", preferredStyle: .alert)
        ac.addTextField { tf in
            tf.keyboardType = .numberPad
        }
        let ok = UIAlertAction(title: "Ок", style: .default) { _ in
            self.bridge.fetch(with: ac.textFields?.first?.text)
        }
        ac.addAction(ok)
        present(ac, animated: true, completion: nil)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
extension MainViewController: UpdatesDelegate {
    func didFinishUpdates(finished: Bool) {
        if finished {
            print("reload")
            tableView.reloadData()
        } else {
            print("no reload")
        }
    }
}
