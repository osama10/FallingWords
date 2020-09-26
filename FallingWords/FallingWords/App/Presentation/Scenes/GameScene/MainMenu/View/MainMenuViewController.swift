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
        setStaticData()
        bindViewModel()
        viewModel.viewDidLoad()
    }
    
    private func setStaticData() {
        titleLabel.text = viewModel.title
        playButton.setTitle(viewModel.buttonTitle, for: .normal)
    }
    
    private func bindViewModel() {
        viewModel.score.observe(on: self){ [weak self] in self?.scoreLabel.text = $0 }
    }
    
    @IBAction func didTapOnPlay(_ sender: UIButton) {
        viewModel.didTapOnPlay()
    }

}

