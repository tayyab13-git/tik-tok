//
//  ExploreViewController.swift
//  TikTok
//
//  Created by Акнур on 5/18/21.
//  Copyright © 2021 Aknur. All rights reserved.
//

import UIKit

class ExploreViewController: UIViewController {
    
    
    private let searchBar: UISearchBar = {
        let bar  = UISearchBar()
        bar.placeholder = "Search"
        bar.layer.cornerRadius = 8
        bar.keyboardType = .alphabet
        bar.layer.masksToBounds = true
        return bar
    }()
    
    private var sections = [ExploreSection]()
    
    private var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // happy coding 🌸
        setUpSearchBar()
        setUpCollectionView()
        configureModel()
        view.backgroundColor = .systemBackground
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame  = view.bounds
    }
    func setUpSearchBar(){
        navigationItem.titleView = searchBar
        searchBar.delegate = self
    }
//    private func configureModels(){
//
//
//        var cells = [ExploreCell]()
//        for _ in 0...1000 {
//            let cell = ExploreCell.banner(viewModel: ExploreBannerViewModel(
//                image: UIImage(named: "banner1"), title: "Foo", handler: {
//
//                }
//            )
//            )
//            cells.append(cell)
//        }
//
//        //Banner
//
//        sections.append(
//            ExploreSection(
//                type: .banners,
//                cells: cells
//            )
//        )
//
//        var posts = [ExploreCell]()
//
//        for _ in 0...40{
//            posts.append(
//                ExploreCell.post(viewModel: ExplorePostViewModel(thumbnaiImage: UIImage(named: "banner1"), caption: "gvuyivigvob", handler: {
//
//                }))
//
//            )
//
//        }
//        //Trending Posts
//        sections.append(ExploreSection(
//            type: .trendingPosts,
//            cells: posts
//
//        )
//        )
//        //users
//        sections.append(ExploreSection(
//            type: .users,
//            cells: [
//                .user(viewModel: ExploreUserViewModel(
//                    username: "jdbco",
//                    profileOucturedURL: nil,
//                    followerCount: 0,
//                    handler: {
//
//                    }
//                )),
//                .user(viewModel: ExploreUserViewModel(
//                    username: "kdscnso",
//                    profileOucturedURL: nil,
//                    followerCount: 0,
//                    handler: {
//
//                    }
//                )),
//                .user(viewModel: ExploreUserViewModel(
//                    username: "alniredw",
//                    profileOucturedURL: nil,
//                    followerCount: 0,
//                    handler: {
//
//                    }
//                ))
//
//            ]
//        )
//        )
//        //trending hashtags
//        sections.append(ExploreSection(
//            type: .trendingHashtags,
//            cells: [
//                .hashtag(viewModel: ExploreHashtagViewModel(text: "grevevrv", icon: UIImage(systemName: "house"), count: 1, handler: {
//
//                })
//                ),
//                .hashtag(viewModel: ExploreHashtagViewModel(text: "feerfve", icon: UIImage(systemName: "house"), count: 1, handler: {
//
//                })
//                ),
//                .hashtag(viewModel: ExploreHashtagViewModel(text: "ve", icon: UIImage(systemName: "house"), count: 1, handler: {
//
//                })
//                ),
//                .hashtag(viewModel: ExploreHashtagViewModel(text: "vrefvw", icon: UIImage(systemName: "house"), count: 1, handler: {
//
//                })
//                )
//            ]
//        )
//        )
//        //recommended
//        sections.append(ExploreSection(
//            type: .recommended,
//            cells: posts
//        )
//        )
//        //popular
//
//        sections.append(ExploreSection(
//            type: .popular,
//            cells: posts
//        )
//        )
//        //new recently
//        sections.append(ExploreSection(
//            type: .new,
//            cells:posts
//        )
//        )
//
//    }
    
    func setUpCollectionView(){
        let layout = UICollectionViewCompositionalLayout  { (section, _) -> NSCollectionLayoutSection? in
            return self.layout(for: section)
        }
        let collectionView = UICollectionView(frame: .zero
                                              , collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(ExploreBannerCollectionViewCell.self, forCellWithReuseIdentifier: ExploreBannerCollectionViewCell.identifier)
        collectionView.register(ExplorePostCollectionViewCell.self, forCellWithReuseIdentifier: ExplorePostCollectionViewCell.identifier )
        collectionView.register(ExploreUserCollectionViewCell.self, forCellWithReuseIdentifier: ExploreUserCollectionViewCell.identifier)
        collectionView.register(ExploreHashtagCollectionViewCell.self, forCellWithReuseIdentifier: ExploreHashtagCollectionViewCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView = collectionView
    }
    
    
    
    // always try to manage things in a single class which you want to reuse again and again
    func configureModel() {
       
        sections.append(
            
            ExploreSection(type: .banners, cells: ExploreManager.shared.getExploreBanner().compactMap({
                
                return ExploreCell.banner(viewModel: $0)
            }))
        )
        
        //trending posts
        
       
        sections.append(
                
            ExploreSection(type: .trendingPosts, cells: ExploreManager.shared.getExplorePosts().compactMap(
                            {
                                ExploreCell.post(viewModel: $0)
                            }))
        )
        
        //users
       
        sections.append(
            
            ExploreSection(type: .users, cells: ExploreManager.shared.getExploreUser().compactMap({
                
                ExploreCell.user(viewModel: $0)
            }))
        
        )
        
        
        //trending Hashtags
        sections.append(
            
            ExploreSection(type: .trendingHashtags, cells: ExploreManager.shared.getExploreHashTag().compactMap({
                
                ExploreCell.hashtag(viewModel: $0)
            }))
        
        )
        
       
        
        //recommended
        sections.append(
                
            ExploreSection(type: .recommended, cells: ExploreManager.shared.getExplorePosts().compactMap(
                            {
                                ExploreCell.post(viewModel: $0)
                            }))
        )
        //popular
        
        sections.append(
            
            ExploreSection(type: .popular, cells: ExploreManager.shared.getExplorePosts().compactMap({
                
                ExploreCell.post(viewModel: $0)
                
            }))
        )
        
        //new
        sections.append(
                
            ExploreSection(type: .new, cells: ExploreManager.shared.getExplorePosts().compactMap(
                            {
                                ExploreCell.post(viewModel: $0)
                            }))
        )
    }
}






extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return  sections.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = sections[indexPath.section].cells[indexPath.row]
        
        switch model {
        case .banner(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExploreBannerCollectionViewCell.identifier, for: indexPath) as? ExploreBannerCollectionViewCell else {
                return collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            }
            cell.configure(with: viewModel)
            return cell
        case .post( let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExplorePostCollectionViewCell.identifier, for: indexPath) as? ExplorePostCollectionViewCell else {
                return collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            }
            // here is the problem you are configuring cells after returning the cell that's why not showning cells
            cell.configure(with: viewModel)
            return cell
            
        case .hashtag( let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExploreHashtagCollectionViewCell.identifier, for: indexPath) as? ExploreHashtagCollectionViewCell else {
                return collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            }
            cell.configure(with: viewModel)
            return cell
        case .user(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExploreUserCollectionViewCell.identifier, for: indexPath) as? ExploreUserCollectionViewCell else {
                return collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            }
            cell.configure(with: viewModel)
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        collectionView.deselectItem(at: indexPath, animated: true)
        HapticsManager.shared.vibrateForSelection()
        let model = sections[indexPath.section].cells[indexPath.row]
        
        switch model {
        case .banner(let viewModel):
            break
        case .post( let viewModel):
            
            break
        case .hashtag( let viewModel):
            break
        case .user(let viewModel):
            break
        }
    }
}





