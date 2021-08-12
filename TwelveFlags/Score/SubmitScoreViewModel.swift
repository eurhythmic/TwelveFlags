//
//  SubmitScoreViewModel.swift
//  TwelveFlags
//
//  Created by RnD on 5/7/21.
//

import Foundation

class SubmitScoreViewModel: ObservableObject {
    @Published var buttonTapped = false
    let characterLimit = 25
}
