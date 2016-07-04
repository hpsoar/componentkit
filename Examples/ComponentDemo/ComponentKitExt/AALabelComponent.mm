//
//  AALabelComponent.m
//  ComponentDemo
//
//  Created by HuangPeng on 7/5/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import "AALabelComponent.h"

@implementation AALabelComponent {
    CGSize _intrinsicSize;
}

- (CKComponentLayout)computeLayoutThatFits:(CKSizeRange)constrainedSize
{
    return {self, constrainedSize.clamp(_intrinsicSize)};
}

@end
