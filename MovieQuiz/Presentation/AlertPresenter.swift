
//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by User on 08.06.2025.
//
import UIKit

final class AlertPresenter: AlertPresenterProtocol {
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func presentAlert(with model: AlertModel) {
        let alertController = UIAlertController(title: model.title, message: model.message, preferredStyle: .alert)
        let action = UIAlertAction(title: model.buttonText, style: .default) { _ in
            model.completion?()
        }
        alertController.addAction(action)
        viewController?.present(alertController, animated: true, completion: nil)
    }
}
