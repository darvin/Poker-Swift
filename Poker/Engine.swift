//
//  Engine.swift
//  Poker
//
//  Created by Sergey Klimov on 4/22/15.
//  Copyright (c) 2015 Sergey Klimov. All rights reserved.
//

import Darwin

public protocol Card  {
}



public protocol Nextable {
    func next()->Self?
    static func first()->Self

}

public protocol CardSuit : Nextable {
}

public protocol CardRank : Nextable{
}



public final class SuitedRankedCard <CardSuitType:CardSuit, CardRankType:CardRank>: Card, CustomStringConvertible  {
    let rank:CardRankType
    let suit:CardSuitType
    
    init(suit:CardSuitType, rank:CardRankType) {
        self.suit = suit
        self.rank = rank
    }
    
    public var description: String {
        return "\(rank)\(suit)"
    }
    
    public static func allCards()->[SuitedRankedCard] {
        var result = [SuitedRankedCard<CardSuitType, CardRankType>]()
        let firstRank = CardRankType.first()
        var lastCard:SuitedRankedCard<CardSuitType, CardRankType>? = SuitedRankedCard<CardSuitType, CardRankType>(suit: CardSuitType.first(), rank: firstRank)
        
        while ((lastCard) != nil) {
            result.append(lastCard!)
            if let newRank = lastCard!.rank.next(){
                lastCard = SuitedRankedCard<CardSuitType, CardRankType>(suit:lastCard!.suit, rank:newRank)
            } else {
                if let newSuit = lastCard!.suit.next() {
                    lastCard = SuitedRankedCard<CardSuitType, CardRankType>(suit:newSuit, rank:firstRank)
                } else {
                    lastCard = nil
                }
            }
        }
       
        return result
        
    }
}


public enum PokerSuit :  Int, CardSuit, CustomStringConvertible {
    case Spade, Heart, Diamond, Club
    
    public func next()->PokerSuit? {
        return PokerSuit(rawValue:self.rawValue+1)
    }
    public static func first()->PokerSuit {
        return .Spade
    }

    
    public var description: String {
        switch (self) {
        case .Spade:
            return "♠"
        case .Heart:
            return "♥"
        case .Diamond:
            return "♦"
        case .Club:
            return "♣"
        }
    }
    
}

public enum PokerRank: Int, CardRank, CustomStringConvertible {
    case Two = 2, Three, Four, Five, Six, Seven, Eight, Nine, Ten
    case Jack, Queen, King, Ace
    
    public func next()->PokerRank? {
        return PokerRank(rawValue:self.rawValue+1)
    }
    public static func first()->PokerRank {
        return .Two
    }
    public var description: String {
        switch (self) {
        case .Two, .Three, .Four, .Five, .Six, .Seven, .Eight, .Nine, .Ten:
            return "\(self.rawValue)"
        case .Jack:
            return "J"
        case .Queen:
            return "Q"
        case .King:
            return "K"
        case .Ace:
            return "A"
        }
        
    }
    
}

public typealias PokerCard = SuitedRankedCard<PokerSuit,PokerRank>




extension Array {
    mutating func shuffle() {
        for i in 0..<(count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            swap(&self[i], &self[j])
        }
    }
}



public struct Deck<T:Card> :CustomStringConvertible {
    var cards = [T]()
    
    
    mutating func add(card: T) {
        cards.append(card)
    }
    
    mutating func draw()->T? {
        let card = cards.last
        if card != nil {
            cards.removeLast()
        }
        return card
    }
    
    mutating func shuffle() {
       cards.shuffle()
    }
    
    public var description: String {
        var result = ""
        for card in cards {
            result += " \(card)"
        }
        return result
    }
    
    public var count:Int {
        return cards.count
    }
    
    init(cards:[T]) {
        self.cards = cards
        shuffle()
    }
    


}

class Player {
    var name:String
}

protocol GameZone {
    func isVisible(player:Player)->Bool
    var name:String {get}
    var cards:[Card]? {get}
    func add(card:Card)
    func remove(card:Card)
}


class PokerDeck:GameZone {
    func isVisible(player:Player)->Bool { return false }
    var name:String { return "DECK_ZONE" }
    var cards:[Card]? { return nil }
    func add(card:Card) {
        assert(false, "Play fair!")
    }
    
    func remove(card:Card) {
        assert(false, "Play fair!")
    }
    
    var deck:Deck<PokerCard>=Deck<PokerCard>(cards:PokerCard.allCards())
    
    func draw()->PokerCard? {
        return deck.draw()
    }

}



public class GameEngine  {
    
    struct Po {
        var cards = []
    }
//    var gameZones = [String:GameZone]
    
    
    public static func pokerDeck() -> Deck<PokerCard> {
        return Deck<PokerCard>(cards:PokerCard.allCards())
    }
   
}
