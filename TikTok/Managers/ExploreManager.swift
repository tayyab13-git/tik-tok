//
//  ExploreManager.swift
//  TikTok
//

//

import Foundation
import UIKit


protocol ExploreManagerDelegate: AnyObject {
    
    func pushViewController(_ vc: UIViewController)
    func didTapHashTag(_ hashTag: String)
    
}

enum BannerAction: String {
    
    case post
    case user
    case hashtag
}

final class ExploreManager {
    
    //MARK: - properties
    
    static let shared = ExploreManager()
    
    weak var delegate: ExploreManagerDelegate?
    
    //MARK: - public
    public func getExploreBanner() -> [ExploreBannerViewModel] {
        
        guard let data = parseExploreData() else {return []}
        
       return data.banners.compactMap({  model in
            
            ExploreBannerViewModel(image: UIImage(named: model.image), title: model.title, handler: { [weak self] in
                
                guard let action = BannerAction(rawValue: model.action) else {return}
                
                DispatchQueue.main.async {
                    let vc = UIViewController()
                    vc.title = action.rawValue.uppercased()
                    vc.view.backgroundColor = .systemBackground
                    self?.delegate?.pushViewController(vc)
                }
             
                
                switch action {
        
                case .post:
                    break
                case .user:
                    break
                case .hashtag:
                    break
                }
            })
          }
        )
    }
    
    public func getExplorePosts() -> [ExplorePostViewModel] {
        
        guard let data = parseExploreData() else {return []}
        
        return data.trendingPosts.compactMap({  model in
            
            ExplorePostViewModel(thumbnaiImage: UIImage(named: model.image), caption: model.caption) { [weak self] in
                
                let id = model.id
                let vc = PostViewController(model: PostModel(identifier: id))
                self?.delegate?.pushViewController(vc)
            }
        })
    }
    
    public func getExploreHashTag() -> [ExploreHashtagViewModel] {
        
        guard let data = parseExploreData() else {return []}
        
        
        return data.hashtags.compactMap({ model in
            
            ExploreHashtagViewModel(text: "#" + model.tag, icon: UIImage(systemName: model.image), count: model.count) { [weak self] in
                
                DispatchQueue.main.async {
                    
                    self?.delegate?.didTapHashTag(model.tag)
                }
            }
        })
    }
    
    public func getExploreUser() -> [ExploreUserViewModel] {
        
        guard let data =  parseExploreData() else {return []}
        
        return data.creators.compactMap({ model in
            
            ExploreUserViewModel(username: model.username, profileImage: UIImage(named: model.image), followerCount: model.followers_count)
            { [weak self] in
              
                DispatchQueue.main.async {
                    let id  = model.id
                    let vc = ProfileViewController(user: User(username: "joe", profilePicturedURL: nil, identifier: id))
                    self?.delegate?.pushViewController(vc)
                }
            }
        })
        
    }
    
    
    
    
    //MARK: - private
    private func parseExploreData() -> ExploreResponse? {
        
        guard let path = Bundle.main.path(forResource: "explore", ofType: "json") else {return nil}
        
        let url = URL(fileURLWithPath: path)
        
        do {
            let data = try Data(contentsOf: url)
            
            return try JSONDecoder().decode(ExploreResponse.self, from: data)
        }
        catch
        {
            print(error)
            return nil
        }
    }
}







struct ExploreResponse: Codable {
    
    let banners: [Banner]
    let trendingPosts: [Posts]
    let creators: [Creators]
    let recentPosts: [Posts]
    let hashtags: [HashTags]
    let popular: [Posts]
    let recommended: [Posts]
}

struct Banner: Codable {
    
    let id: String
    let image: String
    let title: String
    let action: String
    
}

struct Posts: Codable {
    
    let id: String
    let image: String
    let caption: String
}

struct Creators: Codable {
    
    let id: String
    let image: String
    let username: String
    let followers_count: Int
}

struct HashTags: Codable {
    
    let image: String
    let tag: String
    let count: Int
    
}
