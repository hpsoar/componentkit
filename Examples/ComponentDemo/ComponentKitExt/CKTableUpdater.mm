//
//  CKModelTableUpdater.m
//  ComponentDemo
//
//  Created by HuangPeng on 7/4/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import "CKTableUpdater.h"

@implementation CKTableUpdater

+ (instancetype)newWithDataSource:
    (CKTableViewTransactionalDataSource *)dataSource {
    CKTableUpdater *updater = [self new];
    updater.dataSource = dataSource;
    return updater;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.updateMode = CKUpdateModeSynchronous;
    }
    return self;
}

- (NSArray *)insertObjects:(NSArray *)objects
              atIndexPaths:(NSArray *)indexPaths {
    
    NSMutableDictionary<NSIndexPath *, id> *dictionary =
        [NSMutableDictionary dictionary];
    
    for (NSUInteger i = 0; i < objects.count; ++i) {
        dictionary[indexPaths[i]] = objects[i];
    }

    CKTransactionalComponentDataSourceChangesetBuilder *builder =
        [CKTransactionalComponentDataSourceChangesetBuilder new];
    
    [builder withInsertedItems:dictionary];
    
    [self.dataSource applyChangeset:builder.build
                               mode:self.updateMode
                           userInfo:self.userInfo];
    return indexPaths;
}

- (NSArray *)deleteRowsAtIndexPaths:(NSArray *)indexPaths {
    
    CKTransactionalComponentDataSourceChangesetBuilder *builder =
        [CKTransactionalComponentDataSourceChangesetBuilder new];
    
    [builder withRemovedItems:[NSSet setWithArray:indexPaths]];
    
    [self.dataSource applyChangeset:builder.build
                               mode:self.updateMode
                           userInfo:self.userInfo];
    return indexPaths;
}

- (NSIndexSet *)insertSectionsAtIndexSet:(NSIndexSet *)indexSet {
    
    CKTransactionalComponentDataSourceChangesetBuilder *builder =
        [CKTransactionalComponentDataSourceChangesetBuilder new];
    
    [builder withInsertedSections:indexSet];
    
    [self.dataSource applyChangeset:builder.build
                               mode:self.updateMode
                           userInfo:self.userInfo];
    return indexSet;
}

- (NSIndexSet *)deleteSectionsAtIndexSet:(NSIndexSet *)indexSet {
    
    CKTransactionalComponentDataSourceChangesetBuilder *builder =
        [CKTransactionalComponentDataSourceChangesetBuilder new];
    
    [builder withRemovedSections:indexSet];
    
    [self.dataSource applyChangeset:builder.build
                               mode:self.updateMode
                           userInfo:self.userInfo];
    return indexSet;
}

@end
