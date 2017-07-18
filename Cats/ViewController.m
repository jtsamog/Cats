//
//  ViewController.m
//  Cats
//
//  Created by Endeavour2 on 7/17/17.
//  Copyright © 2017 SamOg. All rights reserved.
//

#import "ViewController.h"
#import "Photo.h"
#import "CatsViewCell.h"
#import "DetailViewController.h"
#import "ApiKeys.h"

@interface ViewController ()<UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *catPhotos;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.collectionView.dataSource = self;
  [self createDataFromFlickrAPI];
  
}
- (void)createDataFromFlickrAPI {
  
  self.catPhotos = [[NSMutableArray alloc] init];
  
  // 1. Create a new NSURL object from the url string.
  NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=%@&tags=cat",FLICKR_APIKEY]];
  
  NSURLRequest *urlRequest = [[NSURLRequest alloc]initWithURL:url];
  
  NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
  
  NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
  
  NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    
    if (error) {
      NSLog(@"error: %@", error.localizedDescription);
      return ;
    }
    NSError *jsonError = nil;
    NSDictionary *jsonData = [ NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
    
    if (jsonError) {
      NSLog(@"jsonError: %@", jsonError.localizedDescription);
      return;
    }
    
    
    for (NSDictionary *info in jsonData[@"photos"][@"photo"]) { //using fast enumeration
      [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        Photo *photo = [[Photo alloc] initWithInfo:info];
        
        [self.catPhotos addObject:photo];
        
        [self.collectionView reloadData];
        
      }];
    }
  }];
  
  //6. A task is created in a suspended state, so we need to resume it
  [dataTask resume];
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
  return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
  return self.catPhotos.count;
  
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
  CatsViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
  
  Photo *photo = self.catPhotos[indexPath.row];
  NSData *imgData = [[NSData alloc]initWithContentsOfURL:photo.url];
  cell.imageViewCell.image = [UIImage imageWithData:imgData];
  cell.titleLabel.text = photo.urlTitle;
  
  
  return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"DetailViewController"]) {
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
    Photo *photo = self.catPhotos[indexPath.row];
    DetailViewController *dvc = [segue destinationViewController];
    dvc.photo = photo;
  }
  
}


@end
