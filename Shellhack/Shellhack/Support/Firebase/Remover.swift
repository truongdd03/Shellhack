//
//  Remover.swift
//  Shellhack
//
//  Created by Don Truong on 9/25/21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class Remover {
    static let db = Firestore.firestore().collection("Information")
    
    static func removePost(id: String) {
        let uid = Auth.auth().currentUser!.uid
        Firestore.firestore().collection("Posts").document(id).delete()
        Database.database().reference().child("Posts").child(uid).child(id).removeValue()
    }
}
