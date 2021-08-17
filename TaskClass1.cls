/**
 * Created by Elena on 09.08.2021.
 */

public with sharing class TaskClass1 {

    @Future
    public static void getAccounts() {

        List<Account> accounts = [
                SELECT Id, (SELECT Id, Is_Synced__c, Processed_By_Future__c FROM Contacts)
                FROM Account
                WHERE BillingCity != '' OR BillingCountry != '' OR BillingPostalCode != ''
                LIMIT 150
        ];

        List<Contact> contacts = new List<Contact>();
        for (Account account : accounts) {
            for (Contact contact : account.Contacts) {
                contact.Is_Synced__c = false;
                contact.Processed_By_Future__c = true;
                contacts.add(contact);
            }
        }

        update contacts;

    }
}