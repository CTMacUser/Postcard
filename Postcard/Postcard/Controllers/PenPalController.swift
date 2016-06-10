//
//  PenPalController.swift
//  Postcard
//
//  Created by Adelita Schule on 5/13/16.
//  Copyright © 2016 operatorfoundation.org. All rights reserved.
//

import Cocoa
import GoogleAPIClientForREST

class PenPalController: NSObject
{
    func getPenPalEmails(completionHandler:() -> Void)
    {
        let appDel: AppDelegate = NSApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext = appDel.managedObjectContext
        
        let request = NSFetchRequest(entityName: "PenPal")
        var results: [AnyObject]? = nil
        do{
            results = try managedObjectContext.executeFetchRequest(request)
        }
        catch{
            fatalError("Failed to fetch penpals: \(error)\n")
        }
        if let penPals = results as? [NSManagedObject]
        {
            for penPal in penPals
            {
                let thisPal = penPal as! PenPal
                if let email = thisPal.email
                {
                    PostCardProps.penPalEmailSet.insert(email)
                }
            }
        }
        completionHandler()
        print("This is my penpal email set: \n")
        print(PostCardProps.penPalEmailSet)
    }
    
    func getGoogleContacts()
    {
        let service  = GTLRPeopleService()
        let query = GTLRPeopleQuery_PeopleConnectionsList.queryWithResourceName("people/me")
        service.executeQuery(query, completionHandler: { (ticket, response, error) in
            //Do we have friends??
            if let response:GTLRPeopleQuery_PeopleConnectionsList = response as? GTLRPeopleQuery_PeopleConnectionsList
            {
                
            }
            else if let error = error
            {
                print(error)
            }
            
        })
        
    }
    
    
}
