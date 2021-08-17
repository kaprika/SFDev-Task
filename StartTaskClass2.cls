/**
 * Created by Elena on 09.08.2021.
 */

public with sharing class StartTaskClass2 {

    public static void start(){
        List<Account> accounts = [SELECT Id, (SELECT Id, Is_Synced__c, Processed_By_Queue__c FROM Contacts)
                                                  FROM Account WHERE BillingCity != '' OR BillingCountry != '' OR BillingPostalCode != ''];
        System.enqueueJob(new TaskClass2(accounts));
    }

}