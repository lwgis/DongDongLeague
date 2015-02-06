//
//  SelectProjectViewController.m
//  DongDongLeague
//
//  Created by 李炜 on 15/2/3.
//  Copyright (c) 2015年 DongDongLeague. All rights reserved.
//

#import "SelectProjectViewController.h"
#import "DongDongClient.h"
#import "Project.h"
#import "UIImageView+AFNetworking.h"
@interface SelectProjectViewController ()
@end

@implementation SelectProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.tableView.estimatedRowHeight = 44.0;
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
    allProjects=[[NSMutableArray alloc] init];
    [[DongDongClient sharedClient] GET:@"events" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic=(NSDictionary *)responseObject;
        NSArray *sportsEventArray=[dic objectForKey:@"sportsEvent"];
        for (NSDictionary *projectDic in sportsEventArray) {
            Project *project=[[Project alloc] initWithPid:[projectDic valueForKey:@"id"] name:[projectDic valueForKey:@"name"] icon:[projectDic valueForKey:@"icon"]];
            [allProjects addObject:project];
        }
        self.tableView.delegate=self;
        self.tableView.dataSource=self;
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - UITableDataSourceDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [allProjects count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"SelectProject"];
    UIImageView *imageView=(UIImageView *) [cell viewWithTag:100];
    UILabel *label=(UILabel *)[cell viewWithTag:101];
    Project *project=(Project *)[allProjects objectAtIndex:[indexPath row]];
    [imageView setImageWithURL:[NSURL URLWithString:project.icon]];
    [label setText:project.name];
    label.backgroundColor=[UIColor clearColor];
    cell.backgroundColor=[UIColor clearColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    Project *project=[allProjects objectAtIndex:indexPath.row];
    [ud setValue:project.pid forKey:@"projectid"];
    [ud setValue:project.name forKey:@"projectname"];
    [ud synchronize];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
@end
