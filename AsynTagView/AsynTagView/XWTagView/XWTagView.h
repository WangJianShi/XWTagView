//
//  XWTagView.h
//  XWTagView
//
//  Created by 王剑石 on 2017/10/27.
//  Copyright © 2017年 wangjianshi. All rights reserved.
//

#import "YYText.h"
#import "NSMutableAttributedString+XWTagView.h"
@class XWTagView;

@protocol XWTagViewDelegate <NSObject>

-(void)tagView:(XWTagView *)view didSelectTagAtIndex:(NSInteger)index;

@end

@interface XWTagView : YYLabel

@property (nonatomic, weak) id<XWTagViewDelegate> delegate;

/**
 *NSMutableAttributedString
 */
@property (nonatomic,strong) NSMutableAttributedString * tagAttr;


@end
