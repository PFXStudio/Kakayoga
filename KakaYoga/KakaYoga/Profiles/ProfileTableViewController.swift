//
//  ProfileTableViewController.swift
//  KakaYoga
//
//  Created by nyon on 2021/05/19.
//

import Foundation
import RxSwift
import TextureSwiftSupport

final class ProfileTableViewController: ASDKViewController<ASTableNode> {
    private var items = [ProfileInfo]()
    private let disposeBag = DisposeBag()
    
    private func generateProfiles() -> [ProfileInfo] {
        var results = [ProfileInfo]()
        guard let nameFile = Bundle.main.url(forResource: "names", withExtension: "json"),
              let nameData = try? Data(contentsOf: nameFile),
              let nameJson = try? JSONSerialization.jsonObject(with: nameData, options: []),
              let names = nameJson as? [String],
              let imageFile = Bundle.main.url(forResource: "images", withExtension: "json"),
              let imageData = try? Data(contentsOf: imageFile),
              let imageJson = try? JSONSerialization.jsonObject(with: imageData, options: []),
              let images = imageJson as? [String] else { return results }

        for _ in 0..<1000 {
            results.append(ProfileInfo(name: names[Int(arc4random_uniform(UInt32(names.count)))],
                                       thumbnailUrl: URL(string: images[Int(arc4random_uniform(UInt32(images.count)))])!,
                                       posts: String(arc4random_uniform(10000)), followers: String(arc4random_uniform(10000)), follow: String(arc4random_uniform(10000))))
        }

        return results
    }
    
    override init() {
        let tableNode =  ASTableNode(style: .plain)
        tableNode.backgroundColor = .white
        tableNode.automaticallyManagesSubnodes = true
        super.init(node: tableNode)
        items = self.generateProfiles()
        
        self.title = "Profile"
        
        // main thread
        self.node.onDidLoad { node in
            guard let `node` = node as? ASTableNode else { return }
            node.view.separatorStyle = .singleLine
        }
        
        self.node.dataSource = self
        self.node.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileTableViewController: ASTableDataSource {
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    /*
     Node Block Thread Safety Warning
     It is very important that node blocks be thread-safe.
     One aspect of that is ensuring that the data model is accessed outside of the node block.
     Therefore, it is unlikely that you should need to use the index inside of the block.
     */
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        return {
            guard self.items.count > indexPath.row else { return ASCellNode() }
            let profileInfo = self.items[indexPath.row]
            let cellNode = ProfileCellNode(profileInfo: profileInfo)
            
            return cellNode
        }
    }
}

extension ProfileTableViewController: ASTableDelegate {
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        guard self.items.count > indexPath.row else { return }
        let profileInfo = self.items[indexPath.row]
        let destination = ProfileViewController(profileInfo: profileInfo)
        self.navigationController?.pushViewController(destination, animated: true)
        
    }
}
