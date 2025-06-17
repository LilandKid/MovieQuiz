//
//  GameResult.swift
//  MovieQuiz
//
//  Created by User on 17.06.2025.
//
import Foundation
struct GameResult: Codable {
    let correct: Int
    let total: Int
    let date: Date
    
    func isBetterThan(_ another: GameResult) -> Bool {
            correct > another.correct
        }
    
}
