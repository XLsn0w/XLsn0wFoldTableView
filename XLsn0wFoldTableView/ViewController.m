//
//  ViewController.h
//  XLsn0wFoldTableView
//
//  Created by ginlong on 2018/5/8.
//  Copyright © 2018年 ginlong. All rights reserved.

#import "ViewController.h"
#import "XLsn0wFoldTableHeader.h"
#import "NSIndexPath+SubRow.h"
//#import <XLsn0wKit_objc/XLsn0wKit_objc.h>

@interface ViewController () <FoldTableViewDelegate>

@property (nonatomic, strong) NSArray *contents;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) FoldTableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addFoldTableView];
}

- (void)addFoldTableView {
    self.tableView = [[FoldTableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.tableView];
    self.tableView.foldDelegate = self;
    [self.tableView registerClass:[SuperCell class] forCellReuseIdentifier:@"SuperCell"];
    [self.tableView registerClass:[SubCell class] forCellReuseIdentifier:@"SubCell"];
    
    _dataArray = [NSMutableArray array];
}

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(FoldTableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;
}

- (UIView *)tableView:(FoldTableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerSection = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 40))];
    UILabel* title = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, 200, 40)];
    [headerSection addSubview:title];
    title.text = @"这是SectionHeader";
    title.textColor = UIColor.whiteColor;
    headerSection.backgroundColor = UIColor.redColor;
    return headerSection;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
    
}

- (NSInteger)tableView:(FoldTableView *)tableView numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath {
    return 4;
}

- (BOOL)tableView:(FoldTableView *)tableView shouldExpandSubRowsOfCellAtIndexPath:(NSIndexPath *)indexPath {
    return false;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SuperCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SuperCell"];
    cell.expandable = YES;
    return cell;
}

- (UITableViewCell *)tableView:(FoldTableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath {
    SubCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SubCell"];
    cell.name.text = @"逆变器";
    return cell;
}

- (CGFloat)tableView:(FoldTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (CGFloat)tableView:(FoldTableView *)tableView heightForSubRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"row == %@", [NSString stringWithFormat:@"%ld", indexPath.row]);
//    [XLsn0wShow showCenterWithText:@"跳转采集器详情"];
}

- (void)tableView:(FoldTableView *)tableView didSelectSubRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"subRow == %@", [NSString stringWithFormat:@"%ld", indexPath.subRow]);
//    [XLsn0wShow showCenterWithText:@"跳转逆变器详情"];
}














#pragma mark - Actions  各种自定义响应事件

- (void)collapseSubrows
{
    [self.tableView collapseCurrentlyExpandedIndexPaths];
}

- (void)refreshData
{
    NSArray *array = @[
                       @[
                           @[@"Section0_Row0", @"Row0_Subrow1",@"Row0_Subrow2"],
                           @[@"Section0_Row1", @"Row1_Subrow1", @"Row1_Subrow2", @"Row1_Subrow3", @"Row1_Subrow4", @"Row1_Subrow5", @"Row1_Subrow6", @"Row1_Subrow7", @"Row1_Subrow8", @"Row1_Subrow9", @"Row1_Subrow10", @"Row1_Subrow11", @"Row1_Subrow12"],
                           @[@"Section0_Row2"]
                        ]
                     ];
    [self reloadTableViewWithData:array];
    
    [self setDataManipulationButton:UIBarButtonSystemItemUndo];
}

- (void)undoData
{
    [self reloadTableViewWithData:nil];
    
    [self setDataManipulationButton:UIBarButtonSystemItemRefresh];
}

- (void)reloadTableViewWithData:(NSArray *)array {
    self.contents = array;
    // Refresh data not scrolling
    [self.tableView refreshData];
    [self.tableView refreshDataWithScrollingToIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
}

#pragma mark - Helpers

- (void)setDataManipulationButton:(UIBarButtonSystemItem)item {
    switch (item) {
        case UIBarButtonSystemItemUndo:
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemUndo
                                                                                                  target:self
                                                                                                  action:@selector(undoData)];
            break;
            
        default:
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                                                  target:self
                                                                                                  action:@selector(refreshData)];
            break;
    }
}

@end