extension ExploreViewController: UISearchBarDelegate{
    
}


//MARK: - Section Layouts
extension ExploreViewController {

    func layout(for section: Int) -> NSCollectionLayoutSection
    {
        let sectionType = sections[section].type

        switch sectionType {

        case .banners:
            //Item
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
            )

            item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)

            //Group
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.9),
                    heightDimension: .absolute(200)
                ),
                subitems: [item]
            )
            //Section Layout
            let sectionLayout = NSCollectionLayoutSection(group: group)
            sectionLayout.orthogonalScrollingBehavior = .continuous
            sectionLayout.orthogonalScrollingBehavior = .groupPaging

            //Return
            return sectionLayout
        case .trendingPosts:
            //Item
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )

            )

            item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)

            //Group
            let veritcalGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(100),
                    heightDimension: .absolute(240)
                ),
                subitem: item,
                count: 2
            )

            let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(110), heightDimension: .absolute(240)), subitems: [veritcalGroup])
            //Section Layout
            let sectionLayout = NSCollectionLayoutSection(group: group)
            sectionLayout.orthogonalScrollingBehavior = .continuous


            //Return
            return sectionLayout
        case .users:
            //Item
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
            )

            item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)

            //Group
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(150),
                    heightDimension: .absolute(200)
                ),
                subitems: [item]
            )
            //Section Layout
            let sectionLayout = NSCollectionLayoutSection(group: group)
            sectionLayout.orthogonalScrollingBehavior = .continuous


            //Return
            return sectionLayout

        case .trendingHashtags:
            //Item
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
            )

            item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)

            //Group
            let verticalGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(60)
                ),
                subitems: [item]
            )


            //Section Layout
            let sectionLayout = NSCollectionLayoutSection(group: verticalGroup)


            //Return
            return sectionLayout

        case .new,  .recommended:
            //Item
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )

            )

            item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)

            //Group
            let veritcalGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(100),
                    heightDimension: .absolute(300)
                ),
                subitem: item,
                count: 2
            )

            let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(110), heightDimension: .absolute(300)), subitems: [veritcalGroup])
            //Section Layout
            let sectionLayout = NSCollectionLayoutSection(group: group)
            sectionLayout.orthogonalScrollingBehavior = .continuous
            return sectionLayout

        case .popular:
            //Item
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )

            )

            item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)

            //Group


            let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(110), heightDimension: .absolute(200)), subitems: [item])
            //Section Layout
            let sectionLayout = NSCollectionLayoutSection(group: group)
            sectionLayout.orthogonalScrollingBehavior = .continuous
            return sectionLayout


        }

    }
}
