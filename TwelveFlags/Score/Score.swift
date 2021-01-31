//
//  Score.swift
//  TwelveFlags
//
//  Created by RnD on 12/28/20.
//

import Foundation
import FirebaseFirestoreSwift

struct Score: Codable, Identifiable {
    var highScore: Int
    var name: String
    var userId: String?
    @DocumentID var id: String?
}

#if DEBUG
let testData = (1...10).map { i in
    Score(highScore: i * Int.random(in: 1...5) * 1000000000000, name: "Name\(i)")
}
#endif
