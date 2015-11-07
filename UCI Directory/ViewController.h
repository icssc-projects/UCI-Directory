//
//  ViewController.h
//  UCI Directory
//
//  Created by 夏目夏樹 on 11/6/15.
//
//

#import <UIKit/UIKit.h>
#import "DetailedViewController.h"

@interface ViewController : UIViewController <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate> {
    IBOutlet UISearchBar *searchBar;
    IBOutlet UITableView *searchResultsTableView;
    NSArray *typeaheadData;
    NSString *currentSearchTest; // Keep async data in sync.
}

@end

