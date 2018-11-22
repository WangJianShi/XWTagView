//
//  NSMutableAttributedString+XWTagView.h
//  XWTagView
//
//  Created by 王剑石 on 2017/10/27.
//  Copyright © 2017年 wangjianshi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "XWTagMaker.h"
@class XWTagView;
@protocol XWTagViewDelegate;

@interface XWTagWeakObject : NSObject

@property (nullable, nonatomic, weak) id<XWTagViewDelegate> delegate;

@property (nullable, nonatomic, weak) XWTagView *tagView;

@end

@interface NSMutableAttributedString (XWTagView)

//当前标签富文本的高度
@property (nonatomic,assign) CGFloat tagHeight;

/**
 快速创建tag标签所需样式
 
 @param tags 字符串数组
 @param maskBlock 初始化标签样式
 @return 标签所需的NSMutableAttributedString
 */
+(NSMutableAttributedString *)xw_makeTagView:(NSArray<NSString *> *)tags tagMaker:(void (^)(XWTagMaker *))maskBlock;

@end
