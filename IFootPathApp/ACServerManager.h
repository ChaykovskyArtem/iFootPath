//
//  ACServerManager.h
//  IFootPathApp
//
//  Created by Artem Chaykovsky on 05.07.15.
//
//

#import <Foundation/Foundation.h>
#import "ACCoreDataManager.h"

@interface ACServerManager : NSObject

+ (ACServerManager*) sharedManager;

-(void) getDataFromServer;

@end
