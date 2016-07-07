//
//  DoctorLIstCatalog.swift
//  ComponentDemo
//
//  Created by HuangPeng on 7/6/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

import UIKit

class DoctorListLayout {
    var nameNode = AALabelNode()
    var titleNode = AALabelNode()
    var clinicNode = AALabelNode()
    var hospitalNode = AALabelNode()
    var goodAtNode = AALabelNode()
    var figureNode = AAStaticNode(size: CGSizeMake(45, 45))
    var rootNode: AAStackNode
    
    convenience init() {
        self.init(doctor: nil)
    }
    
    init(doctor: DoctorModel?) {
        nameNode.config(16, hexColor: 0xff0000, text: doctor?.name)
        
        titleNode.config(16, hexColor: 0x666666, text: doctor?.title)
        
        clinicNode.config(12, hexColor: 0x439322, text: doctor?.clinic)
        
        hospitalNode.config(12, hexColor: 0x666666, text: doctor?.hospital)
        
        goodAtNode.config(12, hexColor: 0x666666, text: doctor?.goodAt)
            .maximumNumberOfLines(2)
        
        let firstRow = AAHorizontalStackNode()
            .alignItems(.End)
            .spacing(5)
            .children([
                AAStackNodeChild().node(nameNode),
                AAStackNodeChild().node(titleNode),
                ])
        
        let secondRow = AAHorizontalStackNode()
            .alignItems(.End)
            .spacing(5)
            .children([
                AAStackNodeChild().node(clinicNode),
                AAStackNodeChild().node(hospitalNode)
                ])
        
        let figureAreaNode = AAInsetNode(insets: UIEdgeInsetsMake(10, 10, 0, 20)).child(figureNode)
        
        rootNode = AAVerticalStackNode()
            .spacing(5)
            .alignItems(.Start)
            .children([
            AAStackNodeChild()
                .node(AAInsetNode(insets: UIEdgeInsetsMake(10, 10, 10, 10))
                    .child(
                        AAHorizontalStackNode()
                            .children([
                                AAStackNodeChild().node(figureAreaNode),
                                AAStackNodeChild()
                                    .node(AAVerticalStackNode()
                                        .spacing(5)
                                        .alignItems(.Start)
                                        .children([
                                            AAStackNodeChild().node(firstRow),
                                            AAStackNodeChild().node(secondRow),
                                            AAStackNodeChild().node(goodAtNode),
                                        ]))
                                ])
                    )
                    )
            ])
    }
    
    func layoutIfNeeded(constrainedSize: AASizeRange) {
        rootNode.layoutIfNeeded(constrainedSize)
    }
}

class DoctorListItem: AATableObject {
    let doctor : DoctorModel!
    
    class func itemsWithDoctors(doctors: NSArray) -> NSArray {
        return doctors.aa_map({ (obj, idx) -> AnyObject? in
            return DoctorListItem(doctor: obj as! DoctorModel)
        })
    }
    
    init(doctor: DoctorModel!) {
        self.doctor = doctor
        super.init()
    }
    
    override func cellClass() -> AnyClass! {
        return DoctorListItemCell.self
    }
    
    
/// MARK - layout
    var layout: DoctorListLayout!

    override func layoutForItem(item: AnyObject!, indexPath: NSIndexPath!, tableView: UITableView!) {
        //let doctorListItem = item as! DoctorListItem
        let doctor = (item as! DoctorListItem).doctor
        layout = DoctorListLayout(doctor: doctor)
        
        let contrainedSize = AASizeRange(max: CGSizeMake(tableView.width, CGFloat.max))
        layout.layoutIfNeeded(contrainedSize)
        cellHeight = layout.rootNode.size.height
    }
}

class DoctorListItemCell : AATableCell {
    let nameLabel = NIAttributedLabel()
    let titleLabel = NIAttributedLabel()
    let clinicLabel = NIAttributedLabel()
    let hospitalLabel = NIAttributedLabel()
    let goodAtLabel = NIAttributedLabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.aa_addSubviews([
            nameLabel,
            titleLabel,
            clinicLabel,
            hospitalLabel,
            goodAtLabel,
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func shouldUpdateCellWithObject(object: AnyObject!) -> Bool {
        super.shouldUpdateCellWithObject(object)
        
        let item = object as! DoctorListItem
        
        item.layout.nameNode.setup(nameLabel)
        item.layout.titleNode.setup(titleLabel)
        item.layout.clinicNode.setup(clinicLabel)
        item.layout.hospitalNode.setup(hospitalLabel)
        item.layout.goodAtNode.setup(goodAtLabel)
        
        return true
    }
}
