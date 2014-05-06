//
//  TableViewController.h
//  tumblr_example
//
//  Created by Dr.Evil on 06/05/14.
//  Copyright (c) 2014 FerdinandUrban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TumblrPaginator.h"

@interface TableViewController : UITableViewController <UITableViewDataSource, NMPaginatorDelegate, UIScrollViewDelegate>

@property (strong, nonatomic) NSMutableArray *tumblrPosts;
@property (strong, nonatomic) TumblrPaginator  *tumblrPaginator;

@end
