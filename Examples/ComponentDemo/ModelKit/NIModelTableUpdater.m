//
//  NIModelPresenter.m
//  ComponentDemo
//
//  Created by HuangPeng on 7/4/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import "NIModelTableUpdater.h"

@implementation NIModelTableUpdater

+ (instancetype)newWithTableViewModel:(NIMutableTableViewModel *)tableViewModel
                              updater:(id<TableUpdater>)updater {
    NIModelTableUpdater *modelTableUpdater = [self new];
    modelTableUpdater.mutableTableViewModel = tableViewModel;
    modelTableUpdater.tableUpdater = updater;
    return modelTableUpdater;
}

- (NIMutableTableViewModel *)mutableTableViewModel {
    if (_mutableTableViewModel == nil) {
        _mutableTableViewModel =
            [[NIMutableTableViewModel alloc] initWithDelegate:nil];
    }
    return _mutableTableViewModel;
}

- (NSArray *)addObject:(id)object {
    [self ensureSection];

    NSArray *indexPaths = [self.mutableTableViewModel addObject:object];
    return [self.tableUpdater insertObjects:object ? @[ object ] : @[]
                               atIndexPaths:indexPaths];
}

- (NSArray *)addObject:(id)object toSection:(NSUInteger)section {
    [self ensureSection];

    NSArray *indexPaths =
        [self.mutableTableViewModel addObject:object toSection:section];
    return [self.tableUpdater insertObjects:object ? @[ object ] : @[]
                               atIndexPaths:indexPaths];
}

- (NSArray *)addObjectsFromArray:(NSArray *)array {
    [self ensureSection];

    NSArray *indexPaths =
        [self.mutableTableViewModel addObjectsFromArray:array];
    return [self.tableUpdater insertObjects:array atIndexPaths:indexPaths];
}

- (NSArray *)insertObject:(id)object
                    atRow:(NSUInteger)row
                inSection:(NSUInteger)section {
    [self ensureSection];

    NSArray *indexPaths = [self.mutableTableViewModel insertObject:object
                                                             atRow:row
                                                         inSection:section];
    return [self.tableUpdater insertObjects:object ? @[ object ] : @[]
                               atIndexPaths:indexPaths];
}

- (NSArray *)removeObjectAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *indexPaths =
        [self.mutableTableViewModel removeObjectAtIndexPath:indexPath];
    return [self.tableUpdater deleteRowsAtIndexPaths:indexPaths];
}

- (NSIndexSet *)addSectionWithTitle:(NSString *)title {
    return [self.tableUpdater
        insertSectionsAtIndexSet:[self.mutableTableViewModel
                                     addSectionWithTitle:title]];
}

- (NSIndexSet *)insertSectionWithTitle:(NSString *)title
                               atIndex:(NSUInteger)index {
    return [self.tableUpdater
        insertSectionsAtIndexSet:[self.mutableTableViewModel
                                     insertSectionWithTitle:title
                                                    atIndex:index]];
}

- (NSIndexSet *)removeSectionAtIndex:(NSUInteger)index {
    if ([self sectionExist:index]) {
        return [self.tableUpdater
            deleteSectionsAtIndexSet:[self.mutableTableViewModel
                                         removeSectionAtIndex:index]];
    }
    return nil;
}

- (BOOL)sectionExist:(NSUInteger)section {
    return index < [self.mutableTableViewModel numberOfSectionsInTableView:nil];
}

- (void)ensureSection {
    if (![self sectionExist:0]) {
        [self addSectionWithTitle:nil];
    }
}

@end

@implementation TableUpdater

+ (instancetype)newWithTableView:(UITableView *)tableView {
    TableUpdater *updater = [self new];
    updater.tableView = tableView;
    return updater;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.insertAnimation = UITableViewRowAnimationAutomatic;
        self.deleteAnimation = UITableViewRowAnimationAutomatic;
        self.reloadAnimation = UITableViewRowAnimationAutomatic;
    }
    return self;
}

- (NSIndexSet *)deleteSectionsAtIndexSet:(NSIndexSet *)indexSet {
    [self.tableView beginUpdates];
    [self.tableView deleteSections:indexSet
                  withRowAnimation:self.deleteAnimation];
    [self.tableView endUpdates];

    return indexSet;
}

- (NSIndexSet *)insertSectionsAtIndexSet:(NSIndexSet *)indexSet {
    [self.tableView beginUpdates];
    [self.tableView insertSections:indexSet
                  withRowAnimation:self.insertAnimation];
    [self.tableView endUpdates];

    return indexSet;
}

- (NSArray *)deleteRowsAtIndexPaths:(NSArray *)indexPaths {
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:indexPaths
                          withRowAnimation:self.deleteAnimation];
    [self.tableView endUpdates];
    return indexPaths;
}

- (NSArray *)insertObjects:(NSArray *)objects
              atIndexPaths:(NSArray *)indexPaths {
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:indexPaths
                          withRowAnimation:self.insertAnimation];
    [self.tableView endUpdates];
    return indexPaths;
}

@end
