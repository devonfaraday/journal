//
//  FirebaseController.swift
//  Journal
//
//  Created by Christian McMullin on 10/8/21.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class FirebaseController {
    
    enum CollectionType: String {
        case journal
        case entry
        case jIndex
        case user
    }
    
    private let db = Firestore.firestore()
    var userId: String? {
        return Firebase.Auth.auth().currentUser?.uid
    }
    
    
    // the document is the ID of the object being saved
    // This will update a document if one exists, if it doesn't then the document will be created.
    func setJournalDocument(document: String, journal: Journal, completion: @escaping() -> Void) {
        do {
            try db.collection(CollectionType.journal.rawValue).document(document).setData(from: journal) { error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("success")
                }
            }
            completion()
        } catch {
            completion()
        }
    }
    
    func setEntryDocument(document: String, entry: Entry, completion: @escaping() -> Void) {
        do {
            try db.collection(CollectionType.entry.rawValue).document(document).setData(from: entry) { error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("success")
                }
            }
            completion()
        } catch {
            completion()
        }
    }
    
    func setIndexDocument(document: String, jIndex: JournalIndex, completion: @escaping() -> Void) {
        do {
            try db.collection(CollectionType.jIndex.rawValue).document(document).setData(from: jIndex) { error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("success")
                }
            }
            completion()
        } catch {
            completion()
        }
    }
    
    func setUserDocument(document: String, user: User, completion: @escaping() -> Void) {
        do {
            try db.collection(CollectionType.user.rawValue).document(document).setData(from: user) { error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("success")
                }
            }
            completion()
        } catch {
            completion()
        }
    }
    
    //GET a list of documents
    func getDocuments(collection: CollectionType, whereField: String, isEqualTo: Any, completion: @escaping(_ documents: [QueryDocumentSnapshot], Error?) -> Void) {
        db.collection(collection.rawValue).whereField(whereField, isEqualTo: isEqualTo)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                    completion([], err)
                } else {
                    if let documents = querySnapshot?.documents {
                        completion(documents, nil)
                    } else {
                        completion([], nil)
                    }
                }
            }
    }


//    func getDocument(collection: CollectionType, whereField: String, isEqualTo: String, completion: @escaping(_ document: QueryDocumentSnapshot, Error?) -> Void) {
//        db.collection(collection.rawValue).document
//    }

// add a listener for realtime updating
func addSnapshotListener(collection: CollectionType, document: String) {
    db.collection(collection.rawValue).document(document)
        .addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            guard let data = document.data() else {
                print("Document data was empty.")
                return
            }
            print("Current data: \(data)")
        }
}

// detach listener
func detachListener(collection: CollectionType, document: String) {
    let listener = db.collection(collection.rawValue).document(document)
        .addSnapshotListener { documentSnapshot, error in
        }
    
    listener.remove()
}

// delete a document
func deleteDocument(collection: CollectionType, document: String) {
    db.collection(collection.rawValue).document(document).delete() { error in
        if let error = error {
            print(error.localizedDescription)
        } else {
            print("deleted")
        }
    }
}

}
