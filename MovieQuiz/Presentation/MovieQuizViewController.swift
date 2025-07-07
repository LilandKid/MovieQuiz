import UIKit

final class MovieQuizViewController: UIViewController,MovieQuizViewControllerProtocol {
    
    
    @IBOutlet  weak var moviePosterImage: UIImageView!
    
    @IBOutlet  weak var questionIndexLabel: UILabel!
    
    @IBOutlet private weak var textLabel: UILabel!
    private var statisticService: StatisticServiceProtocol!
    var loadingIndicator = UIActivityIndicatorView(style: .medium)
    
    
    var posterImageView: UIImageView { moviePosterImage }
    
    var presenter: MovieQuizPresenter!
    
    
   
    
    private var alertPresenter: AlertPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MovieQuizPresenter(viewController: self)
        
        self.alertPresenter = AlertPresenter(viewController: self)
        self.statisticService = StatisticService()
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        moviePosterImage.addSubview(loadingIndicator)
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: moviePosterImage.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: moviePosterImage.centerYAnchor)
        ])
        moviePosterImage.layer.borderWidth = 0
        moviePosterImage.layer.borderColor = nil
        statisticService = StatisticService()
        
        showLoadingIndicator()
        presenter.questionFactory?.loadData()
        
    }
    
    
    
    
    
  
    
     func showLoadingIndicator() {
        DispatchQueue.main.async {
            self.loadingIndicator.isHidden = false
            self.loadingIndicator.startAnimating()
        }
    }
     func hideLoadingIndicator() {
        DispatchQueue.main.async {
            if self.loadingIndicator.isAnimating {
                self.loadingIndicator.stopAnimating()
            }
            self.loadingIndicator.isHidden = true
        }
    }
    
     func showNetworkError(message: String) {
        hideLoadingIndicator()
        
        let model = AlertModel(title: "Ошибка",
                               message: message,
                               buttonText: "Попробовать еще раз") { [weak self] in
            guard let self = self else { return }
            
            presenter.restartGame()
            
            self.presenter.questionFactory?.requestNextQuestion()
        }
        
        alertPresenter?.presentAlert(with: model)
    }
    
    private func setUpImageView() {
        moviePosterImage.layer.masksToBounds = true
    }
    
    
    
    func show(quiz step: QuizStepViewModel) {
        moviePosterImage.image = step.image
        textLabel.text = step.question
        questionIndexLabel.text = step.questionNumber
    }
    
    func show(quiz result: QuizResultsViewModel) {
        
        let message = presenter.makeResultsMessage()
    
        let alertModel = AlertModel(
            title: result.title,
            message: message,
            buttonText: result.buttonText,
            completion: { [weak self] in
                guard let self = self else { return }
                self.presenter.restartGame()
                
            }
        )
        
        alertPresenter?.presentAlert(with: alertModel)
    }
    
    func highlightImageBorder(isCorrect: Bool) {
        
        moviePosterImage.layer.borderWidth = 8
        moviePosterImage.layer.borderColor = isCorrect ? UIColor.systemGreen.cgColor : UIColor.systemRed.cgColor
       
    }
  
    
    
    
    
    @IBAction  func noButtonClicked(_ sender: UIButton) {
        presenter.noButtonClicked()
    }
    
        @IBAction func yesButtonClicked(_ sender: UIButton) {
            presenter.yesButtonClicked()
        }
    
}
