//
//  ViewController.m
//  AsynTagView
//
//  Created by 王剑石 on 2018/3/5.
//  Copyright © 2018年 wangjianshi. All rights reserved.
//

#import "ViewController.h"
#import "XWTagView.h"

@interface ViewController ()

@property (nonatomic, strong) XWTagView *tagView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];

    // Do any additional setup after loading the view, typically from a nib.
}

-(void)setUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tagView];
    
    NSArray<NSString *> *tags = @[
                                   @"标签tag1标签tag1标签tag1标签tag1",@"表面",@"哈哈哈",@"测试测试",@"不不",@"无敌啊",@"标签",@"这样喊得好吗",
                                   @"哈哈哈",@"嘻嘻嘻",@"呵呵呵",@"标签",@"表面兄弟",@"你好啊",@"不想你了哦",@"不要这样子啦"
                                   ];
    
    NSMutableAttributedString *attr = [NSMutableAttributedString xw_makeTagView: tags tagMaker:^(XWTagMaker *make){
        
        make.strokeColor = [UIColor redColor];
        make.fillColor = [UIColor clearColor];
        make.strokeWidth = 1;
        make.cornerRadius = 300;
        make.insets =  UIEdgeInsetsMake(-4, -10, -4, -10);
        make.font = [UIFont systemFontOfSize:16];
        make.textColor = [UIColor blackColor];
        make.lineSpace = 16;
        make.space = 20;
        make.maxWidth = [UIScreen mainScreen].bounds.size.width - 20;
        make.tagAlignment = XWTagAlignmentCenter;
    }];
    
    self.tagView.tagAttr = attr;
}

-(XWTagView *)tagView{
    
    if (_tagView == nil) {
        
        _tagView = [[XWTagView alloc] initWithFrame:CGRectMake(10, 100, [UIScreen mainScreen].bounds.size.width - 20, 100)];
    }
    return _tagView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
