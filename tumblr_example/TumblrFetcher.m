//
//  TumblrFetcher.m
//  tumblr_example
//
//  Created by Dr.Evil on 06/05/14.
//  Copyright (c) 2014 FerdinandUrban. All rights reserved.
//

#import "TumblrFetcher.h"

@implementation TumblrFetcher

+ (NSDictionary *)executeFetch:(NSString *)query
{    
    NSData *jsonData = [[NSString stringWithContentsOfURL: [NSURL URLWithString:query]
                                                 encoding:NSUTF8StringEncoding
                                                    error:nil]
                                        dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error = nil;
    
    NSDictionary *results = jsonData ? [NSJSONSerialization JSONObjectWithData:jsonData
                                                                       options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves
                                                                         error:&error]: nil;
    
    if (error) NSLog(@"[%@ %@] JSON error: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), error.localizedDescription);

    
    return results;
}

+ (NSDictionary *)getPhotosPage:(NSInteger)page pageSize:(NSInteger)pageSize
{
    NSString *request = [NSString stringWithFormat:@"http://api.tumblr.com/v2/blog/pitchersandpoets.tumblr.com/posts/photo?api_key=fuiKNFp9vQFvjLNvx4sUwti4Yb5yGutBN4Xh10LXZhhRKjWlV4&limit=%ld&offset=%ld", (long)pageSize, (long)page*pageSize];
    
    return [self executeFetch:request];
}

@end
