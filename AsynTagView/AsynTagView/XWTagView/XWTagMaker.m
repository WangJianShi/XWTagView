//
//  XWTagMaker.m
//  XWTagView
//
//  Created by serein on 2017/10/27.
//  Copyright © 2017年 wangjianshi. All rights reserved.
//

#import "XWTagMaker.h"

@implementation XWTagMaker

-(instancetype)init{
    
    if (self = [super init]) {
        
        self.strokeColor = [UIColor clearColor];
        self.fillColor = [UIColor clearColor];
        self.strokeWidth = 0;
        self.cornerRadius = 0;
        self.insets = UIEdgeInsetsZero;
        self.lineJoin= kCGLineJoinBevel;
        self.font = [UIFont systemFontOfSize:14];
        self.textColor = [UIColor grayColor];
        self.lineSpace = 10;
        self.space = 10;
        self.maxWidth = [UIScreen mainScreen].bounds.size.width;
        
    }
    return self;
}

@end
