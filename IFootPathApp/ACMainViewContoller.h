//
//  ACMainViewContoller.h
//  IFootPathApp
//
//  Created by Artem Chaykovsky on 05.07.15.
//
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface ACMainViewContoller : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong,nonatomic) NSMutableArray* plistArray;

@end
