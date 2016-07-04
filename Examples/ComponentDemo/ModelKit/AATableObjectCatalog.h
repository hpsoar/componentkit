//
//  AATableObjectCatalog.h
//  ComponentDemo
//
//  Created by HuangPeng on 7/4/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <NimbusModels.h>
#import "DoctorModel.h"

@protocol AATableCellLayout <NSObject>

- (void)layoutForItem:(id)item indexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView;

@property (nonatomic) BOOL needsLayout;
@property (nonatomic) CGFloat cellHeight;

@end

@interface AATableObject : NICellObject <AATableCellLayout>

@end

@interface AATableCell : UITableViewCell <NICell>

@end

@interface DoctorInfoTableObject : AATableObject

+ (instancetype)newWithDoctor:(DoctorModel *)doctor;

@property (nonatomic, strong) DoctorModel *doctor;

@end

@interface DoctorInfoTableCell : AATableCell

@end