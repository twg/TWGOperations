//
//  GoogleImageDownloadOperation.m
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2015-11-05.
//  Copyright © 2015 Nicholas Kuhne. All rights reserved.
//

#import "GoogleImageDownloadOperation.h"
#import "GETOperation.h"

static const NSString *GoogleImageBaseURL = @"https://ajax.googleapis.com/ajax/services/search/images?v=2.0&q=";

@interface GoogleImageDownloadOperation () <TWGOperationDelegate>

@property (nonatomic, strong) GETOperation *searchRequest;
@property (nonatomic, strong) GETOperation *imageRequest;

@end

@implementation GoogleImageDownloadOperation

- (instancetype)init
{
    GETOperation *searchRequest = [[GETOperation alloc] init];
    GETOperation *imageRequest = [[GETOperation alloc] init];
    
    [imageRequest addDependency:searchRequest];
    
    self = [super initWithOperations:@[searchRequest, imageRequest]];
    if(self) {
        
        self.searchRequest = searchRequest;
        self.searchRequest.delegate = self;
        
        self.imageRequest = imageRequest;
        self.imageRequest.delegate = self;
    }
    
    return self;
}

- (void)setSearchString:(NSString *)searchString
{
    _searchString = searchString;
    self.searchRequest.url = [GoogleImageDownloadOperation urlForSearchString:searchString];
}

#pragma mark TWGOperationDelegate

- (void)operation:(TWGOperation *)operation didCompleteWithResult:(id)result
{
    if(operation == self.searchRequest) {
        if([result isKindOfClass:[NSData class]]) {
            NSData *data = (NSData *)result;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSArray *results = dict[@"responseData"][@"results"];
            NSDictionary *imageDict = [results firstObject];
            
            NSString *url = imageDict[@"url"];
            if(url) {
                self.imageRequest.url = [NSURL URLWithString:url];
            }
        }
        
    }
    else if (operation == self.imageRequest) {
        if([result isKindOfClass:[NSData class]]) {
            NSData *data = (NSData *)result;
            [self finishWithResult:[UIImage imageWithData:data]];
        }
    }
}

- (void)operation:(TWGOperation *)operation didFailWithError:(NSError *)error
{
    [self finishWithError:error];
}


#pragma mark Static methods

+ (NSURL *)urlForSearchString:(NSString *)searchString
{
    NSString *escapedString = [searchString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    NSString *queryString = [NSString stringWithFormat:@"%@%@", GoogleImageBaseURL, escapedString];
    return [NSURL URLWithString:queryString];
}


+ (instancetype)imageDownloadOperationWithSearchString:(NSString *)searchString
{
    GoogleImageDownloadOperation *operation = [[[self class] alloc] init];
    operation.searchString = searchString;
    return operation;
}

@end
