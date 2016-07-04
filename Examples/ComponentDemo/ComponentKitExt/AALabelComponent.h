//
//  AALabelComponent.h
//  ComponentDemo
//
//  Created by HuangPeng on 7/5/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import <ComponentKit/ComponentKit.h>

@interface AALabelComponent : CKComponent

@property (nonatomic) CKLabelAttributes *style;

@property (nonatomic, weak) UILabel *label;

@end
