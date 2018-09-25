//
//  WDPrintViewController.m
//  iOS-Objc-Demo
//
//  Created by 吴丹 on 2018/9/21.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "WDPrintViewController.h"

@interface WDPrintViewController ()

@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, copy) NSString *text;

@end

@implementation WDPrintViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(animationLabel) object:nil];
    [thread start];
    
    self.text = @"愿你三冬暖\n愿你夏不炎\n愿你大雪有暖气\n愿你烈日有空调\n愿你天黑时有灯，下雨时有伞\n愿你路上能有良人相伴\n愿你此生不孤单\n愿你快乐无需假装，委屈不必隐藏\n愿时光能缓\n愿故人不散\n愿你惦念的人能和你互道晚安\n愿你虽颠沛流离终得一世安稳\n愿你对生活一如既往的深情\n愿你可以活得潇洒和放肆\n愿健康幸福常伴你左右\n愿你百岁，不，愿你一世无忧\n愿你有自己的骄傲，明白自己的了不起\n愿你的优秀无需向任何人证明\n愿你可以拥有自己的小梦想，坚持住永远不后悔愿所有的磨难都绕开你\n愿所有的幸运能追着你\n愿你想要的都可以拥有\n愿你得不到的全能释怀\n愿我对你的祝福一切成真\n愿你快乐时有人分享，伤心无处安放时会想起我\n愿你走出半生，归来仍是当初那个意气风发的少女\n我不确定未来自己会走多远，却还是想自信的告诉你，难过的时候请回头看看，那个不太聪明的我其实一直都在";
    self.textLabel = [[UILabel alloc] init];
    self.textLabel.numberOfLines = 0;
    self.textLabel.adjustsFontSizeToFitWidth = YES;
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.textLabel];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (void)animationLabel {
    for (NSInteger i = 0; i < self.text.length; i++) {
        [self performSelectorOnMainThread:@selector(refreshUIWithContentStr:) withObject:[self.text substringWithRange:NSMakeRange(0, i+1)] waitUntilDone:YES];
        [NSThread sleepForTimeInterval:0.3];
    }
}

- (void)setupNavigationBar {
    
}

- (void)refreshUIWithContentStr:(NSString *)contentStr {
    self.textLabel.text = contentStr;
}

@end
