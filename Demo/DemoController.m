//
//  JCViewController.m
//  UICollectionViewEmptyState
//
//  Created by Jonathan Crooke on 14/05/2013.
//  Copyright (c) 2013 Jon Crooke. All rights reserved.
//

#import "DemoController.h"
#import "DemoCell.h"
#import "BlocksKit.h"

@interface DemoController ()
@property (strong, nonatomic) IBOutlet UIStepper *sectionStepper;
@property (strong, nonatomic) IBOutlet UIStepper *itemStepper;
@end

@implementation DemoController

- (void)viewDidLoad {
  [super viewDidLoad];

  __weak DemoController *weakSelf = self;
  [self.sectionStepper addEventHandler:^(id sender) {
    [weakSelf.collectionView reloadData];
  } forControlEvents:UIControlEventValueChanged];
  [self.itemStepper addEventHandler:^(id sender) {
    [weakSelf.collectionView reloadData];
  } forControlEvents:UIControlEventValueChanged];

  self.toolbarItems = @[
                        [[UIBarButtonItem alloc] initWithCustomView:self.sectionStepper],
                        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                        [[UIBarButtonItem alloc] initWithCustomView:self.itemStepper]
                        ];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return self.sectionStepper.value;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
  return self.itemStepper.value;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
  static NSDictionary *dict = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    dict = @{UICollectionElementKindSectionHeader : @"Header",
             UICollectionElementKindSectionFooter : @"Footer"};
  });

  return [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                            withReuseIdentifier:dict[kind]
                                                   forIndexPath:indexPath];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView 
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  DemoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DemoCell" forIndexPath:indexPath];

  static NSArray *images = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    images = @[@"bird-1368498135Eqm.jpg",
               @"chess.jpg",
               @"empire-state-building-1368498219KmC.jpg",
               @"goose-1368497908c6H.jpg",
               @"sun-1368498327ZH8.jpg"];
  });
  cell.imageView.image = [UIImage imageNamed:images[indexPath.section]];

  return cell;
}

@end
