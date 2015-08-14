//
//  ACServerManager.m
//  IFootPathApp
//
//  Created by Artem Chaykovsky on 05.07.15.
//
//

#import "ACServerManager.h"
#import "ACWalk.h"
#import "ACDataManager.h"

@interface ACServerManager()


@property (strong, nonatomic) NSMutableArray* walksArray;

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


-(void) getDataFromServer { 

    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];

    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    NSURL *url = [NSURL URLWithString:@"http://www.ifootpath.com/API/get_walks.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    [request setHTTPMethod:@"POST"];
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (![[NSThread currentThread] isMainThread]) {
            NSLog(@"Not main thread");
        }
        
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
        NSArray *responseArray = [jsonArray valueForKey:@"walks"];
        
        [[ACDataManager sharedManager] deleteAllWalksFromPlist];
    
        for (NSDictionary* dict in responseArray) {
            ACWalk* walk = [[ACWalk alloc] initWithResponse:dict];
            [[ACDataManager sharedManager]saveToPlist:walk];
}
        [[ACDataManager sharedManager] loadFromPlist];
        
        
    }];
    
    [postDataTask resume];
    
}

@end
