//
//  LOImageSearchViewController.m
//

#import "LOImageSearchViewController.h"
#import "LOImageSearchCollectionViewCell.h"
#import "SCGoogleSearch.h"
#import "SCGoogleImage.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface LOImageSearchViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate>
@property (nonatomic, strong) NSMutableArray *data;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UITextField *searchField;

@property (nonatomic, strong) SCGoogleSearch *search;

@end

@implementation LOImageSearchViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.data = [NSMutableArray array];
    self.search = [[SCGoogleSearch alloc]initWithKey:KEY2 withCx:CX2];
    self.searchField.text = self.imageQueryString;
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadPageOfImagesForSearchText:self.imageQueryString];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self loadPageOfImagesForSearchText:textField.text];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.searchField) {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)loadPageOfImagesForSearchText:(NSString *)searchText
{
    if (searchText) {
        [self.search loadPicturesWithName:searchText complition:^(NSArray<SCGoogleImage *> *objects, SCGooglePagination *pagination, NSError *failure) {
            self.data = [NSMutableArray arrayWithArray:objects];
            [self.collectionView reloadData];
        }];
    }
}

- (IBAction)loadNextPage:(id)sender {
    
    if (self.data.count > 0) {
        [self.search loadNextPageWithComplition:^(NSArray<SCGoogleImage *> *objects, SCGooglePagination *pagination, NSError *failure) {
            self.data = [NSMutableArray arrayWithArray:[self.data arrayByAddingObjectsFromArray:objects]];
            [self.collectionView reloadData];
        }];
    }
}

- (IBAction)closeView:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.data count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LOImageSearchCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    SCGoogleImage *image = [self.data objectAtIndex:indexPath.row];
    [cell.googleImage sd_setImageWithURL:[NSURL URLWithString:image.link]
                        placeholderImage:nil];
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    SCGoogleImage *image = [self.data objectAtIndex:indexPath.row];
    [self.delegate didSelectImage:image.link];
    
    [self closeView:nil];
}


- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"%lu",(unsigned long)self.data.count);
    //NSLog(@"%lu",(unsigned long)indexPath.row);

//    if (self.data.count == indexPath.row + 1) {
//        
//        [self.search loadNextPageWithComplition:^(NSArray<SCGoogleImage *> *objects, SCGooglePagination *pagination, NSError *failure) {
//            [self.data addObjectsFromArray:objects];
//            [self.collectionView reloadData];
//
//        }];
//    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)theCollectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)theIndexPath
{
    
    UICollectionReusableView *theView;
    
    if(kind == UICollectionElementKindSectionHeader)
    {
        theView = [theCollectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:theIndexPath];
    } else {
        theView = [theCollectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:theIndexPath];
    }
    
    return theView;
}


@end
