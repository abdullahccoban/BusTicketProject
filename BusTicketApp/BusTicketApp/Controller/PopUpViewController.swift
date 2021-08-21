//
//  PopUpViewController.swift
//  BusTicketApp
//
//  Created by Abdullah Coban on 29.07.2021.
//

import UIKit
import CoreData

class PopUpViewController: UIViewController {
    
    var exitButton = UIButton()
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var yolcuLabel: UILabel!
    @IBOutlet weak var tarihLabel: UILabel!
    @IBOutlet weak var saatLabel: UILabel!
    @IBOutlet weak var koltukLabel: UILabel!
    
    var bilet = Bilet()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        exitButton = UIButton(frame: CGRect(x: 240, y: 0, width: 40, height: 40))
        exitButton.setTitle("X", for: .normal)
        exitButton.backgroundColor = .systemRed
        exitButton.layer.cornerRadius = 16
        exitButton.addTarget(self, action: #selector(exitBtn), for: .touchUpInside)
        popUpView.addSubview(exitButton)
        setupView()
        open()
        biletDetay()
    }
    @objc func exitBtn(sender: UIButton!) {
        close()
    }
    
    
    @IBAction func buyTicket(_ sender: Any) {
        var count = 0
        for koltuk in bilet.koltuk {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Bus")
            let predicate = NSPredicate(format: "koltuk == \(koltuk)")
            fetchRequest.predicate = predicate
            let result = try? context.fetch(fetchRequest)
            if result!.count > 0 {
                count += 1
            }
        }
        
        if count > 0 {
            let alert = UIAlertController(title: "Uyarı", message: "Seçtiğiniz koltuk daha önce satın alınmış.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        } else {
            for koltuk in bilet.koltuk {
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
                let context = appDelegate.persistentContainer.viewContext
                let favoriteItem = NSEntityDescription.insertNewObject(forEntityName: "Bus", into: context)
                favoriteItem.setValue(koltuk, forKey: "koltuk")
            
                do {
                    try context.save()
                } catch  {
                    print("Kaydedilemedi...")
                }
            }
            
            // the alert view
            let alert = UIAlertController(title: "", message: "Satın alma işlemi başarılı!", preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)

            // change to desired number of seconds (in this case 5 seconds)
            let when = DispatchTime.now() + 5
            DispatchQueue.main.asyncAfter(deadline: when){
              // your code with delay
              alert.dismiss(animated: true, completion: nil)
              self.close()
            }
        }
    }
    
    private func biletDetay() {
        idLabel.text = "\(bilet.yolcu?.id ?? "")"
        yolcuLabel.text = "\(bilet.yolcu?.ad ?? "") \(bilet.yolcu?.soyad ?? "")"
        tarihLabel.text = "\(bilet.tarih?.gun ?? "") / \(bilet.tarih?.ay ?? "") / \(bilet.tarih?.yil ?? "")"
        saatLabel.text = "\(bilet.saat?.saat ?? "") : \(bilet.saat?.dakika ?? "")"
        koltukLabel.text = "\("Koltuk: \(bilet.koltuk)")"
    }
    
    private func open() {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0

        UIView.animate(withDuration: 0.25) {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }

    private func close() {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0
        }) { _ in
            self.view.removeFromSuperview()
            }
    }
    
    private func setupView() {
        popUpView.layer.cornerRadius = 14
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
}
