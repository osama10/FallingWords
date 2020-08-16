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

    var viewModel: GameScreenViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        viewModel.viewDidLoad()
    }

    private func bindViewModel() {
        viewModel.answer = { [weak self] (result) in self?.resultLabel.text = result }
        viewModel.word = { [weak self] (word) in self?.wordLabel.text = word }
        wordTitleLabel.text = viewModel.wordTitle
    }
    
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
