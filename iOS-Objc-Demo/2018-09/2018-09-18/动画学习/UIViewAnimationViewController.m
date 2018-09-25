//
//  UIViewAnimationViewController.m
//  iOS-Objc-Demo
//
//  Created by 吴丹 on 2018/9/18.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "UIViewAnimationViewController.h"

@interface UIViewAnimationViewController ()

@property (nonatomic, strong) UIView *testView;

@end

@implementation UIViewAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 测试控件
    self.testView = [[UIView alloc] init];
    self.testView.backgroundColor = UIColor.orangeColor;
    [self.view addSubview:self.testView];
    self.testView.frame = CGRectMake(0, UIApplication.sharedApplication.statusBarFrame.size.height + 44, 100, 100);

    
}

- (void)setupNavigationBar {
    [super setupNavigationBar];
    [self.wdNavigationBar.centerButton setTitle:@"UIView动画" forState:UIControlStateNormal];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self frameAnimation];
}

/*
 * frame
 * bounds
 * center
 * transform
 * alpha
 * backgroundColor
 * contentStretch
 */

- (void)frameAnimation {
#pragma mark =============== block ===============
    [UIView animateWithDuration:1.2 animations:^{
        // 位置变化
//        self.testView.transform = CGAffineTransformTranslate(self.testView.transform, 100, 100);
//        self.testView.transform = CGAffineTransformMakeTranslation(100, 100);

        // 大小缩放
//        self.testView.transform = CGAffineTransformScale(self.testView.transform, 2, 2);
//        self.testView.transform = CGAffineTransformMakeScale(2, 2);
        
        // 旋转
//        self.testView.transform = CGAffineTransformMakeRotation(M_PI);
        
        self.testView.transform = CGAffineTransformMake(10, 10, 10, 10, 100, 100);
    }];
    
    
//    [UIView animateWithDuration:1.2 animations:^{
//
//        // 修改控件属性即可
//        // 1、位置
//        CGRect oldRect = self.testView.frame;
//        oldRect.origin.y += 20;
//        oldRect.origin.x += 20;
//        self.testView.frame = oldRect;
//
//        // 2、修改尺寸
//        oldRect.size.height += 10;
//        oldRect.size.width -= 10;
//        self.testView.frame = oldRect;
//
//        // 3、修改颜色
//        self.testView.backgroundColor = UIColor.redColor;
//
//    } completion:^(BOOL finished) {
//        if (finished) {
//            // 如果动画完成
//            NSLog(@"完成");
//            self.testView.frame = CGRectMake(0, UIApplication.sharedApplication.statusBarFrame.size.height + 44, 100, 100);
//        }
//    }];
    
/**
 UIViewAnimationOptionLayoutSubviews            //进行动画时布局子控件
 UIViewAnimationOptionAllowUserInteraction      //进行动画时允许用户交互
 UIViewAnimationOptionBeginFromCurrentState     //从当前状态开始动画
 UIViewAnimationOptionRepeat                    //无限重复执行动画
 UIViewAnimationOptionAutoreverse               //执行动画回路
 UIViewAnimationOptionOverrideInheritedDuration //忽略嵌套动画的执行时间设置
 UIViewAnimationOptionOverrideInheritedCurve    //忽略嵌套动画的曲线设置
 UIViewAnimationOptionAllowAnimatedContent      //转场：进行动画时重绘视图
 UIViewAnimationOptionShowHideTransitionViews   //转场：移除（添加和移除图层的）动画效果
 UIViewAnimationOptionOverrideInheritedOptions  //不继承父动画设置
 
 UIViewAnimationOptionCurveEaseInOut            //时间曲线，慢进慢出（默认值）
 UIViewAnimationOptionCurveEaseIn               //时间曲线，慢进
 UIViewAnimationOptionCurveEaseOut              //时间曲线，慢出
 UIViewAnimationOptionCurveLinear               //时间曲线，匀速
 
 UIViewAnimationOptionTransitionNone            //转场，不使用动画
 UIViewAnimationOptionTransitionFlipFromLeft    //转场，从左向右旋转翻页
 UIViewAnimationOptionTransitionFlipFromRight   //转场，从右向左旋转翻页
 UIViewAnimationOptionTransitionCurlUp          //转场，下往上卷曲翻页
 UIViewAnimationOptionTransitionCurlDown        //转场，从上往下卷曲翻页
 UIViewAnimationOptionTransitionCrossDissolve   //转场，交叉消失和出现
 UIViewAnimationOptionTransitionFlipFromTop     //转场，从上向下旋转翻页
 UIViewAnimationOptionTransitionFlipFromBottom  //转场，从下向上旋转翻页
 */
    
    
//    [UIView animateWithDuration:1.2 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
//
//        self.testView.backgroundColor = UIColor.redColor;
//
//    } completion:^(BOOL finished) {
//
//    }];
    
    

/**
UIViewAnimationOptionLayoutSubviews           //进行动画时布局子控件
UIViewAnimationOptionAllowUserInteraction     //进行动画时允许用户交互
UIViewAnimationOptionBeginFromCurrentState    //从当前状态开始动画
UIViewAnimationOptionRepeat                   //无限重复执行动画
UIViewAnimationOptionAutoreverse              //执行动画回路
UIViewAnimationOptionOverrideInheritedDuration //忽略嵌套动画的执行时间设置
UIViewAnimationOptionOverrideInheritedOptions //不继承父动画设置

UIViewKeyframeAnimationOptionCalculationModeLinear     //运算模式 :连续
UIViewKeyframeAnimationOptionCalculationModeDiscrete   //运算模式 :离散
UIViewKeyframeAnimationOptionCalculationModePaced      //运算模式 :均匀执行
UIViewKeyframeAnimationOptionCalculationModeCubic      //运算模式 :平滑
UIViewKeyframeAnimationOptionCalculationModeCubicPaced //运算模式 :平滑均匀
*/
  
    
//    [UIView animateKeyframesWithDuration:1.2 delay:0 options:UIViewKeyframeAnimationOptionRepeat animations:^{
//         self.testView.backgroundColor = UIColor.redColor;
//    } completion:^(BOOL finished) {
//
//    }];
 #pragma mark =============== 普通方式 ===============
    // 开始动画语句
//    [UIView beginAnimations:@"" context:nil];
//
//    //动画持续时间
//    [UIView setAnimationDuration:1.2];
//    //动画的代理对象
//    [UIView setAnimationDelegate:self];
//    //设置动画将开始时代理对象执行的SEL
//    [UIView setAnimationWillStartSelector:@selector(startEvent)];
//    [UIView setAnimationDidStopSelector:@selector(stopAnimation)];
//    //设置动画延迟执行的时间
//    [UIView setAnimationDelay:0];
//    //设置动画的重复次数
//    [UIView setAnimationRepeatCount:2];
//    //设置动画的曲线
//    /*
//     UIViewAnimationCurve的枚举值：
//     UIViewAnimationCurveEaseInOut,         // 慢进慢出（默认值）
//     UIViewAnimationCurveEaseIn,            // 慢进
//     UIViewAnimationCurveEaseOut,           // 慢出
//     UIViewAnimationCurveLinear             // 匀速
//     */
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
//    //设置是否从当前状态开始播放动画
//    /*假设上一个动画正在播放，且尚未播放完毕，我们将要进行一个新的动画：
//     当为YES时：动画将从上一个动画所在的状态开始播放
//     当为NO时：动画将从上一个动画所指定的最终状态开始播放（此时上一个动画马上结束）*/
//    [UIView setAnimationBeginsFromCurrentState:YES];
//    //设置动画是否继续执行相反的动画
//    [UIView setAnimationRepeatAutoreverses:YES];
//    //是否禁用动画效果（对象属性依然会被改变，只是没有动画效果）
//    [UIView setAnimationsEnabled:NO];
//
//    //设置视图的过渡效果
//    /* 第一个参数：UIViewAnimationTransition的枚举值如下
//     UIViewAnimationTransitionNone,              //不使用动画
//     UIViewAnimationTransitionFlipFromLeft,      //从左向右旋转翻页
//     UIViewAnimationTransitionFlipFromRight,     //从右向左旋转翻页
//     UIViewAnimationTransitionCurlUp,            //从下往上卷曲翻页
//     UIViewAnimationTransitionCurlDown,          //从上往下卷曲翻页
//     第二个参数：需要过渡效果的View
//     第三个参数：是否使用视图缓存，YES：视图在开始和结束时渲染一次；NO：视图在每一帧都渲染*/
//
//    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:NO];
//    // 结束动画语句：
//    [UIView commitAnimations];
}

- (void)startEvent {
    self.testView.backgroundColor = UIColor.redColor;
}

- (void)stopAnimation {
    NSLog(@"动画结束了");
}

@end
