//
//  GameScreenViewController.swift
//  FallingWords
//
//  Created by Osama Bashir on 8/15/20.
//  Copyright © 2020 Osama Bashir. All rights reserved.
//

import UIKit

class GameScreenViewController: UIViewController {
    
    @IBOutlet weak var wordTitleLabel: UILabel!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var rightAnswerButton: UIButton!
    @IBOutlet weak var wrongAnswerButton: UIButton!
    
    var translationLabel: UILabel!
    
    var viewModel: GameScreenViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTranslationLabel()
        bindViewModel()
        viewModel.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.viewDidAppear()
    }
    
    private func bindViewModel() {
       
        viewModel.answer = { [weak self] (result) in self?.resultLabel.text = result }
        viewModel.word = { [weak self] (word) in self?.wordLabel.text = word }
        viewModel.updateTimer = { [weak self] (remainingTime) in self?.timerLabel.text = remainingTime }
        viewModel.disableButtonInteractions = { [weak self] in self?.setButtonInteraction(enabled: false) }
        wordTitleLabel.text = viewModel.wordTitle

        viewModel.showTranslation = { [weak self] in
            self?.animateTranslationLabel()
            self?.setButtonInteraction(enabled: true)
        }
        
        viewModel.translation = { [weak self] (translation) in
            self?.translationLabel.text = translation
            self?.translationLabel.setWidth()
        }
        
        viewModel.setTranslationPosition = { [weak self] in
            let translationWidth = Double(self?.translationLabel.frame.size.width ?? 0)
            let totalWidth = Double(UIScreen.main.bounds.width)
            let xPos = self?.viewModel.calculateTranslationPosition(translationWidth: translationWidth , totalWidth: totalWidth)
            self?.translationLabel.frame.origin.x = CGFloat(xPos ?? 0.0)
        }
        
        viewModel.hideTranslation = { [weak self] in
            self?.translationLabel.isHidden = true
            self?.translationLabel.layer.removeAllAnimations()
            self?.translationLabel.frame.origin = CGPoint(x: 150, y: -30)
        }
        
    }
    
    private func setupTranslationLabel() {
        translationLabel = UILabel(frame: CGRect(x: 150, y: -30, width: 200, height: 100))
        translationLabel.font = .translationWordFont
        translationLabel.textColor = .white
        translationLabel.isHidden = true
        translationLabel.textAlignment = .center
        view.addSubview(translationLabel)
    }
    
    private func animateTranslationLabel() {
        translationLabel.isHidden = false
        UIView.animate(withDuration: 11, delay: 0.5, options: []
            , animations: { self.translationLabel.frame.origin.y = UIScreen.main.bounds.height},
              completion: { (isCompleted) in if isCompleted { self.viewModel.didTranslationOutOfScreen() } }
        )
    }
    
    private func setButtonInteraction(enabled: Bool) {
        rightAnswerButton.isUserInteractionEnabled = enabled
        wrongAnswerButton.isUserInteractionEnabled = enabled
    }
}

extension GameScreenViewController {
    
    @IBAction func didTapOnCloseButton(_ sender: UIButton) {
        viewModel.didTapOnCloseButton()
    }
    
    @IBAction func didTapRightButton(_ sender: UIButton) {
        viewModel.didTapOnRightAnswerButton()
    }
    
    @IBAction func didTapOnWrongButton(_ sender: UIButton) {
        viewModel.didTapOnWrongAnserButton()
    }
}
