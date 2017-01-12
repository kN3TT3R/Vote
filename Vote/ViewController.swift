//
//  ViewController.swift
//  Vote
//
//  Created by Kenneth Debruyn on 10/01/17.
//  Copyright © 2017 kN3TT3R. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    // MARK: - Global Variables
    var republicanVotes = Vote(counter: 0)
    var democraticVotes = Vote(counter: 0)
    var showOrHideDisplaysCounter = 0
    
    
    // MARK: - IBOutlets
    @IBOutlet weak var republicanVoteResultsDisplay: UILabel!
    @IBOutlet weak var democraticVoteResultsDisplay: UILabel!
    @IBOutlet weak var republicanVote: UIButton!
    @IBOutlet weak var democraticVote: UIButton!
    @IBOutlet weak var resetVoteResults: UIButton!
    @IBOutlet weak var showOrHideDisplays: UIButton!
    @IBOutlet weak var winnersDisplay: UIImageView!
    @IBOutlet weak var announceTheNewPresident: UIButton!
    
    
    // MARK: - Overridden Functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Structures
    struct Vote {
        var counter: Int
        
        func isBiggerThen(votes: Vote) -> Bool {
            if self.counter > votes.counter {
                return true
            } else {
                return false
            }
        }
    }

    
    // MARK: - IBActions
    @IBAction func addVote(_ sender: UIButton) {
        if sender.tag == 0 {
            republicanVotes.counter += 1
        } else if sender.tag == 1 {
            democraticVotes.counter += 1
        }
    }
    
    @IBAction func showOrHideDisplays(_ sender: UIButton) {
        if showOrHideDisplaysCounter % 2 == 0 {
            enableVoteButtons(false)
            resetVoteResults.isEnabled = true
            showOrHideDisplays.setTitle("Hide Results", for: .normal)
            update(republicanVoteResultsDisplay, with: republicanVotes)
            update(democraticVoteResultsDisplay, with: democraticVotes)
            republicanVoteResultsDisplay.isHidden = false
            democraticVoteResultsDisplay.isHidden = false
            showOrHideDisplaysCounter += 1
        } else {
            enableVoteButtons(true)
            resetVoteResults.isEnabled = false
            showOrHideDisplays.setTitle("Show Results", for: .normal)
            republicanVoteResultsDisplay.isHidden = true
            democraticVoteResultsDisplay.isHidden = true
            showOrHideDisplaysCounter += 1
        }
    }
    
    @IBAction func resetVoteResults(_ sender: UIButton) {
        republicanVotes.counter = 0
        democraticVotes.counter = 0
        update(republicanVoteResultsDisplay, with: republicanVotes)
        update(democraticVoteResultsDisplay, with: democraticVotes)
        enableVoteButtons(false)
    }
    
    @IBAction func displayTheNextPresident(_ sender: UIButton) {
        hideUIItems()
        if republicanVotes.isBiggerThen(votes: democraticVotes) {
            winnersDisplay.image = #imageLiteral(resourceName: "RepublicanLogo")
            winnersDisplay.isHidden = false
        } else {
            winnersDisplay.image = #imageLiteral(resourceName: "DemocraticLogo")
            winnersDisplay.isHidden = false
        }
    }
    
    
    // MARK: - Homemade Functions
    func update(_ votesDisplay: UILabel, with votes: Vote) {
        votesDisplay.text = String(votes.counter)
    }
    
    func enableVoteButtons(_ bool: Bool) {
        republicanVote.isEnabled = bool
        democraticVote.isEnabled = bool
    }
    
    func hideUIItems() {
        republicanVoteResultsDisplay.isHidden = true
        democraticVoteResultsDisplay.isHidden = true
        republicanVote.isHidden = true
        democraticVote.isHidden = true
        resetVoteResults.isHidden = true
        showOrHideDisplays.isHidden = true
        announceTheNewPresident.isHidden = true
    }
    
    func showAlert(_ alert: String, withTitle title: String) {
        let alertController = UIAlertController(title: title, message:
            alert, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
}

