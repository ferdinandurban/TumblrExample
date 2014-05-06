//
//  TableViewController.m
//  tumblr_example
//
//  Created by Dr.Evil on 06/05/14.
//  Copyright (c) 2014 FerdinandUrban. All rights reserved.
//

#import "TableViewController.h"
#import "ViewController.h"
#import "MyCell.h"
#import "TumblrFetcher.h"
#import "AFNetworking.h"

@interface TableViewController ()

@end

@implementation TableViewController

@synthesize tumblrPaginator;

int currentPage = 0;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tumblrPosts = [[NSMutableArray alloc] init];

    self.tumblrPaginator = [[TumblrPaginator alloc] initWithPageSize:5 delegate:self];
    [self.tumblrPaginator fetchFirstPage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)paginator:(id)paginator didReceiveResults:(NSArray *)results
{
    NSInteger i = [self.tumblrPaginator.results count] - [results count];
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];

    
    for(NSMutableDictionary *result in results)
    {
        NSMutableDictionary *tmpDic = [[NSMutableDictionary alloc] init];
        NSMutableArray *photos = [result objectForKey:@"photos"];
        
        [tmpDic setObject:[[[photos objectAtIndex:0] objectForKey:@"original_size"] objectForKey:@"url"] forKey:@"imgURL"];
        [tmpDic setObject:[result objectForKey:@"blog_name"] forKey:@"title"];
        [tmpDic setObject:[result objectForKey:@"slug"] forKey:@"detail"];
        
        [self.tumblrPosts addObject:tmpDic];
        
        [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
        i++;
    }
    
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:indexPaths
                          withRowAnimation:UITableViewRowAnimationMiddle];
    [self.tableView endUpdates];
}

- (void)paginatorDidReset:(id)paginator
{
    [self.tableView reloadData];
}

- (void)fetchNextPage
{
    [self.tumblrPaginator fetchNextPage];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    MyCell *tablecell = (MyCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    NSDictionary *tmpDict = [self.tumblrPosts objectAtIndex:indexPath.row];
    
    tablecell.postTitle.text = [tmpDict objectForKey:@"title"];
    tablecell.postDetail.text = [tmpDict objectForKey:@"detail"];
    [tablecell.postImage setImageWithURL:[NSURL URLWithString:[tmpDict objectForKey:@"imgURL"]]];
    
    return tablecell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    ViewController *detailViewController = (ViewController *)segue.destinationViewController;
    NSMutableDictionary *tmpDic = [self.tumblrPosts objectAtIndex:indexPath.row];

    detailViewController.tumblrDetail = [[NSMutableDictionary alloc] init];
    
    [detailViewController.tumblrDetail setObject:[tmpDic objectForKey:@"title"] forKey:@"title"];
    [detailViewController.tumblrDetail setObject:[tmpDic objectForKey:@"detail"] forKey:@"detail"];
    [detailViewController.tumblrDetail setObject:[tmpDic objectForKey:@"imgURL"] forKey:@"imgURL"];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tumblrPaginator.results count];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y == scrollView.contentSize.height - scrollView.bounds.size.height)
    {
        if(![self.tumblrPaginator reachedLastPage])
        {
            [self fetchNextPage];
        }
    }
}

@end
