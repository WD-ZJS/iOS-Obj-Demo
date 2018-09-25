//
//  SortContactsController.m
//  iOS-Objc-Demo
//
//  Created by zjs on 2018/9/12.
//  Copyright © 2018年 forever.love. All rights reserved.
//

#import "SortContactsController.h"
#import "DNContactsCell.h"
#import "DNContactsModel.h"
#import "DNSortContactsTool.h"

@interface SortContactsController ()

@property (nonatomic, strong) NSMutableArray * sectionArray;
@property (nonatomic, strong) NSMutableArray * contactArray;
@end

@implementation SortContactsController

#pragma mark -- LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.wdNavigationBar.centerButton setTitle:@"联系人排序" forState:UIControlStateNormal];
    
    [self setControlForSuper];
    [self addConstrainsForSuper];
    
    [DNSortContactsTool sortAndGroup:[self configContactsData]
                                 key:@"name"
                              finish:^(bool isSuccess, NSMutableArray *unGroupArr, NSMutableArray *sectionTitleArr, NSMutableArray<NSMutableArray *> *sortedObjArr) {
       
        self.sectionArray = sectionTitleArr;
        self.contactArray = sortedObjArr;
        [self.tableView reloadData];
    }];
    
    // Do any additional setup after loading the view.
}

/**

- (void)viewWillAppear:(BOOL)animated {
[super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
[super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
[super viewWillDisappear:animated];
}

-(void)viewDidDisappear:(BOOL)animated {
[super viewDidDisappear:animated];
}
*/


#pragma mark -- DidReceiveMemoryWarning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- SetControlForSuper
- (void)setControlForSuper {
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DNContactsCell" bundle:nil] forCellReuseIdentifier:@"DNContactsCell"];
    [self.view addSubview:self.tableView];
}

#pragma mark -- AddConstrainsForSuper
- (void)addConstrainsForSuper {

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.wdNavigationBar.mas_bottom);
        make.leading.trailing.bottom.mas_equalTo(self.view);
    }];
}

- (NSMutableArray *)configContactsData {
    
    DNContactsModel * model1  = [[DNContactsModel alloc] initWithName:@"张三" age:@"10岁" sex:@"女"];
    DNContactsModel * model2  = [[DNContactsModel alloc] initWithName:@"李四" age:@"18岁" sex:@"男"];
    DNContactsModel * model3  = [[DNContactsModel alloc] initWithName:@"王五" age:@"18岁" sex:@"男"];
    DNContactsModel * model4  = [[DNContactsModel alloc] initWithName:@"赵六" age:@"18岁" sex:@"女"];
    DNContactsModel * model5  = [[DNContactsModel alloc] initWithName:@"王二麻子" age:@"18岁" sex:@"女"];
    DNContactsModel * model6  = [[DNContactsModel alloc] initWithName:@"二狗子" age:@"18岁" sex:@"男"];
    DNContactsModel * model7  = [[DNContactsModel alloc] initWithName:@"狗剩子" age:@"18岁" sex:@"男"];
    DNContactsModel * model8  = [[DNContactsModel alloc] initWithName:@"哈哈" age:@"18岁" sex:@"女"];
    DNContactsModel * model9  = [[DNContactsModel alloc] initWithName:@"😆" age:@"18岁" sex:@"男"];
    DNContactsModel * model10 = [[DNContactsModel alloc] initWithName:@"你是说" age:@"18岁" sex:@"女"];
    DNContactsModel * model11 = [[DNContactsModel alloc] initWithName:@"认我做大哥" age:@"18岁" sex:@"男"];
    DNContactsModel * model12 = [[DNContactsModel alloc] initWithName:@"梳中分" age:@"18岁" sex:@"女"];
    DNContactsModel * model13 = [[DNContactsModel alloc] initWithName:@"我们走" age:@"18岁" sex:@"女"];
    DNContactsModel * model14 = [[DNContactsModel alloc] initWithName:@"去不去" age:@"18岁" sex:@"男"];
    DNContactsModel * model15 = [[DNContactsModel alloc] initWithName:@"小偷" age:@"18岁" sex:@"女"];
    DNContactsModel * model16 = [[DNContactsModel alloc] initWithName:@"警察" age:@"18岁" sex:@"男"];
    
    NSMutableArray * array = [NSMutableArray arrayWithObjects:model1,model2,model3,model4,model5,model6,model7,model8,model9,model10,model11,model12,model13,model14,model15,model16, nil];
    
    return array;
}

#pragma mark -- Target Methods

#pragma mark -- Private Methods

#pragma mark -- UITableView Delegate && DataSource

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return self.sectionArray[section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.contactArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.contactArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DNContactsModel * model = self.contactArray[indexPath.section][indexPath.row];
    DNContactsCell  * cell  = [tableView dequeueReusableCellWithIdentifier:@"DNContactsCell"
                                                              forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = model;
    return cell;
}

// 索引
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    return self.sectionArray;
}

/**

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
return <#height#>;
}
*/

#pragma mark -- Other Delegate

#pragma mark -- NetWork Methods

#pragma mark -- Setter && Getter

@end
