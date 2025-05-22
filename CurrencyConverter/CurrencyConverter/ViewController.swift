//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Ali Ünal UZUNÇAYIR on 22.05.2025.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var usd: UILabel!
    
    @IBOutlet weak var jpy: UILabel!
    @IBOutlet weak var btc: UILabel!
    @IBOutlet var chf: UIView!
    @IBOutlet weak var `try`: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getRatesClicked(_ sender: Any) {
        // request and session
        // response and data
        // parsing & json serizalitaon
        
        let url = URL(string: "https://data.fixer.io/api/latest?access_key=7cfd4c8410049d44318353a73d5e0f4d")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                let alert = UIAlertController(title: "EROOR", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                
                let button = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(button)
                self.present(alert, animated: true)
                
            }
            else  {
                if data != nil {// data geldiyse
                    do   {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options:JSONSerialization.ReadingOptions.mutableContainers )as! Dictionary<String,Any>
                        // ASYNC
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? [String : Any] {
                                
                                
                                if let btc = rates["BTC"] as? Double {
                                    self.btc.text = "BTC: \(btc)"
                                }
                                if let usd = rates["USD"] as? Double {
                                    self.usd.text =  "USD: \(usd)"
                                }
                                if let tr = rates["TRY"] as? Double {
                                    self.try.text = "TRY: \(tr)"
                                }
                                if let jpy = rates["JPY"] as? Double {
                                    self.jpy.text = "JPY: \(jpy)"
                                }
                               
                                
                                
                                
                                
                                
                            }
                        }
                    }catch {
                        print("error")
                    }
                }
            }
        }
        task.resume()
    }
}
