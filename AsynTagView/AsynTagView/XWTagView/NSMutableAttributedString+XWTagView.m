//
//  NSMutableAttributedString+XWTagView.m
//  XWTagView
//
//  Created by 王剑石 on 2017/10/27.
//  Copyright © 2017年 wangjianshi. All rights reserved.
//

#import "NSMutableAttributedString+XWTagView.h"
#import "YYText.h"
#import "XWTagView.h"


static NSString const *XWTagRangeKey = @"XWTagRangeKey";

@interface XWRangObject : NSObject

@property (nonatomic, assign) NSRange range;

@property (nonatomic, assign) NSInteger index;

@end


@implementation XWRangObject

-(BOOL)isEqualRange:(NSRange)range{

    return NSEqualRanges(range, self.range);
   
}

@end

@implementation XWTagWeakObject

@end

@implementation NSMutableAttributedString (XWTagView)

+(NSMutableAttributedString *)xw_makeTagView:(NSArray<NSString *> *)tags  tagMaker:(void (^)(XWTagMaker *))maskBlock{
    
    NSMutableAttributedString *text = [NSMutableAttributedString new];
    NSInteger height = 0;
    XWTagMaker *maker = [[XWTagMaker alloc] init];
    if (maskBlock) {
        maskBlock(maker);
    }
    
    for (int i = 0; i < tags.count; i++) {
        NSString *tag = tags[i];
        NSMutableAttributedString *tagText = [[NSMutableAttributedString alloc] init];
        //标签左内边距
        [tagText appendAttributedString:[self creatEmptyAttributeString:fabs(maker.insets.left)]];
        //标签内容
        [tagText yy_appendString:tag];
        //标签右内边距
        [tagText appendAttributedString:[self creatEmptyAttributeString:fabs(maker.insets.right)]];
        //标签字体颜色设置
        tagText.yy_font = maker.font;
        tagText.yy_color = maker.textColor;
        [tagText yy_setTextBinding:[YYTextBinding bindingWithDeleteConfirm:NO] range:tagText.yy_rangeOfAll];
        //设置item外观样式
        [tagText yy_setTextBackgroundBorder:[self creatTextBoard:maker] range:tagText.yy_rangeOfAll];
        //左右间距
        if (maker.tagAlignment == XWTagAlignmentRight)
        {
           [text appendAttributedString:[self creatEmptyAttributeString:maker.space]];
        }
        
        [text appendAttributedString:tagText];
        
        if (maker.tagAlignment != XWTagAlignmentRight)
        {
            [text appendAttributedString:[self creatEmptyAttributeString:maker.space]];
        }
        //行间距等设置
        text.yy_lineSpacing = maker.lineSpace + fabs(maker.insets.bottom) + fabs(maker.insets.top);
        text.yy_lineBreakMode = NSLineBreakByWordWrapping;
        text.yy_firstLineHeadIndent = 1.5;
        text.yy_headIndent = 1.5 ;//设置与首部的距离
        text.yy_tailIndent = maker.tagAlignment == NSTextAlignmentRight ? maker.maxWidth - fabs(maker.insets.right) : maker.maxWidth - 1.5; //设置与尾部的距离
        //高度计算（超最大范围加换行符手动换行）
        YYTextContainer  *tagContarer = [YYTextContainer new];
        tagContarer.size = CGSizeMake(maker.maxWidth - 3,CGFLOAT_MAX);
        YYTextLayout *tagLayout = [YYTextLayout layoutWithContainer:tagContarer text:text];
        if (tagLayout.textBoundingSize.height > height) {
            if (height != 0) {
                [text yy_insertString:@"\n" atIndex:text.length - tagText.length - (maker.tagAlignment == XWTagAlignmentRight ? 1 : 1)];
                //左右间距
            }
            tagLayout = [YYTextLayout layoutWithContainer:tagContarer text:text];
            height = tagLayout.textBoundingSize.height;
        }
        __weak typeof(text) weakText = text;
        NSRange range = [text.string rangeOfString:tagText.string options:NSBackwardsSearch ];
        XWRangObject *rangeObj = [[XWRangObject alloc] init];
        rangeObj.range = range;
        rangeObj.index = i;
        [[text rangOfTags] addObject:rangeObj];
        [text yy_setTextHighlightRange:range color:nil backgroundColor:nil tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            XWTagWeakObject *obj = [weakText delegate];
            if (obj != nil && [obj.delegate respondsToSelector:@selector(tagView:didSelectTagAtIndex:)]) {
                NSInteger index = 0;
                NSMutableArray<XWRangObject *> *ranges = [weakText rangOfTags];
                for (int j = 0; j < ranges.count; j++) {
                    if ([ranges[j] isEqualRange:range]) {
                        index = ranges[j].index;
                        break;
                    }
                }
                [obj.delegate tagView:obj.tagView didSelectTagAtIndex:index];
            }
        }];
    }
    
    //高度记录（富文本已扩展高度属性）
    text.tagHeight = height + maker.lineSpace + fabs(maker.insets.bottom) + fabs(maker.insets.top);
    //对齐方向设置（头尾自动缩进1.5）
    [text addAttribute:NSParagraphStyleAttributeName value:[self creatTextStyle:maker]
                 range:NSMakeRange(0, text.length)];
    
    
    return text;
}


