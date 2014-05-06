//
//  ViewController.h
//  tumblr_example
//
//  Created by Dr.Evil on 06/05/14.
//  Copyright (c) 2014 FerdinandUrban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) NSMutableDictionary *tumblrDetail;

@property (weak, nonatomic) IBOutlet UIImageView *postImage;
@property (weak, nonatomic) IBOutlet UILabel *postTitle;
@property (weak, nonatomic) IBOutlet UILabel *postDetail;

@end
