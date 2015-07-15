//
//  ACServerManager.m
//  IFootPathApp
//
//  Created by Artem Chaykovsky on 05.07.15.
//
//

#import "ACServerManager.h"
#import "ACWalk.h"
#import "WalksEntity.h"
#import <AFNetworking.h>

@interface ACServerManager()

@property (strong, nonatomic) AFHTTPRequestOperationManager* requestOperationManager;


@end

@implementation ACServerManager

+ (ACServerManager*) sharedManager {
    
    static ACServerManager* manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ACServerManager alloc] init];
    });
    return manager;
}

- (id)init
{
    self = [super init];
    if (self) {
        
        self.requestOperationManager = [[AFHTTPRequestOperationManager alloc] init];
        
        NSMutableSet *contentTypes = [[NSMutableSet alloc] initWithSet:self.requestOperationManager.responseSerializer.acceptableContentTypes];
        [contentTypes addObject:@"text/html"];
        self.requestOperationManager.responseSerializer.acceptableContentTypes = contentTypes;
    }
    return self;
}

- (void) getDataFromServerOnURL:(NSString*) url {
    
    [self.requestOperationManager
     POST:url
     parameters:nil
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         
         [[ACCoreDataManager sharedManager] deleteAllObjects];
         NSArray *responseArray = [responseObject objectForKey:@"walks"];
         
         for (NSDictionary* dict in responseArray) {

             ACWalk* walk = [[ACWalk alloc] initWithResponse:dict];
                 [[ACCoreDataManager sharedManager] addToCoreData:walk];
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
     }
         
     ];
}




@end
