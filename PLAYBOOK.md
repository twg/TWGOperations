## Usage



### TWGOperation

A TWGOperation allows for subclasses to implement `- (void)execute` which will get called when the operation is run in an [NSOperationQueue](https://developer.apple.com/library/mac/documentation/Cocoa/Reference/NSOperationQueue_class/)


#### Subclass

```objective-c
@interface GETOperation : TWGOperation

@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSURLSession *session;

@end

@implementation GETOperation

- (void)execute
{
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    NSURLSessionDataTask *task = [self.session
        dataTaskWithRequest:request
          completionHandler:^(NSData *_Nullable data, NSURLResponse *_Nullable response, NSError *_Nullable error) {
              if (error) {
                  [self finishWithError:error];
              }
              else if (data) {
                  [self finishWithResult:data];
              }
          }];

    [task resume];
}

- (NSURLSession *)session
{
    if (_session == nil) {
        _session = [NSURLSession sharedSession];
    }
    return _session;
}

@end
```

```objective-c
GETOperation *operation = [[GETOperation alloc] init];
operation.url = [NSURL URLWithString:@"http://www.google.ca"];
	
[self.operationQueue addOperation:operation];
```


### Delegate
#### TWGOperationDelegate implementation

An Objective-C class can implement the methods in `TWGOperationDelegate` thus responding to the completion or failure of the `TWGOperation`

```objective-c
eg
```




### TWGGroupOperation subclass - dependancy
### TWGGroupOperation subclass - serialOperations

### TWGRetryOperation subclass
### TWGAlertOperation example
