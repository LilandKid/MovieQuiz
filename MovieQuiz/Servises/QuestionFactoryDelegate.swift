//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by User on 04.06.2025.
//
//MARK:QuestionFactoryDelegate 
protocol QuestionFactoryDelegate: AnyObject {               
    func didReceiveNextQuestion(question: QuizQuestion?)
    func didLoadDataFromServer()
    func didFailToLoadData(with error: Error)
}
