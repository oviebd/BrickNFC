//
//  FirestoreUserManager.swift
//  TestBrick
//
//  Created by Habibur Rahman on 1/5/25.
//

import Foundation
import FirebaseFirestore

final class FirestoreUserManager {

    private let db = Firestore.firestore()
    private let collectionName = "users"

    func saveUserProfile(_ profile: UserProfileData, completion: @escaping (Error?) -> Void) {
        do {
            let encodedData = try Firestore.Encoder().encode(profile)
            db.collection(collectionName)
              .document(profile.email)
              .setData(["data": encodedData], merge: true, completion: completion)
        } catch {
            completion(error)
        }
    }

    
     func deleteUserProfile(email: String, completion: @escaping (Error?) -> Void) {
         db.collection(collectionName)
           .document(email)
           .delete(completion: completion)
     }

    
    func fetchUserProfile(email: String, completion: @escaping (Result<UserProfileData, Error>) -> Void) {
        db.collection(collectionName)
            .document(email)
            .getDocument { snapshot, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let data = snapshot?.data()?["data"] as? [String: Any] else {
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data found."])))
                    return
                }

                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: data)
                    let decoded = try JSONDecoder().decode(UserProfileData.self, from: jsonData)
                    completion(.success(decoded))
                } catch {
                    completion(.failure(error))
                }
            }
    }
}
