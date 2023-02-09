//
//  ViewModel.swift
//  Art Puzzle
//
//  Created by Conner Tate on 12/3/22.
//

import Foundation
import SwiftUI

class ViewModel: ObservableObject {
    
    @AppStorage("completed") var completed: String = ""
    @Published var pixels: [Pixel]
    @Published var selecedPixel: Int? = nil
    @Published var won = false
    @Published var confettiCounter: Int = 0
    @Published var selectedArt: ArtPiece? = nil
    @Published var artPieces = [
        ArtPiece(title: "The Great Wave", artist: "Katsushika Hokusai"),
        ArtPiece(title: "The Bay of Marseille", artist: "Paul Cezanne"),
        ArtPiece(title: "The Bedroom", artist: "Vincent van Gogh"),
        ArtPiece(title: "Paris Street; Rainy Day", artist: "Gustave Caillebotte"),
        ArtPiece(title: "Arrival of the Normandy Train", artist: "Claude Monet"),
        ArtPiece(title: "Water Lilies", artist: "Claude Monet"),
        ArtPiece(title: "Two Sisters", artist: "Pierre-Auguste Renoir"),
        ArtPiece(title: "Woman at Her Toilette", artist: "Berthe Morisot"),
        ArtPiece(title: "Love of Winter", artist: "George Wesley Bellows"),
        ArtPiece(title: "The Basket of Apples", artist: "Paul Cezanne"),
        ArtPiece(title: "The Herring Net", artist: "Winslow Homer"),
        ArtPiece(title: "The Assumption of the Virgin", artist: "El Greco"),
        ArtPiece(title: "Self-Portrait", artist: "Vincent van Gogh"),
        ArtPiece(title: "Distant View of Niagara Falls", artist: "Thomas Cole"),
        ArtPiece(title: "Landscape with Saint John on Patmos", artist: "Nicolas Poussin"),
        ArtPiece(title: "Arlésiennes", artist: "Paul Gauguin"),
        ArtPiece(title: "View of Cotopaxi", artist: "Frederic Edwin Church"),
        ArtPiece(title: "The Advance-Guard", artist: "Frederic Remington"),
        ArtPiece(title: "Woman Reading", artist: "Édouard Manet"),
        ArtPiece(title: "Merahi metua no Tehamana", artist: "Paul Gauguin"),
        ArtPiece(title: "Boy on a Ram", artist: "Francisco José de Goya y Lucientes"),
        ArtPiece(title: "The Emperor Sailing", artist: "Guy-Louis Vernansal"),
        ArtPiece(title: "Maharana Bhim Singh in Procession", artist: "Rajasthan, Mewar, Udaipur"),
        ArtPiece(title: "Bar-room Scene", artist: "William Sidney Mount"),
        ArtPiece(title: "Cliff Walk at Pourville", artist: "Claude Monet"),
        ArtPiece(title: "Hamamatsu", artist: "Utagawa Hiroshige"),
        ArtPiece(title: "The Song of the Lark", artist: "Jules Adolphe Breton"),
        ArtPiece(title: "Mahana no atua", artist: "Paul Gauguin"),
        ArtPiece(title: "Fishing in Spring", artist: "Vincent van Gogh"),
        ArtPiece(title: "Farm near Duivendrecht", artist: "Piet Mondrian"),
    ]
    
    init(){
        pixels = []
        for i in 0..<25 {
            pixels.append(Pixel(index: i))
        }
    }
    
    func GoHome() {
        selectedArt = nil
    }
    
    func SelectArt(selection: ArtPiece) {
        selectedArt = selection
    }
    
    func CheckIfWon() -> Bool {
        for pixel in pixels {
            if(pixel.offsetX != 0 || pixel.offsetY != 0) {
                //NO WIN
                return false
            }
        }
        confettiCounter += 1
        return true
    }
    
    func SolvePuzzle() {
        for i in 0..<25 {
            pixels[i].offsetX = 0
            pixels[i].offsetY = 0
        }
    }
    
    func ScramblePuzzle() {
        for i in 0..<25 {
            SwapPixels(index1: i, index2: Int.random(in: 0..<25))
        }
    }
    
    func TappedPixel(index: Int) {
        if(pixels[index].offsetX == 0 && pixels[index].offsetY == 0) {
            //Do nothing for correct pixel
        } else {
            if(selecedPixel == nil) {
                selecedPixel = index
            } else {
                SwapPixels(index1: index, index2: selecedPixel!)
                selecedPixel = nil
            }
            
            //CHECK FOR WIN
            won = CheckIfWon()
        }
    }
    
    func SwapPixels(index1: Int, index2: Int) {
        print("SWAP")
        
        //GET X AND Y FOR PIXEL ONE
        let oneX = (index1 % 5) + pixels[index1].offsetX
        let oneY = ((index1 - (index1 % 5)) / 5) + pixels[index1].offsetY
        
        //GET X AND Y FOR PIXEL TWO
        let twoX = (index2 % 5) + pixels[index2].offsetX
        let twoY = ((index2 - (index2 % 5)) / 5) + pixels[index2].offsetY
        
        //CALCULATE DIFFERENCES
        let offsetX = oneX - twoX
        let offsetY = oneY - twoY
        
        print("ONE:\(oneX),\(oneY)")
        print("TWO:\(twoX),\(twoY)")
        print("OFFSET:\(offsetX),\(offsetY)")
        
        pixels[index1].offsetX -= offsetX
        pixels[index1].offsetY -= offsetY
        
        pixels[index2].offsetX += offsetX
        pixels[index2].offsetY += offsetY
        
    }
}

struct Pixel: Identifiable {
    var id = UUID()
    var index: Int
    var offsetX: Int = 0
    var offsetY: Int = 0
}

struct ArtPiece: Identifiable {
    var id = UUID()
    var title: String
    var artist: String
    
    var file: String {
        return String((artist + title).filter { !" \n\t\r".contains($0) })
    }
}
