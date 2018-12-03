//
//  MainMenuController.swift
//  iOS Task Manager
//
//  Created by Sawyer Shirley on 11/27/18.
//  Copyright © 2018 Sawyer Shirley. All rights reserved.
//

import UIKit

class MainMenuController: UIViewController {

    @IBOutlet weak var blueBubble: UIImageView!
    @IBOutlet weak var pinkBubble: UIImageView!

            override func viewDidLoad() {
            super.viewDidLoad()
                
            moveBlueBubbleUp()
            movePinkBubbleUp()
        // Do any additional setup after loading the view.
    }
    
    func moveBlueBubbleUp() {
        UIView.animate(withDuration: 3,
                       delay: 1,
                       animations: {
                        self.blueBubble.frame.origin.y -= 50
        }, completion: { finished in
            self.moveBlueBubbleDown()
        })
    }
    
    func moveBlueBubbleDown() {
        UIView.animate(withDuration: 3, animations: {
            self.blueBubble.frame.origin.y = 50
        }, completion: nil)
        moveBlueBubbleUp()
    }

    func movePinkBubbleUp() {
        UIView.animate(withDuration: 2,
                       delay: 1,
                       animations: {
            self.pinkBubble.frame.origin.y -= 50
        }, completion: { finished in
            self.movePinkBubbleDown()
        })
    }
    
    func movePinkBubbleDown() {
        UIView.animate(withDuration: 3, animations: {
            self.pinkBubble.frame.origin.y = 50
        }, completion: nil)
        movePinkBubbleUp()
    }
    
    
}
