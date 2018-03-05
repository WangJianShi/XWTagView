//
//  XWTagView.h
//  XWTagView
//
//  Created by serein on 2017/10/27.
//  Copyright © 2017年 wangjianshi. All rights reserved.
//

#import "YYText.h"
#import "XWTagMaker.h"
#import "NSMutableAttributedString+XWTagView.h"

@interface XWTagView : YYLabel

/**
 *NSMutableAttributedString
 */
@property (nonatomic,strong) NSMutableAttributedString * tagAttr;

/**
 快速创建tag标签所需样式

 @param tags 字符串数组
 @param maskBlock 初始化标签样式
 @return 标签所需的NSMutableAttributedString
 */
+(NSMutableAttributedString *)xw_makeTagView:(NSArray<NSString *> *)tags tagMaker:(void (^)(XWTagMaker *))maskBlock;

@end
