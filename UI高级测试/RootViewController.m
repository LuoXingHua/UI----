//
//  RootViewController.m
//  UI高级测试
//
//  Created by Ibokan on 14-4-23.
//  Copyright (c) 2014年 Ibokan. All rights reserved.
//

#import "RootViewController.h"
#import "GDataXMLNode.h"
#import "MapViewController.h"
@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	self.navigationItem.title = @"城市";
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 480) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    self.dataArray = [NSMutableArray array];
    [self prepaerData];
}



-(void)prepaerData{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.meituan.com/api/v1/divisions"]];
    [NSURLConnection connectionWithRequest:request delegate:self];
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    self.data = nil;
    self.data = [NSMutableData data];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [self.data appendData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    //获取全部内容
    GDataXMLDocument * document = [[GDataXMLDocument alloc]initWithData:self.data options:0 error:nil];
    //获取所有节点
    GDataXMLElement *divisions = [document rootElement];
    //获取division节点
    GDataXMLElement *division = [[divisions children] objectAtIndex:0];
    NSArray * arr = [division children];
    for (GDataXMLElement *obj in arr) {
        NSMutableArray * arr = [NSMutableArray array];
        GDataXMLElement * idstr = [[obj children]objectAtIndex:1];
        NSString * name = [idstr stringValue];
        GDataXMLElement * location = [[obj children]objectAtIndex:2];
        GDataXMLElement * latitude = [[location children]objectAtIndex:2];
        GDataXMLElement * lotitude = [[location children]objectAtIndex:3];
        NSString * latitude1 = [latitude stringValue];
        NSString * longitude1 = [lotitude stringValue];
        [arr addObject:name];
        [arr addObject:latitude1];
        [arr addObject:longitude1];
        [self.dataArray addObject:arr];
    }
    [self.tableView reloadData];
    
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    self.data = nil;
    NSLog(@"%@",[error localizedDescription]);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * string = @"string";
    __autoreleasing UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:string];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
    }
    cell.textLabel.text = [[self.dataArray objectAtIndex:indexPath.row] objectAtIndex:0];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MapViewController *map = [[MapViewController alloc]init];
    map.data = [self.dataArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:map animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
