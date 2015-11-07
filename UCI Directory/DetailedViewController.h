//
//  DetailedViewController.h
//  UCI Directory
//
//  Created by 夏目夏樹 on 11/6/15.
//
//

#import <UIKit/UIKit.h>

@interface DetailedViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    NSDictionary *detail;
    UITableView *detailTableView;
}

- (id)initWithDetail:(NSDictionary *)theDetail;

@end
