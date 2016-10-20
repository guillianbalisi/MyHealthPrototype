//
//  IntroductionViewController.swift
//  MyHealthPrototype
//
//  Created by Guillian Balisi on 2016-10-12.
//  Copyright © 2016 Guillian Balisi. All rights reserved.
//

import UIKit

class IntroductionViewController: UIPageViewController, UIPageViewControllerDataSource {
    // MARK: Properties
    
    let pageViewControllers: [UIViewController] = {
        let introOne = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "introOneViewController")
        let introTwo = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "introTwoViewController")
        let introThree = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "introThreeViewController")
        
        return [introOne, introTwo, introThree]
    }()
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let pageControlAppearance = UIPageControl.appearance(whenContainedInInstancesOf: [type(of: self)])
//        pageControlAppearance.pageIndicatorTintColor = UIColor.black
//        pageControlAppearance.currentPageIndicatorTintColor = UIColor.init(colorLiteralRed: 180.0, green: 0.0, blue: 0.0, alpha: 1.0)
        
        // Do any additional setup after loading the view.
        dataSource = self
        
        setViewControllers([pageViewControllers[0]], direction: .forward, animated: false, completion: nil)
    }
    
    // MARK: UIPageViewControllerDataSource
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index = pageViewControllers.index(of: viewController)!
        
        if index - 1 >= 0 {
            return pageViewControllers[index - 1]
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index = pageViewControllers.index(of: viewController)!
        
        if index + 1 < pageViewControllers.count {
            return pageViewControllers[index + 1]
        }
        
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pageViewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
