//
//  ACMainViewContoller.m
//  IFootPathApp
//
//  Created by Artem Chaykovsky on 05.07.15.
//
//

#import "ACMainViewContoller.h"
#import "ACWalksPreviewCell.h"
#import "ACDetailsViewController.h"
#import <MBProgressHUD.h>
#import <CoreData/CoreData.h>
#import "ACCoreDataManager.h"
#import "ACServerManager.h"
#import "ACDataManager.h"


@interface ACMainViewContoller ()


@property (strong,nonatomic) MBProgressHUD *progressHud;


@end

@implementation ACMainViewContoller

static NSString* serverUrl = @"http://www.ifootpath.com/API/get_walks.php";



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                          target:self
                                                                          action:@selector(refreshWalksFromServer)];
    [self.navigationItem setRightBarButtonItem:item animated:YES];
    
    self.navigationItem.title = @"iFootPath walks";
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didGetMyNotification:)
                                                 name:@"loadFromPlistArray"
                                               object:nil];
    
        [[ACDataManager sharedManager] loadFromPlist];
    
    if ([self.tableView numberOfRowsInSection:0] == 0) {
        [self refreshWalksFromServer];
    }
    
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    ACWalk* walk = [self.plistArray objectAtIndex:indexPath.row];
    [[ACDataManager sharedManager] deleteWalkFromPlist:walk];
   
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
     [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}



 #pragma mark - Actions

- (void) refreshWalksFromServer {
   
    
    self.progressHud =[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.progressHud.mode = MBProgressHUDModeIndeterminate;
    self.progressHud.labelText = @"Loading";
    
        [[ACServerManager sharedManager] getDataFromServer];
}

#pragma mark - Notifications

-(void)didGetMyNotification:(NSNotification*)notification {
    
    self.plistArray = [notification object];
    NSSortDescriptor* descriptor = [[NSSortDescriptor alloc] initWithKey:@"walkTitle" ascending:NO];
    [self.plistArray sortedArrayUsingDescriptors:@[descriptor]];
    NSLog(@"Number of walks: %d", self.plistArray.count);
    [self.tableView reloadData];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [_progressHud hide:YES];
    });
    
}


#pragma mark - Images

-(UIImage*) imageFromRating: (NSString*) ratingString {
    
    float rating = [ratingString floatValue];
    
    if (rating >= 4.5) {
        return [UIImage imageNamed:@"Rating5"];
    } else
        if (rating >= 4 && rating < 4.5) {
        return [UIImage imageNamed:@"Rating4"];
    } else
        if (rating >= 3 && rating < 4) {
            return [UIImage imageNamed:@"Rating3"];
    } else
        if (rating >=2 && rating < 3) {
                return [UIImage imageNamed:@"Rating2"];
    }else
        if (rating >= 1 && rating < 2) {
            return [UIImage imageNamed:@"Rating1"];
    }
    return nil;
}
-(UIImage*) imageFromDifficalty: (NSString*) gradeString {
    
    float difficalty = [gradeString floatValue];
    if (difficalty == 5) {
        return [UIImage imageNamed:@"Difficulty5"];
    }else
        if (difficalty == 4) {
            return [UIImage imageNamed:@"Difficulty4"];
    }else
        if (difficalty == 3) {
            return [UIImage imageNamed:@"Difficulty3"];
    }else
        if (difficalty == 2) {
            return [UIImage imageNamed:@"Difficulty2"];
    }else
        if (difficalty == 1) {
           return [UIImage imageNamed:@"Difficulty1"];
        }
    
    return nil;
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
   return [self.plistArray count];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString* identifier = @"Cell";
    
    ACWalksPreviewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[ACWalksPreviewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
}
    
    ACWalk *walks = [self.plistArray objectAtIndex:indexPath.row];
    
    cell.title.text = walks.walkTitle;
    
    [cell.difficalty setImage:[self imageFromDifficalty:walks.walkGrade]];
    
 
    [walks getImageFromServerWithUrl:walks.walkIcon completionBlock:^(UIImage *image, NSError *error) {
        
        [cell.walkIcon setImage:image];
        
        if (!image) {
            
            NSLog(@"%@", error.description);
        }
    }];
    
    [cell.rating setImage:[self imageFromRating:walks.walkRating]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.indexPath = indexPath;
    cell.mainController = self;
    
    return cell;
}


#pragma mark - previewCellDelegate


-(void) viewWalkOnCell:(ACWalksPreviewCell*)cell {
    
    NSIndexPath* indexPath = cell.indexPath;
    
    ACWalk* walk = [self.plistArray objectAtIndex:indexPath.row];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    ACDetailsViewController* detailsViewController = [storyboard instantiateViewControllerWithIdentifier:@"identifier"];
    detailsViewController.walkEntity = walk;
    [self.navigationController pushViewController:detailsViewController animated:YES];

    }

-(void) deleteWalkOnCell:(ACWalksPreviewCell*)cell {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Walk was deleted" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    
    [alert show];
    
    NSIndexPath* indexPath = cell.indexPath;
    
    ACWalk* walk = [self.plistArray objectAtIndex:indexPath.row];
    
    [[ACDataManager sharedManager] deleteWalkFromPlist:walk];
}

-(void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


@end
