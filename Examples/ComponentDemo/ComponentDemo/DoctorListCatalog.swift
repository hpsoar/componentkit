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
    var rootNode: AAStackNode
    
    init() {
        nameNode.textColor = UIColor.redColor()
        nameNode.fontSize = 16
        
        titleNode.textColor = UIColor.grayColor()
        titleNode.fontSize = 12
        
        clinicNode.fontSize = 12
        clinicNode.hexColor = 0x439322
        
        hospitalNode.fontSize = 12
        hospitalNode.textColor = UIColor.grayColor()
        
        goodAtNode.fontSize = 12
        hospitalNode.textColor = UIColor.grayColor()
        
        rootNode = AAStackNode()
            .direction(.Vertical)
            .spacing(5)
            .alignItems(.Center)
            .children([
            AAStackNodeChild()
                .node(AAInsetNode()
                    .insets(UIEdgeInsetsMake(10, 10, 10, 10))
                    .child(AAStackNode().direction(.Vertical).spacing(5).alignItems(.Center).children([
                        AAStackNodeChild()
                            .node(AAStackNode()
                                .alignItems(.End)
                                .spacing(5)
                                .direction(.Horizontal)
                                .children([
                                    AAStackNodeChild().node(nameNode),
                                    AAStackNodeChild().node(titleNode),
                                ])
                        ),
                        AAStackNodeChild()
                            .node(AAStackNode()
                                .alignItems(.End)
                                .spacing(5)
                                .direction(.Horizontal)
                                .children([
                                    AAStackNodeChild().node(clinicNode),
                                    AAStackNodeChild().node(hospitalNode)
                                    ])
                                ),
                        AAStackNodeChild() .node(goodAtNode)
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
    let layout = DoctorListLayout()

    override func layoutForItem(item: AnyObject!, indexPath: NSIndexPath!, tableView: UITableView!) {
        //let doctorListItem = item as! DoctorListItem
        let doctor = (item as! DoctorListItem).doctor
        layout.nameNode.text = doctor.name
        layout.titleNode.text = doctor.title
        layout.clinicNode.text = doctor.clinic
        layout.hospitalNode.text = doctor.hospital
        layout.goodAtNode.text = doctor.goodAt
        
        let contrainedSize = AASizeRange(max: CGSizeMake(tableView.width, CGFloat.max))
        layout.layoutIfNeeded(contrainedSize)
        cellHeight = layout.rootNode.size.height
    }
}

class DoctorListItemCell : AATableCell {
    let nameLabel = UILabel()
    let titleLabel = UILabel()
    let clinicLabel = UILabel()
    let hospitalLabel = UILabel()
    let goodAtLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.aa_addSubviews([
            nameLabel,
            titleLabel,
            clinicLabel,
            hospitalLabel,
            goodAtLabel,
            ])
        
        nameLabel .aa_styleBlock { (v) in
            v.textColor = UIColor.redColor()
            v.font = UIFont.systemFontOfSize(16)
        }
        
        titleLabel.aa_styleBlock { (v) in
            v.textColor = UIColor.grayColor()
            v.aa_fontSize(12)
        }
        
        clinicLabel.aa_fontSize(12)
            .aa_textHexColor(0x439322)
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
