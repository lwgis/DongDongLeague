//
//  SelectProjectViewController.h
//  DongDongLeague
//
//  Created by 李炜 on 15/2/3.
//  Copyright (c) 2015年 DongDongLeague. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectProjectViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *allProjects;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
