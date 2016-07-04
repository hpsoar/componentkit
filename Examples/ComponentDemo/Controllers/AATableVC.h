//
//  AATableVC.h
//  ComponentDemo
//
//  Created by HuangPeng on 7/3/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import "RefreshController.h"
#import <UIKit/UIKit.h>

@interface AATableVC
    : UIViewController <UITableViewDelegate, RefreshControllerDelegate>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) RefreshController *refreshController;

@end

@protocol AATableVCUtil <NSObject>

/**
 *  clear the data in data source, reloadData is not called on tableView
 */
- (void)clearData;

/**
 *  add rows to section 0
 *
 *  @param items
 *
 *  @return @[ NSIndexPath ]
 */
- (NSArray *)addItems:(NSArray *)items
     withRowAnimation:(UITableViewRowAnimation)animation;

/**
 *
 *
 *  @param item
 *  @param animation
 *
 *  @return
 */
- (NSIndexPath *)addItem:(id)item
        withRowAnimation:(UITableViewRowAnimation)animation;

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
           withRowAnimation:(UITableViewRowAnimation)animation;

/**
 *  reload the row associated with item if item is find in section 0
 *
 *  @param item
 *  @param animation animation
 */
- (void)reloadItem:(id)item withRowAnimation:(UITableViewRowAnimation)animation;

- (void)reloadRowAtIndexPath:(NSIndexPath *)indexPath
            withRowAnimation:(UITableViewRowAnimation)animation;

- (void)deleteItem:(id)item withRowAnimation:(UITableViewRowAnimation)animation;

/**
 *  safely delete row at indexPath
 *
 *  @param indexPath
 *  @param animation
 */
- (void)deleteRowAtIndexPath:(NSIndexPath *)indexPath
            withRowAnimation:(UITableViewRowAnimation)animation;

#pragma mark - convenient methods without animation

/**
 *  add a row with item (model) to section 0,
 *  add a section if section 0 doesn't exist
 *
 *  @param item model
 *
 *  @return indexPath of the added item
 */
- (NSIndexPath *)addItem:(id)item;

/**
 *  add rows to section 0
 *
 *  @param items
 *
 *  @return @[ NSIndexPath ]
 */
- (NSArray *)addItems:(NSArray *)items;

/**
 *  safely insert item at a given indexPath
 *  will try to add a section if possible
 *
 *  @param item
 *  @param indexPath
 *
 *  @return indexPath if succeed, otherwise return nil
 */
- (NSIndexPath *)insertItem:(id)item atIndexPath:(NSIndexPath *)indexPath;

/**
 *  reload the row associated with item if item is find in section 0
 */
- (void)reloadItem:(id)item;

/**
 *  safely reload row at indexPath
 *
 *  @param indexPath
 */
- (void)reloadRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  delete the row associated with item if item is find in section 0
 *
 *  @param item model
 */
- (void)deleteItem:(id)item;

/**
 *  safely delete row at indexPath
 *
 *  @param indexPath
 */
- (void)deleteRowAtIndexPath:(NSIndexPath *)indexPath;

@end
