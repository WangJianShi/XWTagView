//
//  NSMutableAttributedString+XWTagView.m
//  XWTagView
//
//  Created by serein on 2017/10/27.
//  Copyright © 2017年 wangjianshi. All rights reserved.
//

#import "NSMutableAttributedString+XWTagView.h"
#import <objc/runtime.h>

@implementation NSMutableAttributedString (XWTagView)

-(CGFloat)tagHeight{
    NSNumber * width = objc_getAssociatedObject(self, @selector(tagHeight));
    return [width floatValue];
}

-(void)setTagHeight:(CGFloat)tagHeight{
    NSNumber * width = [NSNumber numberWithFloat:tagHeight];
    objc_setAssociatedObject(self, @selector(tagHeight), width, OBJC_ASSOCIATION_RETAIN);
}

@end