/**
 外观样式
 
 @param maker tag外观配置
 @return 返回YYTextBorder
 */
+(YYTextBorder *)creatTextBoard:(XWTagMaker *)maker{
    
    YYTextBorder *border = [YYTextBorder new];
    border.strokeWidth = maker.strokeWidth;
    border.strokeColor = maker.strokeColor;
    border.fillColor = maker.fillColor;
    border.cornerRadius = maker.cornerRadius; // a huge value
    border.lineJoin = maker.lineJoin;
    border.insets = UIEdgeInsetsMake(maker.insets.top, 0, maker.insets.bottom, 0);
    
    return border;
}

+(NSMutableAttributedString *)creatEmptyAttributeString:(CGFloat)width{
    
    NSMutableAttributedString *spaceText = [NSMutableAttributedString yy_attachmentStringWithContent:[[UIImage alloc]init] contentMode:UIViewContentModeScaleToFill attachmentSize:CGSizeMake(width, 1) alignToFont:[UIFont systemFontOfSize:0] alignment:YYTextVerticalAlignmentCenter];
    
    return spaceText;
    
}

+(NSMutableParagraphStyle *)creatTextStyle:(XWTagMaker *)maker{
    
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.lineSpacing =  maker.lineSpace + fabs(maker.insets.bottom) + fabs(maker.insets.top);;
    style.firstLineHeadIndent = 1.5;
    style.headIndent = 1.5 ;//设置与首部的距离
    style.tailIndent = maker.tagAlignment == NSTextAlignmentRight ? maker.maxWidth - fabs(maker.insets.right) : maker.maxWidth - 1.5; //设置与尾部的距离
    switch (maker.tagAlignment) {
        case XWTagAlignmentLeft:
            style.alignment = NSTextAlignmentLeft;
            break;
        case XWTagAlignmentCenter:
            style.alignment = NSTextAlignmentCenter;
            break;
        case XWTagAlignmentRight:
            style.alignment = NSTextAlignmentRight;
            break;
        default:
            break;
    }
    
    return style;
    
}

-(CGFloat)tagHeight{
    NSNumber * width = objc_getAssociatedObject(self, @selector(tagHeight));
    return [width floatValue];
}

-(void)setTagHeight:(CGFloat)tagHeight{
    NSNumber * width = [NSNumber numberWithFloat:tagHeight];
    objc_setAssociatedObject(self, @selector(tagHeight), width, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(XWTagWeakObject *)delegate{
    
    return  objc_getAssociatedObject(self, @selector(delegate));
    
}

-(void)setRangOfTags:(XWTagWeakObject *)delegate{
    
    objc_setAssociatedObject(self, @selector(delegate), delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSMutableArray<XWRangObject *> *)rangOfTags{
    
    NSMutableArray<XWRangObject *> *ranges = objc_getAssociatedObject(self, &XWTagRangeKey);
    
    if (ranges == nil) {
        ranges =  [[NSMutableArray<XWRangObject *> alloc]init];
        objc_setAssociatedObject(self, &XWTagRangeKey, ranges, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return  ranges;
    
}

-(void)setDelegate:(XWTagWeakObject *)delegate{
    
    objc_setAssociatedObject(self, @selector(delegate), delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
