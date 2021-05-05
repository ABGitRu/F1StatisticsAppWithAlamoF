//
//  NetworkManager.swift
//  F1StatisticsAppWithAlamoF
//
//  Created by Mac on 04.05.2021.

import Alamofire

protocol UpdatesDelegate {
    func didFinishUpdates(finished: Bool)
}

class Network {
    
    static let shared = Network()
    var statisticsData: Welcome!
    var delegate: UpdatesDelegate?
    
    private var year: String?
    private init() {}
    
    func fetch(with year: String?) {
        let URL = "https://ergast.com/api/f1/\(year ?? "2020")/driverStandings.json"
        AF.request(URL).validate().responseJSON { response in
            let jsonDecoder = JSONDecoder()
            switch(response.result) {
            case .success:
                if let data = response.data {
                    do {
                        let jsonData = try jsonDecoder.decode(Welcome.self, from: data)
                        self.statisticsData = jsonData
                        DispatchQueue.main.async {
                            self.delegate?.didFinishUpdates(finished: true)
                        }
                    } catch let error {
                        print("\n Json Error \n", error.localizedDescription)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
