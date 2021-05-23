//
//  ThumbnailNode.swift
//  KakaYoga
//
//  Created by nyon on 2021/05/23.
//

import Foundation
import TextureSwiftSupport

final class ThumbnailNode: ASDisplayNode {
    private let profileInfo: ProfileInfo
    
    init(profileInfo: ProfileInfo) {
        self.profileInfo = profileInfo
        super.init()
        self.backgroundColor = .purple
        self.automaticallyManagesSubnodes = true
    }
    
    private lazy var imageNode = { () -> ASNetworkImageNode in
        let node = ASNetworkImageNode()
        node.url = self.profileInfo.thumbnailUrl
        node.clipsToBounds = true
        node.contentMode = .scaleAspectFill
        node.cornerRadius = 8.0
        return node
    }()

    private lazy var nameNode = { () -> ASTextNode in
        let node = ASTextNode()
        node.maximumNumberOfLines = 0
        node.placeholderColor = Self.placeHolderColor
        node.attributedText = NSAttributedString(string: self.profileInfo.name, attributes: Self.nameAttributes)
        return node
    }()
}

extension ThumbnailNode {
    // layout spec
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        // HStackLayout
        return LayoutSpec {
            HStackLayout(spacing: 10, alignItems: .start) {
                self.imageNode.height(50).width(50)
                self.nameNode
            }
        }
    }
}

extension ThumbnailNode {
    static let placeHolderColor: UIColor = UIColor.gray.withAlphaComponent(0.2)
    static var nameAttributes: [NSAttributedString.Key: Any] {
        return [NSAttributedString.Key.foregroundColor: UIColor.black,
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
    }
}
