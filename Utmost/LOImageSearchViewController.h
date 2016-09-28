//
//  LOImageSearchViewController.h
//

#import <UIKit/UIKit.h>

@protocol LOImageSearchViewControllerDelegate <NSObject>
- (void)didSelectImage:(NSString *)imageURL;
@end

@interface LOImageSearchViewController : UIViewController
@property (weak, nonatomic) id<LOImageSearchViewControllerDelegate> delegate;
@property (nonatomic, strong) NSString *imageQueryString;
@end
