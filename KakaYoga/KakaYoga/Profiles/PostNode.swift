//
//  PostNode.swift
//  KakaYoga
//
//  Created by nyon on 2021/05/19.
//

import Foundation
import TextureSwiftSupport

final class PostNode: ASDisplayNode {
    private let profileInfo: ProfileInfo
    
    init(profileInfo: ProfileInfo) {
        self.profileInfo = profileInfo
        super.init()
        self.cornerRadius = 4
        self.backgroundColor = .orange
        self.automaticallyManagesSubnodes = true
    }
    
    lazy private var postTitleNode = { () -> ASTextNode in
        let node = ASTextNode()
        node.attributedText = NSAttributedString(string: "Posts", attributes: Self.titleAttributes)
        return node
    }()

    lazy private var postNode = { () -> ASTextNode in
        let node = ASTextNode()
        node.attributedText = NSAttributedString(string: self.profileInfo.posts, attributes: Self.valueAttributes)
        return node
    }()

    lazy private var followersTitleNode = { () -> ASTextNode in
        let node = ASTextNode()
        node.attributedText = NSAttributedString(string: "Followers", attributes: Self.titleAttributes)
        return node
    }()

    lazy private var followersNode = { () -> ASTextNode in
        let node = ASTextNode()
        node.attributedText = NSAttributedString(string: self.profileInfo.followers, attributes: Self.valueAttributes)
        return node
    }()

    lazy private var followTitleNode = { () -> ASTextNode in
        let node = ASTextNode()
        node.attributedText = NSAttributedString(string: "Follow", attributes: Self.titleAttributes)
        return node
    }()

    lazy private var followNode = { () -> ASTextNode in
        let node = ASTextNode()
        node.attributedText = NSAttributedString(string: self.profileInfo.follow, attributes: Self.valueAttributes)
        return node
    }()

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return LayoutSpec {
            HStackLayout(spacing: 10, justifyContent: .center, alignItems: .center) {
                VStackLayout(spacing: 10, justifyContent: .center, alignItems: .center) {
                    self.postTitleNode
                    self.postNode
                }
                VStackLayout(spacing: 10, justifyContent: .center, alignItems: .center) {
                    self.followersTitleNode
                    self.followersNode
                }
                VStackLayout(spacing: 10, justifyContent: .center, alignItems: .center) {
                    self.followTitleNode
                    self.followNode
                }
            }
            .padding(10)
        }
    }
}

extension PostNode {
    static var titleAttributes: [NSAttributedString.Key: Any] {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        return [NSAttributedString.Key.foregroundColor: UIColor.black,
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15.0),
                NSAttributedString.Key.paragraphStyle: paragraphStyle]
    }
    
    static var valueAttributes: [NSAttributedString.Key: Any] {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        return [NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14.0),
                NSAttributedString.Key.paragraphStyle: paragraphStyle]
    }
}
