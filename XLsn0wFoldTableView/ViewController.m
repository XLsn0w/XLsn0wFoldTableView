//
//  ViewController.h
//  XLsn0wFoldTableView
//
//  Created by ginlong on 2018/5/8.
//  Copyright © 2018年 ginlong. All rights reserved.

#import "ViewController.h"
#import "XLsn0wFoldTableHeader.h"
#import <XLsn0wKit_objc/XLsn0wKit_objc.h>

@interface ViewController () <FoldTableViewDelegate>

@property (nonatomic, strong) NSArray *contents;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) FoldTableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView = [[FoldTableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.tableView];
    self.tableView.foldDelegate = self;
    [self.tableView registerClass:[SuperCell class] forCellReuseIdentifier:@"SuperCell"];
    [self.tableView registerClass:[SubCell class] forCellReuseIdentifier:@"SubCell"];
    
    _dataArray = [NSMutableArray array];
    
    WSTableviewDataModel *dataModel = [[WSTableviewDataModel alloc] init];
    dataModel.firstLevelStr = @"医院选择";
    dataModel.shouldExpandSubRows = NO;
    [dataModel object_add_toSecondLevelArrM:@"逆变器"];
    [dataModel object_add_toSecondLevelArrM:@"逆变器"];
    [dataModel object_add_toSecondLevelArrM:@"电表"];
    [dataModel object_add_toSecondLevelArrM:@"电表"];
    [_dataArray addObject:dataModel];
    
    
    WSTableviewDataModel *dataModel2 = [[WSTableviewDataModel alloc] init];
    dataModel2.firstLevelStr = @"部位选择";
    dataModel2.shouldExpandSubRows = NO;
    [dataModel2 object_add_toSecondLevelArrM:@"逆变器"];
    [dataModel2 object_add_toSecondLevelArrM:@"逆变器"];
    [dataModel2 object_add_toSecondLevelArrM:@"电表"];
    [dataModel2 object_add_toSecondLevelArrM:@"电表"];
    [_dataArray addObject:dataModel2];
    
    
    [_dataArray addObject:dataModel2];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray count];
    
}

- (NSInteger)tableView:(FoldTableView *)tableView numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath {
    WSTableviewDataModel *dataModel = _dataArray[indexPath.row];
    return dataModel.secondLevelArrM.count;
}

- (BOOL)tableView:(FoldTableView *)tableView shouldExpandSubRowsOfCellAtIndexPath:(NSIndexPath *)indexPath {
    WSTableviewDataModel *dataModel = _dataArray[indexPath.row];
    return dataModel.shouldExpandSubRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WSTableviewDataModel *dataModel = _dataArray[indexPath.row];
  
    SuperCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SuperCell"];
    cell.expandable = dataModel.expandable;
    return cell;
}

- (UITableViewCell *)tableView:(FoldTableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath {
    WSTableviewDataModel *dataModel = _dataArray[indexPath.row];
    SubCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SubCell"];
    cell.name.text = [dataModel object_get_fromSecondLevelArrMWithIndex:indexPath.subRow];
    return cell;
}

- (CGFloat)tableView:(FoldTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0f;
}

- (CGFloat)tableView:(FoldTableView *)tableView heightForSubRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"row == %@", [NSString stringWithFormat:@"%ld", indexPath.row]);
    WSTableviewDataModel *dataModel = _dataArray[indexPath.row];
    dataModel.shouldExpandSubRows = !dataModel.shouldExpandSubRows;

    
    SuperCell *cell = (SuperCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.superCellBlock = ^(BOOL isShow, NSString *msg) {
        if (isShow == true) {
            NSLog(@"true");
        }
    };
}

- (void)tableView:(FoldTableView *)tableView didSelectSubRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"subRow == %@", [NSString stringWithFormat:@"%ld", indexPath.subRow]);
}

#pragma mark - Actions

//- (void)collapseSubrows
//{
//    [self.tableView collapseCurrentlyExpandedIndexPaths];
//}

//- (void)refreshData
//{
//    NSArray *array = @[
//                       @[
//                           @[@"Section0_Row0", @"Row0_Subrow1",@"Row0_Subrow2"],
//                           @[@"Section0_Row1", @"Row1_Subrow1", @"Row1_Subrow2", @"Row1_Subrow3", @"Row1_Subrow4", @"Row1_Subrow5", @"Row1_Subrow6", @"Row1_Subrow7", @"Row1_Subrow8", @"Row1_Subrow9", @"Row1_Subrow10", @"Row1_Subrow11", @"Row1_Subrow12"],
//                           @[@"Section0_Row2"]
//                        ]
//                     ];
//    [self reloadTableViewWithData:array];
//    
//    [self setDataManipulationButton:UIBarButtonSystemItemUndo];
//}

//- (void)undoData
//{
//    [self reloadTableViewWithData:nil];
//    
//    [self setDataManipulationButton:UIBarButtonSystemItemRefresh];
//}

//- (void)reloadTableViewWithData:(NSArray *)array
//{
//    self.contents = array;
//    
//    // Refresh data not scrolling
////    [self.tableView refreshData];
//    
//    [self.tableView refreshDataWithScrollingToIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
//}

#pragma mark - Helpers
//
//- (void)setDataManipulationButton:(UIBarButtonSystemItem)item
//{
//    switch (item) {
//        case UIBarButtonSystemItemUndo:
//            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemUndo
//                                                                                                  target:self
//                                                                                                  action:@selector(undoData)];
//            break;
//            
//        default:
//            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
//                                                                                                  target:self
//                                                                                                  action:@selector(refreshData)];
//            break;
//    }
//}

@end
