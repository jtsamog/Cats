//
//  DetailViewController.m
//  Cats
//
//  Created by Endeavour2 on 7/17/17.
//  Copyright © 2017 SamOg. All rights reserved.
//

#import "DetailViewController.h"
#import "Photo.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageViewDvc;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  NSData *imgData = [[NSData alloc]initWithContentsOfURL:[self.photo url]];
  self.imageViewDvc.image = [UIImage imageWithData:imgData];
  self.titleLabel.text = self.photo.urlTitle;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
