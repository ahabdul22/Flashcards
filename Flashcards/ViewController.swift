//
//  ViewController.swift
//  Flashcards
//
//  Created by Abdul Abdul on 2/14/20.
//  Copyright © 2020 Abdul Abdul. All rights reserved.
//

import UIKit

struct Flashcard {
    var question: String
    var answer: String
}

class ViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let navigationController = segue.destination as! UINavigationController
        
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self
    }

    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var flashcards = [Flashcard]()
    
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // read saved flashcards
        readSavedFlashcards()
        
        // adding our initial flashcard if needed
        if flashcards.count == 0 {
            updateFlashcard(question: "What is the capital of Kentucky", answer: "Frankfort")
        }
        else {
            updateLabels()
            updateNextPrevButtons()
        }
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        
        flipFlashcard()
    }
    
    func flipFlashcard() {
        
        UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight, animations: {
            if self.frontLabel.isHidden == true {
                self.frontLabel.isHidden = false
                
            }
            
            else {
                 self.frontLabel.isHidden = true
                
            }
           
        })
        
        
    }
    @IBAction func didTapOnNext(_ sender: Any) {
        currentIndex = currentIndex + 1
        
        updateNextPrevButtons()
        
        animateCardOut()
        
    }
    @IBAction func didTapOnPrev(_ sender: Any) {
        currentIndex = currentIndex - 1
        
        updateLabels()
        
        updateNextPrevButtons()
        
        animateCardOut()
    }
    
    func updateNextPrevButtons() {
        // Disable next button if at the end
        if currentIndex == flashcards.count - 1 {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
        
        if currentIndex == 0 {
            prevButton.isEnabled = false
            
        } else {
            prevButton.isEnabled = true
            
        }
    }
    func updateFlashcard(question: String, answer: String) {
        let flashcard = Flashcard(question: question, answer: answer)
        
      
        flashcards.append(flashcard)
        
        // logging to the console
        print("Added new flashcard")
        print("We now have \(flashcards.count) flashcard(s)")
        
        currentIndex = flashcards.count - 1
        print("Our current index is \(currentIndex)")
        
        // update buttons
        updateNextPrevButtons()
        
        // update lables
        updateLabels()
        
        saveAllFlashcardsToDisk()
        
        
        
    }
    
    func updateLabels(){
        
        let currentFlashcard = flashcards[currentIndex]
        
       frontLabel.text = currentFlashcard.question
       backLabel.text = currentFlashcard.answer
        
        
    }
    
    func animateCardOut() {
        UIView.animate(withDuration: 0.3, animations: {
            self.card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)
        
        }, completion: { finished in
            
            self.updateLabels()
        
            self.animateCardIn()
        })
    
    }
    
    func animateCardIn() {
        
        card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
        
        UIView.animate(withDuration: 0.3) {
            self.card.transform = CGAffineTransform.identity
            
        }
        
    }
    
    func saveAllFlashcardsToDisk() {
        
        let dictionaryArray = flashcards.map { (card) -> [String: String] in
            return ["question": card.question, "answer": card.answer]
        }
        
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        
        print("Flashcards saved to UserDefaults")
    }
    
    func readSavedFlashcards(){
        
        if let dictionary = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]]{
            
            let savedCards = dictionary.map { dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)
                
            }
            
            flashcards.append(contentsOf: savedCards)
        }
    }
    
    
}

