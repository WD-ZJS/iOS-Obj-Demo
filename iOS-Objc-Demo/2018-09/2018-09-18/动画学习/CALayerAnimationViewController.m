//
//  CALayerAnimationViewController.m
//  iOS-Objc-Demo
//
//  Created by 吴丹 on 2018/9/18.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "CALayerAnimationViewController.h"

@interface CALayerAnimationViewController ()

@property (nonatomic, strong) UIView *testView;

@end

@implementation CALayerAnimationViewController

/*
//下面是CALayer的一些属性介绍
//宽度和高度
@property CGRect bounds;

//位置(默认指中点，具体由anchorPoint决定)
@property CGPoint position;

//锚点(x,y的范围都是0-1)，决定了position的含义
@property CGPoint anchorPoint;

//背景颜色(CGColorRef类型)
@propertyCGColorRefbackgroundColor;

//形变属性
@property CATransform3D transform;

//边框颜色(CGColorRef类型)
@property  CGColorRef  borderColor;

//边框宽度
@property CGFloat borderWidth;

//圆角半径
@property CGFloat cornerRadius;

//内容(比如设置为图片CGImageRef)
@property(retain) id contents;
*/


- (void)viewDidLoad {
    [super viewDidLoad];
   
    // 测试控件
    self.testView = [[UIView alloc] init];
    self.testView.backgroundColor = UIColor.orangeColor;
    [self.view addSubview:self.testView];
    self.testView.frame = CGRectMake(0, UIApplication.sharedApplication.statusBarFrame.size.height + 44, 100, 100);
    

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self CABasicAnimation];
   
//    self.testView.layer.anchorPoint = CGPointMake(0.5, 0.5);
//    [UIView animateWithDuration:3.0 animations:^{
//        self.testView.transform = CGAffineTransformMakeRotation(M_PI);
//        self.testView.layer.backgroundColor = UIColor.greenColor.CGColor;
//    } completion:^(BOOL finished) {
//
//    }];
    
//    bounds：用于设置CALayer的宽度和高度。修改这个属性会产生缩放动画
//    backgroundColor：用于设置CALayer的背景色。修改这个属性会产生背景色的渐变动画
//    position：用于设置CALayer的位置。修改这个属性会产生平移动画
  
//    可以通过事务关闭隐式动画：
    
//    [CATransaction begin];
//    // 关闭隐式动画
//    [CATransaction setDisableActions:YES];
//    self.testView.layer.position = CGPointMake(10, 10);
//    [CATransaction commit];
    
 
   
    
//    CALayer *myLayer = [CALayer layer];
//    // 设置层的宽度和高度（100x100）
//    myLayer.bounds = CGRectMake(0, 0, 100, 100);
//    // 设置层的位置
//    myLayer.position = CGPointMake(100, 100);
//    // 设置层的背景颜色：红色
//    myLayer.backgroundColor = [UIColor redColor].CGColor;
//
//    /**
//     *   (0, 0)   左上角
//     *   (0, 0.5) 上中间
//     *   (0, 1)   右上角
//     *   。。。。。
//     */
//
//    myLayer.anchorPoint = CGPointMake(1, 1);
//
//    // 添加myLayer到控制器的view的layer中
//    [self.view.layer addSublayer:myLayer];
}

- (void)CABasicAnimation {
//    //创建动画
//    CABasicAnimation *anim = [CABasicAnimation animation];;
//    //    设置动画对象
////    keyPath决定了执行怎样的动画,调用layer的哪个属性来执行动画position:平移
//    anim.keyPath = @"position";
//    //    包装成对象
//    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];;
//    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(200, 300)];
//    anim.duration = 2.0;
//
//    //    让图层保持动画执行完毕后的状态
//    //    执行完毕以后不要删除动画
//    anim.removedOnCompletion = NO;
//    //    保持最新的状态
//    anim.fillMode = kCAFillModeForwards;
//
//    //    添加动画
//    [self.testView.layer addAnimation:anim forKey:nil];
    
#pragma mark =============== 组动画 ===============
    //    创建动画
//    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];;
//    //    设置动画对象
//    //  keyPath决定了执行怎样的动画,调整哪个属性来执行动画
//    anim.keyPath = @"position";
//    NSValue *v1 = [NSValue valueWithCGPoint:CGPointMake(100, 0)];
//    NSValue *v2 = [NSValue valueWithCGPoint:CGPointMake(200, 0)];
//    NSValue *v3 = [NSValue valueWithCGPoint:CGPointMake(300, 0)];
//    NSValue *v4 = [NSValue valueWithCGPoint:CGPointMake(400, 0)];
//
//    anim.values = @[v1,v2,v3,v4];
//    anim.duration = 2.0;
//    //    让图层保持动画执行完毕后的状态
//    //    状态执行完毕后不要删除动画
//    anim.removedOnCompletion = NO;
//    //    保持最新的状态
//    anim.fillMode = kCAFillModeForwards;
//
//    //    添加动画
//    [self.testView.layer addAnimation:anim forKey:nil];
    
#pragma mark =============== 路径动画 ===============
    //  根据路径创建动画
    //    创建动画
//    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];;
//
//    anim.keyPath = @"position";
//    anim.removedOnCompletion = NO;
//    anim.fillMode = kCAFillModeForwards;
//    anim.duration = 2.0;
//
//    //    创建一个路径
//    CGMutablePathRef path = CGPathCreateMutable();
//    //    路径的范围
//    CGPathAddEllipseInRect(path, NULL, CGRectMake(100, 100, 200, 200));
//    //    添加路径
//    anim.path = path;
//    //    释放路径(带Create的函数创建的对象都需要手动释放,否则会内存泄露)
//    CGPathRelease(path);
//    //    添加到View的layer
//    [self.testView.layer addAnimation:anim forKey:nil];
    
    
#pragma mark =============== 帧动画 ===============
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"transform.rotation";
    anim.values = @[@(M_PI * -5), @(M_PI * 5), @(M_PI * -5)];
    anim.repeatCount = MAXFLOAT;
    //自动反转
    //anim.autoreverses = YES;
    [self.testView.layer addAnimation:anim forKey:nil];

}
@end
