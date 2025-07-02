//
//  StatisticService.swift
//  MovieQuiz
//
//  Created by User on 09.06.2025.
//
import Foundation
class StatisticService: StatisticServiceProtocol {
    
    private enum Keys: String {
        case gamesCount = "gamesCount"
        case bestGameCorrect = "bestGameCorrect"
        case bestGameTotal = "bestGameTotal"
        case bestGameDate = "bestGameDate"
        case totalCorrectAnswers = "totalCorrectAnswers"
        case totalQuestionsAnswered = "totalQuestionsAnswered"
        case bestGame = "bestGame"
    }
    
    private let storage: UserDefaults = .standard
    private let questionsAmount = 10
    
    var totalCorrectAnswers: Int {
            get {
                storage.integer(forKey: Keys.totalCorrectAnswers.rawValue)
            }
            set {
                storage.set(newValue, forKey: Keys.totalCorrectAnswers.rawValue)
            }
        }
    var totalQuestionsAnswered: Int {
            get {
                storage.integer(forKey: Keys.totalQuestionsAnswered.rawValue)
            }
            set {
                storage.set(newValue, forKey: Keys.totalQuestionsAnswered.rawValue)
            }
        }
    var gamesCount: Int {
            get {
                storage.integer(forKey: Keys.gamesCount.rawValue)
            }
            set {
                storage.set(newValue, forKey: Keys.gamesCount.rawValue)
            }
        }
        
    
    var bestGame: GameResult {
            get {
                let correct = storage.integer(forKey: Keys.bestGameCorrect.rawValue)
                let total = storage.integer(forKey: Keys.bestGameTotal.rawValue)
                let date = storage.object(forKey: Keys.bestGameDate.rawValue) as? Date ?? Date()
                return GameResult(correct: correct, total: total, date: date)
            }
            set {
                storage.set(newValue.correct, forKey: Keys.bestGameCorrect.rawValue)
                storage.set(newValue.total, forKey: Keys.bestGameTotal.rawValue)
                storage.set(newValue.date, forKey: Keys.bestGameDate.rawValue)
            }
        }
    
    var totalAccuracy: Double {
        
            let totalQuestions = Double(gamesCount * questionsAmount)
            guard totalQuestions > 0 else { return 0.0 }
            return (Double(totalCorrectAnswers) / totalQuestions) * 100
        }
    func store(correct count: Int, total amount: Int) {
            
       
            totalCorrectAnswers += count

            gamesCount += 1
      
            let currentResult = GameResult(correct: count, total: amount, date: Date())
            
          
            if currentResult.isBetterThan(bestGame) {
                bestGame = currentResult
            }
            
        }
    
}
