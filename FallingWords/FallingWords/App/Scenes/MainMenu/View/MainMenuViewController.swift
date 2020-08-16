//
//  ViewController.swift
//  FallingWords
//
//  Created by Osama Bashir on 8/15/20.
//  Copyright © 2020 Osama Bashir. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!

    var viewModel: MainMenuViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        viewModel.viewDidLoad()
    }
    
    private func bindViewModel() {
        titleLabel.text = viewModel.title
        playButton.setTitle(viewModel.buttonTitle, for: .normal)
        viewModel.score = { [weak self] (totalScore) in self?.scoreLabel.text = totalScore }
    }
    
    @IBAction func didTapOnPlay(_ sender: UIButton) {
        viewModel.didTapOnPlay()
    }

}

