//
//  GoogleImageDownloadOperation.m
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2015-11-05.
//  Copyright © 2015 Nicholas Kuhne. All rights reserved.
//

#import "GoogleImageDownloadOperation.h"

static const NSString *GoogleImageBaseURL = @"https://ajax.googleapis.com/ajax/services/search/images?v=2.0&q=";

@interface GoogleImageDownloadOperation ()

@property (nonatomic, strong) TWGGETOperation *searchRequest;
@property (nonatomic, strong) TWGGETOperation *imageRequest;

@end

@implementation GoogleImageDownloadOperation

- (instancetype)init
{
    self.searchRequest = [[TWGGETOperation alloc] init];
    self.imageRequest = [[TWGGETOperation alloc] init];
 
    __weak typeof(self) weakSelf = self;
    
    [self.searchRequest setOperationCompletionBlock:^(id data, NSError *error) {
        
        if(data) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSArray *results = dict[@"responseData"][@"results"];
            NSDictionary *imageDict = [results firstObject];
            
            NSString *url = imageDict[@"url"];
            if(url) {
                weakSelf.imageRequest.url = [NSURL URLWithString:url];
            }
            else {
                [weakSelf finishWithError:[NSError errorWithDomain:@"NotFound" code:404 userInfo:nil]];
            }
        }
        else {
            [weakSelf finishWithError:error];
        }
        
    }];
    
    [self.imageRequest setOperationCompletionBlock:^(id data, NSError *error) {
        
        if(data) {
            weakSelf.result = [UIImage imageWithData:data];
            [weakSelf finish];
        }
        else {
            [weakSelf finishWithError:error];
        }
    }];
    
    [self.imageRequest addDependency:self.searchRequest];
    
    self = [super initWithOperations:@[self.searchRequest, self.imageRequest]];
    if(self) {
        
    }
    
    return self;
}

- (void)setSearchString:(NSString *)searchString
{
    _searchString = searchString;
    self.searchRequest.url = [GoogleImageDownloadOperation urlForSearchString:searchString];
}


- (void) finishWithError:(NSError *)error
{
    self.error = error;
    [self finish];
}

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
