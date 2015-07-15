//
//  ACMainViewContoller.m
//  IFootPathApp
//
//  Created by Artem Chaykovsky on 05.07.15.
//
//

#import "ACMainViewContoller.h"
#import "ACWalksPreviewCell.h"
#import "UIKit+AFNetworking.h"
#import "ACDetailsViewController.h"
#import <MBProgressHUD.h>
#import <CoreData/CoreData.h>
#import "ACCoreDataManager.h"
#import "ACServerManager.h"


@interface ACMainViewContoller ()

@property (strong, nonatomic) NSFetchedResultsController* fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext* managedObjectContext;
@property (strong,nonatomic) MBProgressHUD *progressHud;

@end

@implementation ACMainViewContoller

static NSString* serverUrl = @"http://www.ifootpath.com/API/get_walks.php";


- (NSManagedObjectContext*) managedObjectContext {
    
    if (!_managedObjectContext) {
        _managedObjectContext = [[ACCoreDataManager sharedManager] managedObjectContext];
    }
    return _managedObjectContext;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                          target:self
                                                                          action:@selector(refreshWalksFromServer)];
    [self.navigationItem setRightBarButtonItem:item animated:YES];
    
    self.navigationItem.title = @"iFootPath walks";
    
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections] [0];
    if ([sectionInfo numberOfObjects] == 0) {
        
        [self refreshWalksFromServer];
        
    }

}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
   id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* identifier = @"Cell";
    
    ACWalksPreviewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[ACWalksPreviewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ACDetailsViewController* viewController = [self.storyboard instantiateViewControllerWithIdentifier: @"identifier"];
    
    WalksEntity* entity = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    viewController.walkEntity = entity;

    [self.navigationController pushViewController:viewController animated:YES];
}



 #pragma mark - Actions

- (void) refreshWalksFromServer {
    
    self.progressHud =[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.progressHud.mode = MBProgressHUDModeIndeterminate;
    self.progressHud.labelText = @"Loading";

    [[ACServerManager sharedManager] getDataFromServerOnURL:serverUrl];
}


#pragma mark - Fetched results controller


- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* description =
    [NSEntityDescription entityForName:@"WalksEntity"
                inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:description];
    NSSortDescriptor* descriptor =
    [[NSSortDescriptor alloc] initWithKey:@"walkTitle" ascending:YES];
    
    
    [fetchRequest setSortDescriptors:@[descriptor]];
    [fetchRequest setFetchBatchSize:20];
    
    
    NSFetchedResultsController *aFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:self.managedObjectContext
                                          sectionNameKeyPath:nil
                                                   cacheName:@"cache"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _fetchedResultsController;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
       case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            
            break;
        case NSFetchedResultsChangeUpdate:
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
          [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
    
    [self.progressHud hide:YES];
}


- (void)configureCell:(ACWalksPreviewCell *)cell atIndexPath:(NSIndexPath *)indexPath {

    WalksEntity *walks = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.title.text = walks.walkTitle;
    [cell.difficalty setImage:[self imageFromDifficalty:walks.walkGrade]];
    
    NSString* typeString = [NSString stringWithFormat:@"Type: %@", walks.walkType];
    cell.typeLabel.text = typeString;
    
    NSString* countryString = [NSString stringWithFormat:@"Country: %@", walks.walkCountry];
    cell.countryLabel.text = countryString;
    
    NSURL* url = [NSURL URLWithString:walks.walkPhoto];
    
    [cell.walkIcon setImageWithURL:url];
    [cell.rating setImage:[self imageFromRating:walks.walkRating]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}



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
@end
