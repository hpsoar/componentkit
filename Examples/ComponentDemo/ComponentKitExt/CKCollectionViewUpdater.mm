//
//  CKCollectionViewUpdater.m
//  ComponentDemo
//
//  Created by HuangPeng on 7/4/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import "CKCollectionViewUpdater.h"

@implementation CKCollectionViewUpdater

+ (instancetype)newWithDataSource:(CKCollectionViewDataSource *)dataSource {
    CKCollectionViewUpdater *updater = [self new];
    updater.dataSource = dataSource;
    return updater;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.updateMode = CKUpdateModeAsynchronous;
    }
    return self;
}

- (void)addSection {
    // Insert the initial section
    
}

- (NSArray *)insertObjects:(NSArray *)objects atIndexPaths:(NSArray *)indexPaths {
    // Convert the array of quotes to a valid changeset
    CKArrayControllerInputItems items;
    for (NSInteger i = 0; i < objects.count; i++) {
        items.insert(indexPaths[i], objects[i]);
    }
    
    [self.dataSource enqueueChangeset:{{}, items}
                      constrainedSize:self.contrainedSize];
    
    return indexPaths;
}

- (NSArray *)deleteRowsAtIndexPaths:(NSArray *)indexPaths {
    __block CKArrayControllerInputItems items;
    
    [indexPaths enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        items.remove(obj);
    }];
    
    [self.dataSource enqueueChangeset:{{}, items}
                      constrainedSize:self.contrainedSize];
    
    return indexPaths;
}

- (NSIndexSet *)insertSectionsAtIndexSet:(NSIndexSet *)indexSet {
    __block CKArrayControllerSections sections;
    [indexSet enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        sections.insert(0);
    }];
    
    [self.dataSource enqueueChangeset:{sections, {}} constrainedSize:{}];
   
    return indexSet;
}

- (NSIndexSet *)deleteSectionsAtIndexSet:(NSIndexSet *)indexSet {
    __block CKArrayControllerSections sections;
    [indexSet enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        sections.remove(0);
    }];
    [self.dataSource enqueueChangeset:{sections, {}} constrainedSize:{}];
    
    return indexSet;
}



@end
