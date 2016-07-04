//
//  NIModelPresenter.h
//  ComponentDemo
//
//  Created by HuangPeng on 7/4/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import "ModelTableUpdater.h"
#import <NimbusModels.h>
#import <UIKit/UIKit.h>

/**
 *  the usual way to update a tableview is:
 *  1. update datasource
 *  2. tableView beginUpdates
 *  3. insert & delete & move
 *  4. tableView endUpdates
 *
 *  NIModelTableUpdater will update tableView every time you do model update by:
 *  [NIModelTableUpdater addObject:] etc.
 *  this class utility to bind dataSource update & tableView update
 *
 *  you can manually do the above steps
 *
 *  TODO: add a changeset like ComponentKit to do batch update
 */

@interface NIModelTableUpdater : NSObject <ModelTableUpdater>

+ (instancetype)newWithTableViewModel:(NIMutableTableViewModel *)tableViewModel
                              updater:(id<TableUpdater>)updater;

@property(nonatomic, strong) NIMutableTableViewModel *mutableTableViewModel;
@property(nonatomic, strong) id<TableUpdater> tableUpdater;

@end

@interface TableUpdater : NSObject <TableUpdater>

+ (instancetype)newWithTableView:(UITableView *)tableView;

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic) UITableViewRowAnimation insertAnimation;
@property(nonatomic) UITableViewRowAnimation deleteAnimation;
@property(nonatomic) UITableViewRowAnimation reloadAnimation;

@end

#pragma mark - changeset

@interface AAModelSectionChangeSet : NSObject

@property(nonatomic, strong) NSMutableArray *inserts;
@property(nonatomic, strong) NSMutableArray *removes;
@property(nonatomic, strong) NSMutableArray *moves;

@end

@interface AAModelItemChangeSet : NSObject

@property(nonatomic, strong) NSMutableArray *inserts;
@property(nonatomic, strong) NSMutableArray *removes;
@property(nonatomic, strong) NSMutableArray *moves;
@property(nonatomic, strong) NSMutableArray *updates;

@end

@interface AAModelChangeSet : NSObject

@property(nonatomic, strong) AAModelSectionChangeSet *sections;
@property(nonatomic, strong) AAModelItemChangeSet *items;

@end
