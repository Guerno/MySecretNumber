//
//  MainViewController.swift
//  MySecretNumber
//
//  Created by GUERNEVÉ Sébastien on 28/11/2020.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var ui_testValueStackView : UIStackView!
    @IBOutlet weak var ui_userValueTextField: UITextField!
    @IBOutlet weak var ui_boundarysView: UIView!
    @IBOutlet weak var cs_boundaryLeading: NSLayoutConstraint!
    @IBOutlet weak var cs_boundaryTrailing: NSLayoutConstraint!
    @IBOutlet weak var ui_visuBarre: UIView!
    @IBOutlet weak var ui_lowBoundaryLabelNumber: UILabel!
    @IBOutlet weak var ui_highBoundaryLadelNumber: UILabel!
    @IBOutlet weak var ui_gameView: UIView!
    
    private var marginRatio: CGFloat = 1
    
    let game = SecretNumberManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func ui_startNewGameButtonTouchedUpInside() {
        game.starNewGame(withMyNumber: 50)
        updateScreen()
    }
    
    @IBAction func ui_testUserValueButtonTouchedUpInside() {
        guard game.IsInProgress else { return }
        if let number = Int(ui_userValueTextField.text!) {
            game.testUserProposal(number)
            updateScreen()
        }
        ui_userValueTextField.text = nil
    }
    
    override func viewDidLayoutSubviews() {
//        print("passage to viewDidLayoutSubviews")
        let newMargin = ui_gameView.frame.width / CGFloat(Double(SecretNumberManager.MAX_BOUNDARY - SecretNumberManager.MIN_BOUNDARY))
        if marginRatio != newMargin {
//            print("***newMargin***")
            marginRatio = newMargin
            updateScreen()
        }
        super.viewDidLayoutSubviews()
    }
    
    private func updateScreen() {
//        print("passage to updateScreen")
        if game.IsInProgress {
//            print("passage to updateScreen/Game is in progress")
            if ui_gameView.isHidden != false {
                UIView.transition(with: ui_gameView, duration: 0.4, options: [.transitionCurlDown], animations: {
                    self.ui_gameView.isHidden = false
                }, completion: nil)
//                print("passage to updateScreen/isHidden false")
            }
            
            cs_boundaryLeading.constant = CGFloat(game.lowBoundary) * marginRatio
            cs_boundaryTrailing.constant = CGFloat(SecretNumberManager.MAX_BOUNDARY - game.highBoundary) * marginRatio
            
            ui_lowBoundaryLabelNumber.text = String(game.lowBoundary)
            ui_highBoundaryLadelNumber.text = String(game.highBoundary)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 30, options: [.curveEaseIn], animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        } else {
//            print("passage to updateScreen/Game isn't progress")
            if ui_gameView.isHidden != true {
                UIView.transition(with: ui_gameView, duration: 0.4, options: [.transitionCurlUp], animations: {
                    self.ui_gameView.isHidden = true
                }, completion: nil)
                
                resignFirstResponderUserValueTextField()
//                print("passage to updateScreen/isHidden true")
            }
        }
        print()
    }
    
    @IBAction func gr_viewTape() {
        resignFirstResponderUserValueTextField()
    }
    
    private func resignFirstResponderUserValueTextField() {
        ui_userValueTextField.resignFirstResponder()
    }
}

