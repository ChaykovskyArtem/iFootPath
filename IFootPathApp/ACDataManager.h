//
//  ACDataManager.h
//  IFootPathApp
//
//  Created by Artem Chaykovsky on 10.08.15.
//
//

#import <Foundation/Foundation.h>
#import "ACWalk.h"
@interface ACDataManager : NSObject

@property (strong, nonatomic) NSString *plistPath;
@property (strong,nonatomic) NSMutableArray* walksArray;



+ (ACDataManager*) sharedManager;

-(void) saveToPlist:(ACWalk*)walk;
-(NSArray*) loadFromPlist;
-(void) deleteAllWalksFromPlist;
-(void)deleteWalkFromPlist:(ACWalk *)walk;
-(void) changeValueOfObject:(ACWalk*)walkObject withText:(NSString*)text forKey:(NSString*)key;

@end
