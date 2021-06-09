//
//  HomeViewController.swift
//  TikTok
//
//  Created by Акнур on 5/18/21.
//  Copyright © 2021 Aknur. All rights reserved.
//


import UIKit


class HomeViewController: UIViewController {
    
    let horizontalScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        
        return scrollView
    }()
    
    let control: UISegmentedControl = {
        let titles = ["Following", "For You"]
        let control = UISegmentedControl(items: titles)
        control.selectedSegmentIndex = 1
        control.backgroundColor = nil
        control.selectedSegmentTintColor = .white
        return control
    }()
    
    let forYouPageViewController = UIPageViewController(transitionStyle: .scroll,
                                                        navigationOrientation: .vertical, options: [:]
    )
    
    let followingPageController = UIPageViewController(transitionStyle: .scroll,
                                                       navigationOrientation: .vertical, options: [:]
    )
    
    private var forYouPosts = PostModel.mockModels()
    private var followingPosts = PostModel.mockModels()
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(horizontalScrollView)
        view.backgroundColor = .systemBackground
        setupFeed()
        horizontalScrollView.delegate = self
        horizontalScrollView.contentOffset = CGPoint(x: view.width, y: 0)
        setupHeaderButtons()
        //        horizontalScrollView.contentOffset()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        horizontalScrollView.frame = view.bounds
        
    }
    func setupHeaderButtons() {
        control.addTarget(self, action: #selector(didChangeSegmentedControl(_:)), for: .valueChanged)
        navigationItem.titleView = control
    }
    
    @objc func didChangeSegmentedControl(_ sender: UISegmentedControl) {
        horizontalScrollView.setContentOffset(CGPoint(x: view.width * CGFloat(sender.selectedSegmentIndex), y: 0),
                                              animated: true)
    }
    private func setupFeed(){
        horizontalScrollView.contentSize = CGSize(width: view.width * 2, height: view.height)
        setupFollowingFeed()
        setUpForYouFeed()
    }
    
    
    func setupFollowingFeed(){
        guard let model = followingPosts.first else {
            return
        }
        
        let vc =  PostViewController(model: model)
        vc.delegate = self
        followingPageController.setViewControllers([vc],
                                                   direction: .forward,
                                                   animated: false,
                                                   completion: nil
        )
        
        followingPageController.dataSource = self
        
        horizontalScrollView.addSubview(followingPageController.view)
        followingPageController.view.frame = CGRect(x: 0,
                                                    y: 0,
                                                    width:horizontalScrollView.width,
                                                    height: horizontalScrollView.height)
        addChild(followingPageController)
        followingPageController.didMove(toParent: self)
        
    }
    
    func setUpForYouFeed(){
        guard let model = forYouPosts.first else {
            return
        }
        let vc = PostViewController(model: model)
        vc.delegate = self
        forYouPageViewController.setViewControllers([vc],
                                                    direction: .forward,
                                                    animated: false,
                                                    completion: nil
        )
        forYouPageViewController.dataSource = self
        
        horizontalScrollView.addSubview(forYouPageViewController.view)
        forYouPageViewController.view.frame = CGRect(x: view.width,
                                                     y: 0,
                                                     width:horizontalScrollView.width,
                                                     height: horizontalScrollView.height)
        addChild(forYouPageViewController)
        forYouPageViewController.didMove(toParent: self)
        
    }
}

extension HomeViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let fromPost = (viewController as? PostViewController)?.model else {
            return nil
        }
        guard let index = currentPosts.firstIndex(where: { $0.identifier == fromPost.identifier}) else {
            return nil
        }
        if index == 0 {
            return nil
        }
        
        let priorIndex = index - 1
        let model = currentPosts[priorIndex]
        let vc = PostViewController(model: model)
        vc.delegate = self
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let fromPost = (viewController as? PostViewController)?.model else {
            return nil
        }
        guard let index = currentPosts.firstIndex(where: { $0.identifier == fromPost.identifier}) else {
            return nil
        }
        guard index < (currentPosts.count - 1) else {
            return nil
        }
        let nextIndex = index + 1
        let model = currentPosts[nextIndex]
        let vc = PostViewController(model: model)
        vc.delegate = self
        return vc
    }
    
    var currentPosts: [PostModel] {
        if horizontalScrollView.contentOffset.x == 0 {
            //Following
            return followingPosts
        }
        // For You
        return forYouPosts
    }
}

extension HomeViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x == 0 || scrollView.contentOffset.x <= (view.width/2) {
            control.selectedSegmentIndex = 0
        }
        else if scrollView.contentOffset.x > (view.width/2) {
            control.selectedSegmentIndex = 1
        }
    }
    func postViewController(_ vc: PostViewController, didTapProfileButtonFor post: PostModel){
        let user = post.user
        let vc = ProfileViewController(user: user)
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension HomeViewController: PostViewControllerDelegate {
    func postViewController(_ vc: PostViewController, didTapCommentButtonFor post: PostModel) {

            horizontalScrollView.isScrollEnabled = false
            if horizontalScrollView.contentOffset.x == 0 {
                followingPageController.dataSource = nil
            }
            else {
                forYouPageViewController.dataSource = nil
            }
            let vc = CommentViewController(post: post)
            vc.delegate = self
            addChild(vc)
            vc.didMove(toParent: self)
            view.addSubview(vc.view)
        // dont need foo  function i dont know why you are using it there
        // also you forget to add the animation to frame
        // happy coding 🌹
        let frame: CGRect = CGRect(x: 0, y: view.height, width: view.width, height: view.height * 0.76)
        vc.view.frame = frame
        UIView.animate(withDuration: 0.2) {
            
            vc.view.frame = CGRect(x: 0, y: self.view.height - frame.height, width: frame.width, height: frame.height)

        }
    }
}


extension HomeViewController: CommentsViewControllerDelegate {
    func didTapCloseForComments(with viewController: CommentViewController) {

        let frame = viewController.view.frame
        UIView.animate(withDuration: 0.2, animations: {
               viewController.view.frame = CGRect(x: 0, y: self.view.height , width: frame.width, height: frame.height)

        }) { [weak self] done  in
            if done {
                DispatchQueue.main.async {
                    viewController.view.removeFromSuperview()
                    viewController.removeFromParent()
                    self?.horizontalScrollView.isScrollEnabled = true
                    self?.forYouPageViewController.dataSource = self
                    self?.followingPageController.dataSource = self
                }
        }
    }
}
}
