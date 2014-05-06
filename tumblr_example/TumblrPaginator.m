//
//  TumblrPaginator.m
//  tumblr_example
//
//  Created by Dr.Evil on 06/05/14.
//  Copyright (c) 2014 FerdinandUrban. All rights reserved.
//

#import "TumblrPaginator.h"
#import "TumblrFetcher.h"

@implementation TumblrPaginator

- (void)fetchResultsWithPage:(NSInteger)page pageSize:(NSInteger)pageSize
{
    dispatch_queue_t fetchQ = dispatch_queue_create("Tumblr fetcher", NULL);
    dispatch_async(fetchQ, ^
    {
        NSDictionary *jsonData = [TumblrFetcher getPhotosPage:page pageSize:pageSize];
 
        dispatch_sync(dispatch_get_main_queue(), ^
        {
            NSArray *posts = [[jsonData valueForKey:@"response"] valueForKey:@"posts"];
            NSInteger total = [[[jsonData valueForKeyPath:@"response"] valueForKey:@"total_posts"] integerValue];
            
            [self receivedResults:posts total:total];
        });
    });
    
}

@end
