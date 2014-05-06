//
//  ViewController.m
//  tumblr_example
//
//  Created by Dr.Evil on 06/05/14.
//  Copyright (c) 2014 FerdinandUrban. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize postDetail;
@synthesize postTitle;
@synthesize postImage;
@synthesize tumblrDetail;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.postTitle.text = [self.tumblrDetail objectForKey:@"title"];
    self.postDetail.text = [self.tumblrDetail objectForKey:@"detail"];
    [self.postImage setImageWithURL:[NSURL URLWithString:[self.tumblrDetail objectForKey:@"imgURL"]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
