//
//  Bilet.swift
//  BusTicketApp
//
//  Created by Abdullah Coban on 28.07.2021.
//

import Foundation

struct Bilet {
    var yolcu: Yolcu?
    var tarih: Tarih?
    var saat: Saat?
    var koltuk: [Int] = []
    var koltukSayisi: Int = 0
}
