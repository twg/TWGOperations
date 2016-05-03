//
//  HomeViewController.m
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2016-04-29.
//  Copyright © 2016 Nicholas Kuhne. All rights reserved.
//

#import "HomeViewController.h"
@import TWGOperations;
#import "DownloadFlickrFeedOperation.h"
#import "FlickrPhoto.h"
#import "FlickrPhotoViewController.h"
#import "GETCacheOperation.h"
#import "PhotoThumbnailCell.h"

@interface HomeViewController ()

@property (nonatomic, strong) NSArray<FlickrPhoto *> *photos;
@property (nonatomic, strong) NSOperationQueue *operationQueue;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end

static NSString *CellReuseIdentifier = @"CellReuseIdentifier";

@implementation HomeViewController

- (instancetype)init
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumLineSpacing = flowLayout.minimumInteritemSpacing = 0.f;

    self = [super initWithCollectionViewLayout:flowLayout];
    if (self) {
        self.flowLayout = flowLayout;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.collectionView registerClass:[PhotoThumbnailCell class] forCellWithReuseIdentifier:CellReuseIdentifier];

    DownloadFlickrFeedOperation *operation = [[DownloadFlickrFeedOperation alloc] init];
    operation.presentingViewController = self;

    [operation completionOnMain:^(NSArray *photos) {
        self.photos = photos;
        [self.collectionView reloadData];
    }];

    [self.operationQueue addOperation:operation];
}

- (NSOperationQueue *)operationQueue
{
    if (_operationQueue == nil) {
        _operationQueue = [[NSOperationQueue alloc] init];
        _operationQueue.qualityOfService = NSQualityOfServiceUtility;
    }
    return _operationQueue;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.photos count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoThumbnailCell *cell =
        [collectionView dequeueReusableCellWithReuseIdentifier:CellReuseIdentifier forIndexPath:indexPath];

    FlickrPhoto *photo = [self.photos objectAtIndex:indexPath.item];
    UIImage *thumbnail = photo.thumbnail;

    if (!thumbnail) {
        GETCacheOperation *operaiton = [[GETCacheOperation alloc] init];
        operaiton.url = photo.thumbnailURL;

        [operaiton completionOnMain:^(NSData *photoData) {
            NSLog(@"Got thumbnail for photo ID:%@", photo.identifier);
            photo.thumbnail = [UIImage imageWithData:photoData];
            [collectionView reloadItemsAtIndexPaths:@[ indexPath ]];
        }];

        [self.operationQueue addOperation:operaiton];
    }
    else {
        cell.imageView.image = thumbnail;
    }

    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat squareSize = floor(CGRectGetWidth(self.view.frame) / 3);
    return CGSizeMake(squareSize, squareSize);
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    FlickrPhoto *photo = [self.photos objectAtIndex:indexPath.item];

    FlickrPhotoViewController *photoViewController =
        [[FlickrPhotoViewController alloc] initWithNibName:@"FlickrPhotoViewController" bundle:nil];
    photoViewController.photo = photo;

    [self.navigationController pushViewController:photoViewController animated:YES];
}

@end
