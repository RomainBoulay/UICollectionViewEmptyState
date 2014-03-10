//
//  UICollectionViewEmptyState.m
//  UICollectionViewEmptyState
//

#import <QuartzCore/QuartzCore.h>
#import "UICollectionViewEmptyState.h"


@implementation UICollectionViewEmptyState


#pragma mark - Setter
- (void)setNoResultPlaceholderView:(UIView *)noResultPlaceholderView {
    _noResultPlaceholderView = noResultPlaceholderView;
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.noResultPlaceholderView
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:0.5f
                                                      constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.noResultPlaceholderView
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:0.5f
                                                      constant:0]];
}


#pragma mark - Layout
- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSUInteger totalItems = [self.visibleCells count];
    
    if (!totalItems) {
        for (NSUInteger section = 0; section < self.numberOfSections; ++section) {
            totalItems += [self numberOfItemsInSection:section];
            
            if (totalItems)
                break;
        }
    }
    
    // view may already be animating
    BOOL animating = [self.noResultPlaceholderView.layer.animationKeys containsObject:@"opacity"];
    
    if (!animating && totalItems && self.noResultPlaceholderView.superview) {
        [self hideNoResultPlaceHolder];
    }
    else if (!animating && !self.noResultPlaceholderView.superview) {
        [self showNoResultPlaceHolder];
    }
}


- (void)showNoResultPlaceHolder {
    // show
    CGRect bounds = self.bounds;
    
    // always update bounds
    self.noResultPlaceholderView.frame = bounds;
    
    // add view
    if (self.noResultPlaceholderView.superview != self) {
        
        // pre-display
        if ([self.noResultPlaceholderDelegate
             respondsToSelector:@selector(collectionView:willAddEmptyStateOverlayView:animated:)])
        {
            [self.noResultPlaceholderDelegate collectionView:self
                                willAddEmptyStateOverlayView:self.noResultPlaceholderView
                                                    animated:!!self.showNoResultPlaceholderAnimationDuration];
        }
        
        // not visible, add
        self.noResultPlaceholderView.alpha = 0.0;
        [self addSubview:self.noResultPlaceholderView];
        
        __weak typeof(self)weakSelf = self;
        [UIView animateWithDuration:self.showNoResultPlaceholderAnimationDuration
                              delay:self.showNoResultPlaceholderAnimationDelay
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^
         {
             __strong __typeof(weakSelf)strongSelf = weakSelf;
             strongSelf.noResultPlaceholderView.alpha = 1.0;
             
         }
                         completion:^(BOOL finished) {
                             __strong __typeof(weakSelf)strongSelf = weakSelf;
                             if ([strongSelf.noResultPlaceholderDelegate
                                  respondsToSelector:@selector(collectionView:didAddEmptyStateOverlayView:)])
                             {
                                 [strongSelf.noResultPlaceholderDelegate collectionView:strongSelf
                                                            didAddEmptyStateOverlayView:strongSelf.noResultPlaceholderView];
                             }
                         }];
    }
}


- (void)hideNoResultPlaceHolder {
    if ([self.noResultPlaceholderDelegate
         respondsToSelector:@selector(collectionView:willRemoveEmptyStateOverlayView:animated:)])
    {
        [self.noResultPlaceholderDelegate collectionView:self
                         willRemoveEmptyStateOverlayView:self.noResultPlaceholderView
                                                animated:!!self.hideNoResultPlaceholderAnimationDuration];
    }
    
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:self.hideNoResultPlaceholderAnimationDuration
                          delay:self.hideNoResultPlaceholderAnimationDelay
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^
     {
         __strong __typeof(weakSelf)strongSelf = weakSelf;
         strongSelf.noResultPlaceholderView.alpha = 0.0;
     }
                     completion:^(BOOL finished) {
                         __strong __typeof(weakSelf)strongSelf = weakSelf;
                         [strongSelf.noResultPlaceholderView removeFromSuperview];
                         if ([strongSelf.noResultPlaceholderDelegate respondsToSelector:@selector(collectionView:didRemoveEmptyStateOverlayView:)]) {
                             [strongSelf.noResultPlaceholderDelegate collectionView:strongSelf
                                                     didRemoveEmptyStateOverlayView:strongSelf.noResultPlaceholderView];
                         }
                     }];
}


- (UIImageView*)setEmptyStateImageViewWithImage:(UIImage*)image
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeCenter;
    self.noResultPlaceholderView = imageView;
    return imageView;
}


@end
