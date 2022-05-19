//
//  ViewController.swift
//  MvvmEczane
//
//  Created by Tuncay FORMA on 17.05.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource ,UITableViewDelegate{
    
    var chosenName = ""
    var chosenAddress = ""
    var chosenPhone = ""
    var chosenLocation = ""

    private let tableView : UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self,
                       forCellReuseIdentifier: "cell")
        return table
    }()
    
    private var viewModel = EczaneListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        title = "Nöbetçi Eczane"
        
        viewModel.eczaneler.bind{ [weak self]_ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        fetchData()
    }
    //Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.eczaneler.value?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = (viewModel.eczaneler.value?[indexPath.row].name)! + " ECZANESİ"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenName = (viewModel.eczaneler.value?[indexPath.row].name)! + " ECZANESİ"
        chosenAddress = (viewModel.eczaneler.value?[indexPath.row].address)!
        chosenPhone = (viewModel.eczaneler.value?[indexPath.row].phone)!
        chosenLocation = (viewModel.eczaneler.value?[indexPath.row].loc)!
        performSegue(withIdentifier: "goDetail", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goDetail"{
            let destinationVC = segue.destination as! DetailViewController
            destinationVC.selectedName = chosenName
            destinationVC.selectedAddress = chosenAddress
            destinationVC.selectedPhone = chosenPhone
            destinationVC.selectedLocation = chosenLocation
        }
    }
    func fetchData(){
        let headers = [
          "content-type": "application/json",
          "authorization": "apikey 4vt87Wjv7h2JoINagTFBy6:77epPNXelDzVLC3v4w2yMX"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://api.collectapi.com/health/dutyPharmacy?ilce=&il=Elazig")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            guard let data = data else {
                return
            }
            do{
                
                let userModels = try JSONDecoder().decode(EczaneResponse.self,from:data)
                
                self.viewModel.eczaneler.value = userModels.result.compactMap({
                    EczaneTableCellViewModel(name: $0.name,dist: $0.dist, address: $0.address,phone: $0.phone,loc: $0.loc)
                    
                })
            }catch{
                print(error)
            }
        }
        task.resume()
    }


}

