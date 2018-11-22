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

    [self setUpAttrDelegate];
}

-(void)setDelegate:(id<XWTagViewDelegate>)delegate{
    
    if (_delegate != delegate) {
        
        _delegate = delegate;
        [self setUpAttrDelegate];
    }
}

-(void)setUpAttrDelegate{
    
    if (_delegate && _tagAttr) {
        
        XWTagWeakObject *obj = [[XWTagWeakObject alloc] init];
        obj.delegate = _delegate;
        obj.tagView = self;
        [_tagAttr setValue:obj forKey:@"delegate"];

    }
}


@end

