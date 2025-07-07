//
//  MovieQuizViewControllerProtocol.swift
//  MovieQuiz
//
//  Created by User on 06.07.2025.
//
import UIKit

protocol MovieQuizViewControllerProtocol: AnyObject {
    func show(quiz step: QuizStepViewModel)
    func show(quiz result: QuizResultsViewModel)
    
    func highlightImageBorder(isCorrect: Bool)
    
    func showLoadingIndicator()
    func hideLoadingIndicator()
    
    func showNetworkError(message: String)
    
    var posterImageView: UIImageView { get }
    
}
