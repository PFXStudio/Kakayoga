//
//  ProfileCellNode.swift
//  KakaYoga
//
//  Created by nyon on 2021/05/19.
//

import Foundation
import TextureSwiftSupport
import RxSwift

final class ProfileCellNode: ASCellNode {
    private let disposeBag = DisposeBag()
    private let profileInfo: ProfileInfo
    
    init(profileInfo: ProfileInfo) {
        self.profileInfo = profileInfo
        super.init()
        self.automaticallyManagesSubnodes = true
    }
    
    override func layout() {
        super.layout()
        self.selectionStyle = .none
        self.backgroundColor = .white
    }
    
    private lazy var thumbnailNode = { () -> ThumbnailNode in
        ThumbnailNode(profileInfo: self.profileInfo)
    }()
    
    private lazy var profileNode = { () -> ProfileNode in
        ProfileNode(profileInfo: self.profileInfo)
    }()

    private lazy var infoNode = { () -> ASTextNode in
        let node = ASTextNode()
        node.maximumNumberOfLines = 1
        node.placeholderColor = Self.placeHolderColor
        node.attributedText = NSAttributedString(string: self.profileInfo.posts + "K", attributes: Self.infoAttributes)
        return node
    }()

    lazy private var postNode = { () -> PostNode in
        PostNode(profileInfo: self.profileInfo)
    }()

    override func didEnterVisibleState() {
        super.didEnterVisibleState()
    }
}

extension ProfileCellNode {
    // layout spec
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        // HStackLayout
//        return LayoutSpec {
//            VStackLayout {
//                HStackLayout(spacing: 10) {
//                    self.thumbnailNode.flexGrow(1)
//                }
//                HStackLayout(spacing: 10, justifyContent: .end) {
//                    self.infoNode
//                }
//            }.padding(10)
//        }

        // TODO : profileNode, postNode
        return LayoutSpec {
            VStackLayout(spacing: 10, justifyContent: .center, alignItems: .center) {
                HStackLayout(spacing: 10, justifyContent: .center) {
                    self.profileNode
                }
                HStackLayout(spacing: 10, justifyContent: .center) {
                    self.postNode
                }
            }.padding(10)
        }

    }
}

extension ProfileCellNode {
    static let placeHolderColor: UIColor = UIColor.gray.withAlphaComponent(0.2)
    static var nameAttributes: [NSAttributedString.Key: Any] {
        return [NSAttributedString.Key.foregroundColor: UIColor.black,
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
    }

    static var infoAttributes: [NSAttributedString.Key: Any] {
        return [NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12.0)]
    }
}
