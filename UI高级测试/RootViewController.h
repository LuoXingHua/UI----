//
//  RootViewController.h
//  UI高级测试
//
//  Created by Ibokan on 14-4-23.
//  Copyright (c) 2014年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSURLConnectionDataDelegate>

@property (strong,nonatomic)NSMutableData *data;
@property(strong,nonatomic)NSMutableArray *dataArray;

@property(strong,nonatomic)UITableView * tableView;

@end
