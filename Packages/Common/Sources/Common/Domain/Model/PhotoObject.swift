//
//  PhotoObject.swift
//  Common
//
//  Created by Luthfi Asmara on 15/11/25.
//

import RealmSwift

public class PhotoObject: Object {
    @Persisted(primaryKey: true) public var id: String = ""
    @Persisted public var imageUrl: String? = nil
    @Persisted public var width: Int? = nil
    @Persisted public var height: Int? = nil
}
