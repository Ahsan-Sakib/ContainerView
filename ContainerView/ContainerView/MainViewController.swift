//
//  ViewController.swift
//  ContainerView
//
//  Created by Ahsanul Kabir on 18/4/20.
//  Copyright © 2020 ahsanul.kabir. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

//        let alert = UIAlertController(title: NSLocalizedString("ALERT_TITLE", comment: ""), message: NSLocalizedString("INTERNET_CONNECTION_ERROR_MESSAGE", comment: ""), preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: NSLocalizedString("CANCEL", comment: ""), style: .default, handler: nil))
//        self.present(alert, animated: true, completion: nil)

    }
    private func setupView() {
        setupSegmentedControl()
        updateView()
    }
    private func setupSegmentedControl() {
        // Configure Segmented Control
        segmentedControl.removeAllSegments()
        segmentedControl.insertSegment(withTitle: "Summary", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Sessions", at: 1, animated: false)
        segmentedControl.addTarget(self, action: #selector(selectionDidChange(_:)), for: .valueChanged)
        
        // Select First Segment
        segmentedControl.selectedSegmentIndex = 0
    }
    @objc func selectionDidChange(_ sender: UISegmentedControl) {
        updateView()
    }
    
    private func updateView() {
        if segmentedControl.selectedSegmentIndex == 0 {
            add(asChildViewController: summaryViewController)
            remove(asChildViewController: sessionsViewController)
           
        } else {
            remove(asChildViewController: summaryViewController)
            add(asChildViewController: sessionsViewController)
        }
    }
    
    private lazy var summaryViewController: SummaryViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "SummaryViewController") as! SummaryViewController
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var sessionsViewController: SessionVC = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "SessionVC") as! SessionVC
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChild(viewController)
        
        // Add Child View as Subview
        view.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParent: self)
    }
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParent: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParent()
    }
}

