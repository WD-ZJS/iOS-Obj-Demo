//
//  WDContactPersonViewController.m
//  iOS-Objc-Demo
//
//  Created by wudan on 2018/9/25.
//  Copyright © 2018年 forever.love. All rights reserved.
//

#import "WDContactPersonViewController.h"
#import <ContactsUI/ContactsUI.h>

@interface WDContactPersonViewController () <CNContactPickerDelegate>

@property (nonatomic, strong) UIButton *selectedPeopleButton;
@property (nonatomic, strong) UILabel *numLabel;

@end

@implementation WDContactPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setupNavigationBar {
    [super setupNavigationBar];
    [self.wdNavigationBar.centerButton setTitle:@"选择联系人" forState:UIControlStateNormal];
}

- (void)setupSubviews {
    self.selectedPeopleButton = [[UIButton alloc] init];
    [self.selectedPeopleButton setTitle:@"点击选择" forState:UIControlStateNormal];
    [self.selectedPeopleButton setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    [self.selectedPeopleButton addTarget:self action:@selector(infoSelect:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.selectedPeopleButton];
    
    self.numLabel = [[UILabel alloc] init];
    self.numLabel.textColor = UIColor.blackColor;
    [self.view addSubview:self.numLabel];
}

- (void)setupSubviewsConstraints {
    [self.selectedPeopleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
    }];
    
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.selectedPeopleButton.mas_bottom).mas_offset(50);
    }];
}


- (void)infoSelect:(UIButton *)sender {
    //让用户给权限,没有的话会被拒的各位
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    if (status == CNAuthorizationStatusNotDetermined) {
        CNContactStore *store = [[CNContactStore alloc] init];
        [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (error) {
                NSLog(@"没有授权, 需要去设置中心设置授权");
            }else
            {
                NSLog(@"用户已授权限");
                CNContactPickerViewController * picker = [CNContactPickerViewController new];
                picker.delegate = self;
                // 加载手机号
                picker.displayedPropertyKeys = @[CNContactPhoneNumbersKey];
                [self presentViewController: picker  animated:YES completion:nil];
            }
        }];
    }
    
    if (status == CNAuthorizationStatusAuthorized) {
        
        //有权限时
        CNContactPickerViewController * picker = [CNContactPickerViewController new];
        picker.delegate = self;
        picker.displayedPropertyKeys = @[CNContactPhoneNumbersKey];
        [self presentViewController: picker  animated:YES completion:nil];
    }
    else{
        NSLog(@"您未开启通讯录权限,请前往设置中心开启");
    }
}

-  (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty {
    CNContact *contact = contactProperty.contact;
    
    NSLog(@"%@",contactProperty);
    NSLog(@"givenName: %@, familyName: %@", contact.givenName, contact.familyName);
    
    self.numLabel.text = [NSString stringWithFormat:@"%@%@",contact.familyName,contact.givenName];
    if (![contactProperty.value isKindOfClass:[CNPhoneNumber class]]) {
        NSLog(@"提示用户选择11位的手机号");
        return;
    }
    
    CNPhoneNumber *phoneNumber = contactProperty.value;
    NSString * Str = phoneNumber.stringValue;
    NSCharacterSet *setToRemove = [[ NSCharacterSet characterSetWithCharactersInString:@"0123456789"]invertedSet];
    NSString *phoneStr = [[Str componentsSeparatedByCharactersInSet:setToRemove]componentsJoinedByString:@""];
    if (phoneStr.length != 11) {
        
        NSLog(@"提示用户选择11位的手机号");
    }
    
    NSLog(@"-=-=%@",phoneStr);
    self.numLabel.text = phoneStr;
}


@end
