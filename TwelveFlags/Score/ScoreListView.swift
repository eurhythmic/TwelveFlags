//
//  ScoreListView.swift
//  TwelveFlags
//
//  Created by RnD on 1/16/21.
//

import SwiftUI

struct ScoreListView: View {
    @ObservedObject var scoreList = ScoreListViewModel()
    
    var body: some View {
        ScrollView {
            ForEach(scoreList.scoreViewModels) { scoreViewModel in
                ScoreView(scoreViewModel: scoreViewModel)
            }
        }
    }
}

struct ScoreListView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreListView(scoreList: ScoreListViewModel())
    }
}
