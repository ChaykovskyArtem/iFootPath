//
//  ACMainViewContoller.h
//  IFootPathApp
//
//  Created by Artem Chaykovsky on 05.07.15.
//
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@protocol previewCellDelegate;

@interface ACMainViewContoller : UITableViewController <previewCellDelegate>

@property (strong,nonatomic) NSMutableArray* plistArray;
    
@end
