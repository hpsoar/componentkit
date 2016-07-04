//
//  NITableVC.m
//  ComponentDemo
//
//  Created by HuangPeng on 7/4/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import "NITableVC.h"

@implementation NITableVC

- (NITableViewModel *)tableViewModel {
    if (_tableViewModel == nil) {
        _tableViewModel = [[NIMutableTableViewModel alloc] initWithDelegate:self.cellFactory];
        self.tableView.dataSource = _tableViewModel;
    }
    return _tableViewModel;
}

- (NIMutableTableViewModel *)mutableTableViewModel {
    if ([self.tableViewModel isKindOfClass:[NIMutableTableViewModel class]]) {
        return (NIMutableTableViewModel *)self.tableViewModel;
    }
    return nil;
}

- (NICellFactory *)cellFactory {
    if (_cellFactory == nil) {
        _cellFactory = [NICellFactory new];
    }
    return _cellFactory;
}

- (NITableViewActions *)tableViewActions {
    if (_tableViewActions == nil) {
        _tableViewActions = [[NITableViewActions alloc] initWithTarget:self];
        [_tableViewActions forwardingTo:self];
        self.tableView.delegate = _tableViewActions;
    }
    return _tableViewActions;
}

@end

#pragma mark - NIModelTableVC

@implementation NIModelTableVC

- (ModelRefresher *)modelRefresher {
    if (_modelRefresher == nil) {
        _modelRefresher = [[ModelRefresher alloc] initWithRefreshController:self.refreshController];
        _modelRefresher.delegate = self;
    }
    return _modelRefresher;
}

@end

#pragma mark - util

@implementation NITableVC (Util)

- (BOOL)isTableNoneEmpty {
    return self.tableView.indexPathsForVisibleRows.count > 0;
}


/**
 *  clear the data in data source, reloadData is not called on tableView
 */
- (void)clearData {
    
}

/**
 *  add rows to section 0
 *
 *  @param items
 *
 *  @return @[ NSIndexPath ]
 */
- (NSArray *)addItems:(NSArray *)items
     withRowAnimation:(UITableViewRowAnimation)animation {
    NSArray *indexPathes = [self.mutableTableViewModel addObjectsFromArray:items];
    if (![self isTableNoneEmpty]) {
        [self.tableView reloadData];
    }
    else {
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:indexPathes withRowAnimation:animation];
        [self.tableView endUpdates];
    }
    return indexPathes;
}

/**
 *
 *
 *  @param item
 *  @param animation
 *
 *  @return
 */
- (NSIndexPath *)addItem:(id)item
        withRowAnimation:(UITableViewRowAnimation)animation {
    if (item) {
        return [self addItems:@[item] withRowAnimation:animation].firstObject;
    }
    return nil;
}

/**
 *
 *
 *  @param item
 *  @param indexPath
 *  @param animation
 *
 *  @return
 */
- (NSIndexPath *)insertItem:(id)item
                atIndexPath:(NSIndexPath *)indexPath
           withRowAnimation:(UITableViewRowAnimation)animation {
    if (item) {
        NSArray *indexPathes = [self.mutableTableViewModel insertObject:item atRow:indexPath.row inSection:indexPath.section];
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:indexPathes withRowAnimation:animation];
        [self.tableView endUpdates];
        return indexPathes.firstObject;
    }
    return nil;
}

- (void)reloadRowAtIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation {
    if (indexPath && [self isTableNoneEmpty]) {
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:animation];
    }
}

/**
 *  reload the row associated with item if item
 *
 *  @param item
 *  @param animation animation
 */
- (void)reloadItem:(id)item withRowAnimation:(UITableViewRowAnimation)animation {
    NSIndexPath *indexPath = [self.tableViewModel indexPathForObject:item];
    [self reloadRowAtIndexPath:indexPath withRowAnimation:animation];
}

/**
 *  safely delete row at indexPath
 *
 *  @param indexPath
 *  @param animation
 */
- (void)deleteRowAtIndexPath:(NSIndexPath *)indexPath
            withRowAnimation:(UITableViewRowAnimation)animation {
    if (indexPath && [self isTableNoneEmpty]) {
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:animation];
        [self.tableView endUpdates];
    }
}

- (void)deleteItem:(id)item withRowAnimation:(UITableViewRowAnimation)animation {
    NSIndexPath *indexPath = [self.tableViewModel indexPathForObject:item];
    [self deleteRowAtIndexPath:indexPath withRowAnimation:animation];
}

#pragma mark - convenient methods

- (NSArray *)addItems:(NSArray *)items {
    return [self addItems:items withRowAnimation:UITableViewRowAnimationNone];
}

/**
 *  add a row with item (model) to section 0,
 *  add a section if section 0 doesn't exist
 *
 *  @param item model
 *
 *  @return indexPath of the added item
 */
- (NSIndexPath *)addItem:(id)item {
    return [self addItem:item withRowAnimation:UITableViewRowAnimationNone];
}

/**
 *  safely insert item at a given indexPath
 *  will try to add a section if possible
 *
 *  @param item
 *  @param indexPath
 *
 *  @return indexPath if succeed, otherwise return nil
 */
- (NSIndexPath *)insertItem:(id)item atIndexPath:(NSIndexPath *)indexPath {
    return [self insertItem:item atIndexPath:indexPath withRowAnimation:UITableViewRowAnimationNone];
}

/**
 *  reload the row associated with item if item is find in section 0
 */
- (void)reloadItem:(id)item {
    [self reloadItem:item withRowAnimation:UITableViewRowAnimationNone];
}


/**
 *  safely reload row at indexPath
 *
 *  @param indexPath
 */
- (void)reloadRowAtIndexPath:(NSIndexPath *)indexPath {
    [self reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationNone];
}

/**
 *  delete the row associated with item if item is find in section 0
 *
 *  @param item model
 */
- (void)deleteItem:(id)item {
    [self deleteItem:item withRowAnimation:UITableViewRowAnimationNone];
}

/**
 *  safely delete row at indexPath
 *
 *  @param indexPath
 */
- (void)deleteRowAtIndexPath:(NSIndexPath *)indexPath {
    [self deleteRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationNone];
}

@end

