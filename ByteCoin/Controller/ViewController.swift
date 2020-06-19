//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    var coinmanager = CoinManager()
    
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        coinmanager.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
    }

}

//MARK: - UIPickerDataSource & UIPickerViewDelegate

/*
    for us to update the PickerView with some titles and detect when it is interacted with.
    To do this we have set up the PickerView’s delegate methods we use UIPickerViewDelegate
*/
extension ViewController:  UIPickerViewDataSource, UIPickerViewDelegate
{

       // when we adopat the UIPickerViewDataSource we have to include both numberOfComponents & pickerView with return INT
       func numberOfComponents(in pickerView: UIPickerView) -> Int
       {
           //it returns how many columns we want in our picker.
           return 1
       }
       
       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
       {
           //it returns how many rows this picker should have
           return coinmanager.currencyArray.count
       }
       /*
        This method expects a String as an output. The String is the title for a given row.
        When the PickerView is loading up, it will ask its delegate for a row title and call the above method once for every row.
        So when it is trying to get the title for the first row, it will pass in a row value of 0 and a component (column) value of 0.
        */
       func pickerView(_ pickerView: UIPickerView, titleForRow row: Int ,forComponent component: Int) -> String?
       {
           return coinmanager.currencyArray[row]
       }
       
       func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
       {
           let SelectedCerrency = coinmanager.currencyArray[row]
           coinmanager.getCoinPrice(for: SelectedCerrency)
           print(SelectedCerrency)
       }
    
}

//MARK: - CoinManagerDelegate

extension  ViewController: CoinManagerDelegate
{
        func didUpdatePrice(price: String, currency: String)
        {
            DispatchQueue.main.async
            {
                self.bitcoinLabel.text = price
                self.currencyLabel.text = currency
            }
        }
    
        func didFailWithError(error : Error)
        {
            print(error)
        }
}

