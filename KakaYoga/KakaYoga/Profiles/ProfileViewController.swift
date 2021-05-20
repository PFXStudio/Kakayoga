//
//  ProfileViewController.swift
//  KakaYoga
//
//  Created by nyon on 2021/05/19.
//

import Foundation
import TextureSwiftSupport

final class ProfileViewController: ASDKViewController<ASDisplayNode> {
    private let profileInfo: ProfileInfo
    lazy private var imageNode = { () -> ASNetworkImageNode in
        let node = ASNetworkImageNode()
        node.url = profileInfo.thumbnailUrl
        node.cornerRadius = 20.0
        node.clipsToBounds = true
        node.placeholderColor = Self.placeHolderColor
        node.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        node.borderWidth = 0.5
        return node
    }()
    
    lazy private var nameNode = { () -> ASEditableTextNode in
        let node = ASEditableTextNode()
        node.attributedPlaceholderText =
            NSAttributedString(string: "Insert description",
                               attributes: Self.namePlaceholderAttributes)
        node.typingAttributes =
            Self.convertTypingAttribute(Self.nameAttributes)
        node.attributedText = NSAttributedString(string: self.profileInfo.name, attributes: Self.nameAttributes)
        return node
    }()
    
    lazy private var postNode = { () -> PostNode in
        PostNode(profileInfo: self.profileInfo)
    }()

    init(profileInfo: ProfileInfo) {
        self.profileInfo = profileInfo
        super.init(node: ASDisplayNode())
        node.backgroundColor = .white
        node.automaticallyManagesSubnodes = true
        
        node.layoutSpecBlock = { [weak self] (_, _) -> ASLayoutSpec in
            guard let `self` = self else { return ASLayoutSpec() }
            return LayoutSpec {
                VStackLayout(spacing: 10, justifyContent: .center, alignItems: .center) {
                    self.imageNode.height(150).width(150)
                    self.nameNode.width(250)
                    self.postNode
                }.padding(10)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileViewController {
    static let placeHolderColor: UIColor = UIColor.gray.withAlphaComponent(0.2)
    static var nameAttributes: [NSAttributedString.Key: Any] {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        return [NSAttributedString.Key.foregroundColor: UIColor.black,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20.0),
                NSAttributedString.Key.paragraphStyle: paragraphStyle]
    }
    
    static var followAttributes: [NSAttributedString.Key: Any] {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        return [NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15.0),
                NSAttributedString.Key.paragraphStyle: paragraphStyle]
    }
    
    static var namePlaceholderAttributes: [NSAttributedString.Key: Any] {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        return [NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.5),
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20.0),
                NSAttributedString.Key.paragraphStyle: paragraphStyle]
    }
    
    static func convertTypingAttribute(_ attributes: [NSAttributedString.Key: Any]) -> [String: Any] {
        var typingAttribute: [String: Any] = [:]
        
        for key in attributes.keys {
            guard let attr = attributes[key] else { continue }
            typingAttribute[key.rawValue] = attr
        }
        
        return typingAttribute
    }
}
