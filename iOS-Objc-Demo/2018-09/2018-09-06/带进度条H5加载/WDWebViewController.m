//
//  WDWebViewController.m
//  iOS-Demo
//
//  Created by 吴丹 on 2018/9/6.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "WDWebViewController.h"
#import <WebKit/WebKit.h>
@interface WDWebViewController ()<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) NSLayoutConstraint *hiehtConstraint;

@end

@implementation WDWebViewController

#pragma mark =============== Dealloc ===============
- (void)dealloc {
    NSLog(@"%@被销毁",[self class]);
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"title"];
}

#pragma mark =============== ViewControllerLifeyCyle ===============
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationBar];
    [self setupSubViewsPropertys];
    [self setupSubViewsConstraints];
    [self dataInitialization];
}

 - (void)viewWillAppear:(BOOL)animated {
     [super viewWillAppear:animated];
     self.navigationController.navigationBar.hidden = false;
     
     [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
     [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
     [self.webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:NULL];
 }

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = true;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)webViewGoBack {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    } else {
        [self dismissViewControllerAnimated:true completion:nil];
        [self.navigationController popViewControllerAnimated:true];
    }
}

- (void)popView{
    [self.navigationController popViewControllerAnimated:true];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        
        if (object == self.webView) {
            [self.progressView setAlpha:1.0f];
            [self.progressView setProgress:self.webView.estimatedProgress animated:YES];
            
            if (self.webView.estimatedProgress >= 1.0f) {
                [UIView animateWithDuration:0.5f
                                      delay:0.3f
                                    options:UIViewAnimationOptionCurveEaseOut
                                 animations:^{
                                     [self.progressView setAlpha:0.0f];
                                 }
                                 completion:^(BOOL finished) {
                                     [self.progressView setProgress:0.0f animated:NO];
                                 }];
            }
        }  else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    } else if ([keyPath isEqualToString:@"title"]) {
        if (object == self.webView) {
            self.title = self.webView.title;
        } else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    } else if ([keyPath isEqualToString:@"canGoBack"]) {
        
        if (object == self.webView) {
            
            self.navigationController.interactivePopGestureRecognizer.enabled = self.webView.canGoBack;
        } else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
 
#pragma mark =============== Set up navigation bar style ===============
- (void)setupNavigationBar {

    [self.view addSubview:self.progressView];
    [self.view addSubview:self.webView];
}

#pragma mark =============== Add controls, set properties ===============
- (void)setupSubViewsPropertys {
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(webViewGoBack)];
}

#pragma mark =============== Setting control layout constraints ===============
- (void)setupSubViewsConstraints {
    self.progressView.translatesAutoresizingMaskIntoConstraints = false;
    NSLayoutConstraint *pro_Top = [NSLayoutConstraint constraintWithItem:self.progressView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:UIApplication.sharedApplication.statusBarFrame.size.height + 44];
    NSLayoutConstraint *pro_leading = [NSLayoutConstraint constraintWithItem:self.progressView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    NSLayoutConstraint *pro_trealing = [NSLayoutConstraint constraintWithItem:self.progressView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    NSLayoutConstraint *pro_height = [NSLayoutConstraint constraintWithItem:self.progressView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:0 constant:2];
    [self.view addConstraints:@[pro_Top,pro_leading,pro_trealing,pro_height]];
    
    self.webView.translatesAutoresizingMaskIntoConstraints = false;
    NSLayoutConstraint *web_Top = [NSLayoutConstraint constraintWithItem:self.webView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.progressView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    NSLayoutConstraint *web_leading = [NSLayoutConstraint constraintWithItem:self.webView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    NSLayoutConstraint *web_trealing = [NSLayoutConstraint constraintWithItem:self.webView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    NSLayoutConstraint *web_buttom = [NSLayoutConstraint constraintWithItem:self.webView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [self.view addConstraints:@[web_Top,web_leading,web_trealing,web_buttom]];
}

#pragma mark =============== Data initialization ===============
- (void)dataInitialization { }

#pragma mark =============== Events ===============

#pragma mark =============== PirvateMethod ===============

#pragma mark =============== PublicMethod ===============

#pragma mark =============== Network request ===============

#pragma mark =============== Getter ===============

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] init];
        _progressView.progressTintColor = UIColor.redColor;

    }
    return _progressView;
}

- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] init];
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    }
    return _webView;
}

#pragma mark =============== Setter ===============

@end

