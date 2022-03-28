//
//  ShoppingListViewModel.swift
//  ShoppingLIst
//
//  Created by Glenn Robert Strandos on 13/01/2022.
//

import Foundation
import Firebase
import FirebaseAuth

class ShoppingListViewModel: ObservableObject {
    @Published var shoppingList = [String]()
    @Published var currentList = [ShoppingItem]()
    @Published var nextList = [ShoppingItem]()
    @Published var receiptList = [Receipt]()
    
    let auth = Auth.auth()
    
    @Published var signedIn = false
    @Published var userName = ""
    @Published var householdId = ""
    @Published var householdName = ""
    @Published var lastReceiptId = ""
    
    @Published var errorSigningInOrUp = ""
    @Published var errorInvalidHouseholdCode = ""
    
    @Published var displayDialog = false
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func setUserDefaults(value: Bool, key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func getUserDefaults(key: String) -> Bool {
        UserDefaults.standard.bool(forKey: key)
    }
    
    func signIn(email: String, password: String) {
        errorSigningInOrUp = ""
        
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                print("Failing to sign in")
                self?.errorSigningInOrUp = error?.localizedDescription ?? ""
                return
            }
            // Success
            DispatchQueue.main.async {
                print("Signing in..")
                self?.signedIn = true
                self?.initialLoad()
                //self?.getHousehold(id: self?.householdId ?? "")
                self?.setUserDefaults(value: true, key: "hasHousehold")
            }
        }
    }
    
    func signUp(email: String, password: String, name: String) {
        errorSigningInOrUp = ""
        
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                print("Failing to sign out")
                self?.errorSigningInOrUp = error?.localizedDescription ?? ""
                return
            }
            // Success
            self?.createUser(name: name, uid: self?.auth.currentUser?.uid ?? "")
            DispatchQueue.main.async {
                print("Signing up..")
                self?.signedIn = true
            }
        }
    }
    
    func signOut() {
        try? auth.signOut()
       
        DispatchQueue.main.async {
            print("Signing out..")
            self.signedIn = false
            self.userName = ""
            self.householdId = ""
            self.errorSigningInOrUp = ""
            self.errorInvalidHouseholdCode = ""
            self.setUserDefaults(value: false, key: "hasHousehold")
            print("Signed out...")
        }
    }
    
    func createUser(name: String, uid: String) {
        let db = Firestore.firestore()
        
        db.collection("users").document(uid).setData(["name": name, "householdId": ""]) {_ in
            print("added user")
            self.getUser()
        }
    }
    
    func getUser() {
        let db = Firestore.firestore()
        guard auth.currentUser != nil else {
            print("No UID found")
            return
        }
        
        db.collection("users").document(auth.currentUser!.uid).getDocument { document, error in
            guard document != nil, error == nil else {
                print("Document doesn't exist")
                return
            }
            let documentValues = document!.data()!
            self.householdId = documentValues["householdId"]! as! String
            self.userName = documentValues["name"]! as! String
        }
    }
    
    func updateUser(id: String, name: String?, code: String?) {
        let db = Firestore.firestore()
        
        if name != nil && code != nil {
            db.collection("users").document(id).updateData(["name": name!, "householdId": code!]) {_ in
                print("updated user")
                self.getUser()
                
            }
        } else if name != nil {
            db.collection("users").document(id).updateData(["name": name!]) {_ in
                print("updated user")
                self.getUser()
                
            }
        } else if code != nil {
            db.collection("users").document(id).updateData(["householdId": code!]) {_ in
                print("updated user")
                self.getUser()
                
            }
        }
    }
    
    // TODO: SJÅ  NOTAT!
    /*
     4. Implement logic to retrieve and store shopping list
     5. Make "Stop shopping" button work
     6. Store shopping trips, duration, date, objects bought
     */
    
    func createHousehold(id: String, houseName: String, shoppingList: [String], currentList: [String], nextList: [String]) {
        let code = randomString(length: 6)
        
        let db = Firestore.firestore()
        
        let doc = db.collection("households").document(code)
        
        doc.setData([
            "code": code,
            "members": [userName],
            "houseName": houseName,
            "shoppingList": ["", ""],
            "currentWeekList": ["", ""],
            "nextWeekList": ["", ""]
        ]) {_ in
            print("added household")
            self.updateUser(id: id, name: nil, code: code)
            self.getHousehold(id: code)
            self.setUserDefaults(value: true, key: "hasHousehold")
        }
    }
    
    func joinHousehold(id: String, code: String) {
        let db = Firestore.firestore()
        
        db.collection("households").document(code).getDocument { document, error in
            guard document != nil, document!.exists, error == nil else {
                print("Document doesn't exist")
                self.errorInvalidHouseholdCode = "Invalid household code. Please try again."
                return
            }
            self.updateUser(id: id, name: nil, code: code)
            let documentValues = document!.data()!
            
            var members = documentValues["members"] as! [String]
            members.append(self.userName)
            self.updateHousehold(id: code, members: members, houseName: nil, shoppingList: nil, currentList: nil, nextList: nil)
            self.getUser()
            self.setUserDefaults(value: true, key: "hasHousehold")
        }
    }
    
    func getHousehold(id: String) {
        guard !id.isEmpty else {
            print("HouseholdId empty @ getHousehold")
            return
        }
        let db = Firestore.firestore()
        
        db.collection("households").document(id).getDocument { document, error in
            guard document != nil, error == nil else {
                print("Document doesn't exist")
                return
            }
            let documentValues = document!.data()!
            self.householdId = documentValues["code"]! as? String ?? ""
            self.householdName = documentValues["houseName"]! as? String ?? ""
        }
    }
    
    func updateHousehold(id: String, members: [String]?, houseName: String?, shoppingList: [String]?, currentList: [String]?, nextList: [String]?) {
        let db = Firestore.firestore()
        
        if shoppingList != nil {
            db.collection("households").document(id).updateData(["shoppingList": shoppingList!]) {_ in
                print("updated household")
                self.getHousehold(id: id)
            }
        }
        if nextList != nil {
            db.collection("households").document(id).updateData(["nextWeekList": nextList!]) {_ in
                print("updated household")
                self.getHousehold(id: id)
            }
        }
        if currentList != nil {
            db.collection("households").document(id).updateData(["currentWeekList": currentList!]) {_ in
                print("updated household")
                self.getHousehold(id: id)
            }
        }
        if houseName != nil {
            db.collection("households").document(id).updateData(["houseName": houseName!]) {_ in
                print("updated household")
                self.getHousehold(id: id)
            }
        }
        if members != nil {
            db.collection("households").document(id).updateData(["members": members!]) {_ in
                print("updated household")
                self.getHousehold(id: id)
            }
        }
    }
    
    func initialLoad() {
        signedIn = isSignedIn
        
        let db = Firestore.firestore()
        
        guard auth.currentUser != nil else {
            print("No UID found")
            return
        }
        
        db.collection("users").document(auth.currentUser!.uid).getDocument { document, error in
            guard document != nil, document!.exists, error == nil else {
                print("Document doesn't exist")
                return
            }
            let documentValues = document!.data()!
            self.householdId = documentValues["householdId"]! as! String
            self.userName = documentValues["name"]! as! String
            
            guard !self.householdId.isEmpty else {
                return
            }
            
            self.getHousehold(id: self.householdId)
        }
    }
    
    
    // ----------------------------------------------------- LIST LOGIC -----------------------------------------------------------------------------------------------
    
    func getShoppingList(id: String) {
        guard !self.householdId.isEmpty, !id.isEmpty else {
            print("HouseholdId empty @ getShopping")
            return
        }
        let db = Firestore.firestore()
        
        db.collection("households").document(id).getDocument { document, error in
            guard document != nil, document!.exists, error == nil else {
                print("Document doesn't exist")
                return
            }
            
            let documentValues = document!.data()!
            let sl = documentValues["shoppingList"]! as? [String] ?? []
            
            self.shoppingList = sl
        }
    }
    
    func updateShoppingList(id: String, list: [String], callback: @escaping () -> Void) {
        guard !self.householdId.isEmpty, !id.isEmpty else {
            print("HouseholdId empty @ updateShopping")
            return
        }
        
        let db = Firestore.firestore()
        
        
        db.collection("households").document(id).updateData(["shoppingList": list]) {_ in
            self.getShoppingList(id: id)
            callback()
        }
    }
    
    func generateReceipt(id: String, list: [String], duration: Int, price: String?, callback: @escaping () -> Void) {
        guard !self.householdId.isEmpty, !id.isEmpty else {
            print("HouseholdId empty @ generateReceipt")
            return
        }
        let db = Firestore.firestore()
        let doc = db.collection("households").document(id)
        
        let uuid = UUID().uuidString
        let subDoc = doc.collection("receipts").document(uuid)
        
        subDoc.setData([
            "price" : price ?? "0",
            "shopper": self.userName,
            "ingredients": list,
            "duration": duration,
            "date": Date()
        ]) {_ in
            callback()
            self.lastReceiptId = uuid
        }
    }
    
    func getReceipts(id: String) {
        guard !id.isEmpty else {
            print("HouseholdId empty @ getReceipt")
            return
        }
        let db = Firestore.firestore()
        let doc = db.collection("households").document(id)
        
        doc.collection("receipts").getDocuments { querySnapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    
                    self.receiptList.append(Receipt(id: document.documentID, price: data["price"]! as! String, shopper: data["shopper"]! as! String, shoppingList: data["ingredients"]! as! [String], date: data["date"]! as! Timestamp, duration: data["duration"]! as! Int))
                }
            }
        }
    }
    
    func updateReceipt(id: String, price: String) {
        guard !id.isEmpty, !self.lastReceiptId.isEmpty else {
            print("HouseholdId empty @ getReceipt")
            return
        }
        let db = Firestore.firestore()
        let doc = db.collection("households").document(id)
        
        doc.collection("receipts").document(self.lastReceiptId).updateData(["price": price]) {_ in
            print("Updated Receipt")
        }
    }
    
    func toggleDisplayDialog() {
        self.displayDialog.toggle()
    }
}
