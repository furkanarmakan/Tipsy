//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPtcButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tip = 0.10
    var numberOfPeople = 2
    var billTotal = 0.0
    var finalResult = "0.0"
    
    @IBAction func tipChangedButton(_ sender: UIButton) {
       // butun butonlari secilmemis yaptik.
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPtcButton.isSelected = false
       // secilen butonu secilmis yaptik.
        sender.isSelected = true
      // Secilen butonun labelini aldik
        let buttonTitle = sender.currentTitle!
      // Secilen butonun son karakterini stringe cevirdik.
        let buttonTitleMinusPercentSign = String(buttonTitle.dropLast())
      // Buton basligindan gelen stringi Double olarak cevirdik.
        let buttonTitleAsNumber = Double(buttonTitleMinusPercentSign)
      // 100e bolduk.
        tip =  (buttonTitleAsNumber! / 100 )
        
        billTextField.endEditing(true)
        
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(format: "%0.f", sender.value)
        numberOfPeople = Int(sender.value)
        billTextField.endEditing(true)

        
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        billTextField.endEditing(true)
        // Kullanicinin billtextfield ekranina yazdigini alalim
        let bill = billTextField.text!
        
        // Eger bos bir text metni degilse
        if bill != ""{
            
            // bu degeri double a cevirelim
            billTotal = Double(bill)!
            // toplam bill tutarini verilecek yuzde tip tutarina 1 ekleyip ki 1.10 yapar
            // adam sayisina bolelim
            let result = billTotal * (1 + tip) / Double(numberOfPeople)
            
            finalResult = String(format: "%.2f", result)
          }
          
          //In Main.storyboard there is a segue between CalculatorVC and ResultsVC with the identifier "goToResults".
          //This line triggers the segue to happen.
          self.performSegue(withIdentifier: "goToResultViewController", sender: self)
      }
      
      //This method gets triggered just before the segue starts.
      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          
          //If the currently triggered segue is the "goToResults" segue.
          if segue.identifier == "goToResultViewController" {
              
              //Get hold of the instance of the destination VC and type cast it to a ResultViewController.
              let destinationVC = segue.destination as! ResultsViewController
              
              //Set the destination ResultsViewController's properties.
              destinationVC.result = finalResult
              destinationVC.tip = Int(tip * 100)
              destinationVC.split = numberOfPeople
          }
      }
  }
