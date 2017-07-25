//
//  FirebaseClient.swift
//  WetherApp
//
//  Created by Konstantin Khokhlov on 25.07.17.
//  Copyright © 2017 Konstantin Khokhlov. All rights reserved.
//

import Foundation
import FirebaseDatabase

class FirebaseClient {
    private let dataBaseReference: DatabaseReference!

    init() {
        dataBaseReference = Database.database().reference()
    }

    /// Sends a state name and temperature to the Firebase Database location.
    ///
    /// - Parameters:
    ///   - name: A state name.
    ///   - temperature: A temperature String.
    func sendLocationInfo(name: String, temperature: String) {
        dataBaseReference.child("locations").childByAutoId().setValue([name: temperature])
    }
}
