//
//  LocalDataSource.swift
//  Common
//
//  Created by Luthfi Asmara on 14/11/25.
//

import Combine
import RealmSwift

public protocol CommonLocalDataSource {
    func savePhoto(photo: [PhotoObject])
    func getPhoto() -> AnyPublisher<[PhotoObject], Never>
}

public struct DefaultCommonLocalDataSource: CommonLocalDataSource {
  public func savePhoto(photo: [PhotoObject]) {
        let realm = try! Realm()
        try? realm.write {
            realm.delete(realm.objects(PhotoObject.self))
            realm.add(photo, update: .modified)
        }
    }
    
  public func getPhoto() -> AnyPublisher<[PhotoObject], Never> {
        let realm = try! Realm()
        let photos = Array(realm.objects(PhotoObject.self))
        return Just(photos).eraseToAnyPublisher()
    }
    
}
