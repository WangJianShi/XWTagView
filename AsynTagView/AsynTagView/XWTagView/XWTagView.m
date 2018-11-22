//
//  XWTagView.m
//  XWTagView
//
//  Created by 王剑石 on 2017/10/27.
//  Copyright © 2017年 wangjianshi. All rights reserved.
//

#import "XWTagView.h"
#import <UIKit/UIKit.h>

@implementation XWTagView

-(instancetype)init{
    
    if (self = [super init]) {
        
        [self initTagView];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self initTagView];
    }
    return self;
}

-(void)initTagView{
    
    self.numberOfLines = 0;
    
    self.lineBreakMode = NSLineBreakByWordWrapping;
    
    self.displaysAsynchronously = YES;
}

-(void)setTagAttr:(NSMutableAttributedString *)tagAttr{
    
    _tagAttr = tagAttr;
    
    [self initTagView];
    
    self.attributedText = _tagAttr;

    
    
}


@end

