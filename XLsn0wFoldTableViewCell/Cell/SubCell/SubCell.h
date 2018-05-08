//
//  WSTableViewCell.h
//  WSTableView
//
//  Created by Sakkaras on 26/12/13.
//  Copyright (c) 2013 Sakkaras. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  WSTableViewCell is a custom table view cell class extended from UITableViewCell class. This class is used to represent the
 *  expandable rows of the WSTableView object.
 */

typedef NS_ENUM(NSInteger, CellType) {
    CellType_Default,//默认从0开始
    CellType_WeatherStation,
};

@interface SubCell :UITableViewCell

@property (nonatomic, assign) CellType type;

@property (strong, nonatomic) UIImageView *iconImageView;

@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UILabel *sn;

@property (strong, nonatomic) UIImageView *arrow;


@end
