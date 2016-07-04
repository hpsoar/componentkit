//
//  AAModelViewUpdater.h
//  ComponentDemo
//
//  Created by HuangPeng on 7/4/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AAModelViewUpdater <NSObject>

- (NSArray *)insertObjects:(NSArray *)objects atIndexPaths:(NSArray *)indexPaths;
- (NSArray *)deleteRowsAtIndexPaths:(NSArray *)indexPaths;
- (NSIndexSet *)insertSectionsAtIndexSet:(NSIndexSet *)indexSet;
- (NSIndexSet *)deleteSectionsAtIndexSet:(NSIndexSet *)indexSet;

@end

@protocol AAModelUpdater <NSObject>

- (NSArray *)addObject:(id)object;
- (NSArray *)addObject:(id)object toSection:(NSUInteger)section;
- (NSArray *)addObjectsFromArray:(NSArray *)array;
- (NSArray *)insertObject:(id)object atRow:(NSUInteger)row inSection:(NSUInteger)section;
- (NSArray *)removeObjectAtIndexPath:(NSIndexPath *)indexPath;

- (NSIndexSet *)addSectionWithTitle:(NSString *)title;
- (NSIndexSet *)insertSectionWithTitle:(NSString *)title atIndex:(NSUInteger)index;
- (NSIndexSet *)removeSectionAtIndex:(NSUInteger)index;

@end

