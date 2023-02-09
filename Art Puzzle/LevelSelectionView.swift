//
//  LevelSelectionView.swift
//  Art Puzzle
//
//  Created by Conner Tate on 12/6/22.
//

import SwiftUI

struct LevelSelectionView: View {
    @EnvironmentObject var vm: ViewModel
    var gridItemLayout: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    var body: some View {
        VStack(spacing: 0) {
            Text("LEVELS")
                .font(Font.custom("Avenir Next", size: 35).weight(.semibold))
                .foregroundColor(.black)
                .padding(.bottom, 10)
            
            ScrollView() {
                LazyVGrid(columns: gridItemLayout, spacing: 10) {
                    ForEach(vm.artPieces) { piece in
                    Image(piece.file)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 110, height: 110)
                        .cornerRadius(8)
                        .foregroundColor(.white)
                        .onTapGesture {
                            withAnimation(.easeOut(duration: 0.75)) {
                                vm.SelectArt(selection: piece)
                                vm.ScramblePuzzle()
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
    
    struct LevelSelectionView_Previews: PreviewProvider {
        static var previews: some View {
            LevelSelectionView()
        }
    }
}
