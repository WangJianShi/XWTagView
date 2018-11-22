# XWTagView
高性能，高度自定义，历史标签
使用简单（代码如下）
 NSArray<NSString *> *tags = @[
                                   @"标签tag1标签tag1标签tag1标签tag1",@"表面",@"哈哈哈",@"测试测试",@"不不",@"无敌啊",@"标签",
                                   @"这样喊得好吗",@"哈哈哈",@"嘻嘻嘻",@"呵呵呵",@"标签",@"表面兄弟",@"你好啊",@"不想你了哦",
                                   @"不要这样子啦"
                                   ];
    
    NSMutableAttributedString *attr = [NSMutableAttributedString xw_makeTagView: tags tagMaker:^(XWTagMaker *make){
        
        make.strokeColor = [UIColor redColor];
        make.fillColor = [UIColor clearColor];
        make.strokeWidth = 1;
        make.cornerRadius = 300;
        make.insets =  UIEdgeInsetsMake(-4, -10, -4, -10);
        make.font = [UIFont systemFontOfSize:16];
        make.textColor = [UIColor blackColor];
        make.lineSpace = 10;
        make.space = 10;
        make.maxWidth = [UIScreen mainScreen].bounds.size.width - 20;
        make.tagAlignment = XWTagAlignmentLeft;
    }];
    
    self.tagView.tagAttr = attr;
    
    
