//
//  CommentViewController.swift
//  TikTok
//
//  Created by Акнур on 5/30/21.
//  Copyright © 2021 Aknur. All rights reserved.
//


import UIKit

protocol CommentsViewControllerDelegate: AnyObject{
    func didTapCloseForComments(with viewController: CommentViewController)
}

class CommentViewController: UIViewController {

    
    private let post:PostModel
    
    weak var delegate: CommentsViewControllerDelegate?
    
    private var comments = [PostComment]()
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CommentTableViewCell.self, forCellReuseIdentifier: CommentTableViewCell.identifier
        )
        return tableView
    }()
    private let closeButton: UIButton = {
       let button = UIButton()
        // always use systemName type when working with SF symbols
        button.setBackgroundImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        return button
    }()
    init(post: PostModel) {
        self.post = post
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(closeButton)
        view.addSubview(tableView)
        closeButton.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
       fetchPostComments()
        tableView.delegate = self
        tableView.dataSource = self
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        closeButton.frame = CGRect(x: view.width - 45, y: 10 , width: 35, height: 35)
        tableView.frame = CGRect(x: 0, y: closeButton.bottom, width: view.width, height: view.width - closeButton.bottom)
    }
    @objc private func didTapClose(){
        delegate?.didTapCloseForComments(with: self)
    }
    func fetchPostComments() {
        self.comments = PostComment.mockComments()
    }


}

extension CommentViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comment = comments[indexPath.row]
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.identifier, for: indexPath) as? CommentTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: comment)
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
