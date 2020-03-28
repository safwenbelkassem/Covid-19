//
//  ViewController.swift
//  Covid-19-Demo
//
//  Created by MacBook on 3/25/20.
//  Copyright © 2020 MacBookSafwen. All rights reserved.
//

import UIKit
import Charts
import Alamofire

class HomeViewController: UIViewController {
    @IBOutlet weak var coronaChart: UIView!
    @IBOutlet weak var lastUpdateTExt: UILabel!
    @IBOutlet weak var recoveredText: UILabel!
    @IBOutlet weak var deathsText: UILabel!
    @IBOutlet weak var confirmedCasesText: UILabel!
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var confirmedForWorld: UILabel!
    @IBOutlet weak var deathOfWorld: UILabel!
    @IBOutlet weak var recoveredForWorld: UILabel!
    @IBOutlet weak var lastUpdateOfWorld: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getStatTunisia(coutry: "Tunisia")
        loadChartCorona(country: "Tunisia")
        getStatWorld()
        
        // Do any additional setup after loading the view.
    }


}

extension HomeViewController{
    
    func getStatTunisia(coutry: String) {
        let url = "https://coronavirus-monitor.p.rapidapi.com/coronavirus/latest_stat_by_country.php"
           let parameters: [String: String] = ["country": coutry]
            let headers: HTTPHeaders = ["Content-Type":"application/x-www-form-urlencoded",
                                        "x-rapidapi-host": "coronavirus-monitor.p.rapidapi.com",
                                        "X-RapidAPI-Key" : "e97cfa035fmsh2761fac59ec1463p11c314jsn0cdd30264103"
        ]
        AF.request(url,parameters: parameters, headers: headers)
            .responseDecodable(of:LatestStatModel.self) { response in
                guard let json = String(data: response.data!, encoding: String.Encoding.utf8) else {
                                   print("hh")
                                   return
                               }
                let decoder = JSONDecoder()
                let jsonData = Data(json.utf8)
                do {
                    let stat = try decoder.decode(LatestStatModel.self, from: jsonData)
                    DispatchQueue.main.async {
                        self.confirmedCasesText.text = stat.latest_stat_by_country[0].total_cases
                        self.deathsText.text = stat.latest_stat_by_country[0].total_deaths
                        self.recoveredText.text = stat.latest_stat_by_country[0].total_recovered
                        self.lastUpdateTExt.text =
                           ("Last update at : \(stat.latest_stat_by_country[0].record_date)")
                    }
    
                } catch {
                    print(error.localizedDescription)
                }
        }
    }
    
    func loadChartCorona(country: String) {
        var valueChart = [Int]()
        var lineChartEntry = [ChartDataEntry]()
        let data = LineChartData()
        let url = "https://coronavirus-monitor.p.rapidapi.com/coronavirus/cases_by_particular_country.php"
               let parameters: [String: String] = ["country": country]
                let headers: HTTPHeaders = ["Content-Type":"application/x-www-form-urlencoded",
                                            "x-rapidapi-host": "coronavirus-monitor.p.rapidapi.com",
                                            "x-rapidapi-key": "e97cfa035fmsh2761fac59ec1463p11c314jsn0cdd30264103"
            ]
            AF.request(url,parameters: parameters, headers: headers)
                .responseDecodable(of:StatByCountryModel.self) { response in
                    guard let json = String(data: response.data!, encoding: String.Encoding.utf8) else {
                                      
                                       return
                                   }
                    let decoder = JSONDecoder()
                    let jsonData = Data(json.utf8)
                    do {
                        let stat = try decoder.decode(StatByCountryModel.self, from: jsonData)
                        DispatchQueue.main.async {
                            var x = 0

                            while x < stat.statByCountry.count + 1 {
                                if x < stat.statByCountry.count - 1{
                                    if (stat.statByCountry[x + 1].totalCases > stat.statByCountry[x].totalCases)  {
                                       // print(stat.statByCountry[x].totalCases)
                                       // print(stat.statByCountry[x].recordDate)
                                        valueChart.append(Int(stat.statByCountry[x].totalCases)!)
                                    }
//                                    if (stat.statByCountry[x + 1].recordDate != stat.statByCountry[x].recordDate) && (stat.statByCountry[x + 1].totalCases > stat.statByCountry[x].totalCases){
//                                        var maChaine = String(stat.statByCountry[x].recordDate)
//                                        let index = maChaine.index(maChaine.startIndex, offsetBy: 10)
//                                        let maSousChaine = String(maChaine.prefix(upTo: index).suffix(2))
//                                        dateChart.append(Int(maSousChaine) ?? 0)
//                                    }
                                }
                                x += 1
                            }
                            valueChart.append(Int(stat.statByCountry[stat.statByCountry.count - 1].totalCases)!)
//                            let index = stat.statByCountry[stat.statByCountry.count - 1].recordDate.index(stat.statByCountry[stat.statByCountry.count - 1].recordDate.startIndex, offsetBy: 10)
//                            let maSousChaine = String(stat.statByCountry[stat.statByCountry.count - 1].recordDate.prefix(upTo: index).suffix(2))
//                             dateChart.append(Int(maSousChaine) ?? 0)
                            
                            //print(valueChart)
                            for i in 0..<valueChart.count {
                                let value = ChartDataEntry(x: Double(i), y: Double(valueChart[i]))
                                lineChartEntry.append(value)
                            }
                            let line = LineChartDataSet(entries: lineChartEntry, label: "Cases In Tunisia")
                            line.colors = [UIColor.red]
                            line.valueColors = [UIColor.black]
                            data.addDataSet(line)
                            self.lineChartView.data = data
                            self.lineChartView.chartDescription?.text = "Tunisia"
                        }
                       
                    } catch {
                        print("hh")
                        print(error.localizedDescription)
                    }
            }
        
        
    }
    func getStatWorld() {
        let url = "https://coronavirus-monitor.p.rapidapi.com/coronavirus/worldstat.php"
         
            let headers: HTTPHeaders = ["Content-Type":"application/x-www-form-urlencoded",
                                        "x-rapidapi-host": "coronavirus-monitor.p.rapidapi.com",
                                        "X-RapidAPI-Key" : "e97cfa035fmsh2761fac59ec1463p11c314jsn0cdd30264103"
        ]
        AF.request(url,headers: headers)
            .responseDecodable(of:LatestStatModel.self) { response in
                guard let json = String(data: response.data!, encoding: String.Encoding.utf8) else {
                                   print("hh")
                                   return
                               }
                let decoder = JSONDecoder()
                let jsonData = Data(json.utf8)
                do {
                    let stat = try decoder.decode(StatOfTheWorldModel.self, from: jsonData)
                    
                    DispatchQueue.main.async {
                        self.confirmedForWorld.text = stat.totalCases
                        self.deathOfWorld.text = stat.totalDeaths
                        self.recoveredForWorld.text = stat.totalRecovered
                        self.lastUpdateOfWorld.text =
                      ("Last update at : \(stat.statisticTakenAt)")
                    }
    
                } catch {
                    print(error.localizedDescription)
                }
        }
    }
    
}
