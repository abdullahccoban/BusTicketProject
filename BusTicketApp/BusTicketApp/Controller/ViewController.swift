//
//  ViewController.swift
//  BusTicketApp
//
//  Created by Abdullah Coban on 26.07.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var adTextField: UITextField!
    @IBOutlet weak var soyadTextField: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var biletSayisiLabel: UILabel!
    
    var bilet = Bilet()
    var tarih = Tarih()
    var saat = Saat()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func selectSeatBtn(_ sender: Any) {
        
        if(bilet.koltukSayisi <= 0 || bilet.koltukSayisi > 5 ){
            let alert = UIAlertController(title: "Uyarı", message: "Lütfen koltuk sayısını 1-5 arasında seçiniz.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        } else {
            let seatVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "busVC") as! BusViewController
            let yolcu = Yolcu.init(ad: adTextField.text ?? "", soyad: soyadTextField.text ?? "", id: idTextField.text ?? "")
            bilet.yolcu = yolcu
            bilet.tarih = tarih
            bilet.saat = saat
            seatVC.bilet = bilet
        
            navigationController?.pushViewController(seatVC, animated: true)
        }
    }
    
    @IBAction func ticketStepper(_ sender: UIStepper) {
        biletSayisiLabel.text = String(Int(sender.value))
        bilet.koltukSayisi = Int(sender.value)
    }
    
    
    @IBAction func datePickerSelected(_ sender: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        let gun = dateFormatter.string(from: sender.date)
        dateFormatter.dateFormat = "MM"
        let ay = dateFormatter.string(from: sender.date)
        dateFormatter.dateFormat = "yyyy"
        let yil = dateFormatter.string(from: sender.date)
        tarih = Tarih.init(gun: gun, ay: ay, yil: yil)
        
        dateFormatter.dateFormat = "HH"
        let hour = dateFormatter.string(from: sender.date)
        dateFormatter.dateFormat = "mm"
        let minute = dateFormatter.string(from: sender.date)
        saat = Saat.init(saat: hour, dakika: minute)
    }
}

