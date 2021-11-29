/**
 * Created by Elena on 09.08.2021.
 */

public with sharing class TaskClass3 implements Database.Batchable<sObject> {

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
                'SELECT ID, BillingStreet, BillingCity, BillingState, BillingPostalCode, Updated_By_Contact__c,\n' +
                        '  (SELECT Id, MailingStreet, MailingCity, MailingState, MailingPostalCode, Is_Synced__c FROM Contacts WHERE Is_Synced__c = false) FROM Account'
        );
    }

    public void execute(Database.BatchableContext bc, List<Account> scope){

        List<Contact> contacts = new List<Contact>();

        for (Account account : scope) {
            for (Contact contact : account.contacts) {
                contact.MailingStreet = account.BillingStreet;
                contact.MailingCity = account.BillingCity;
                contact.MailingState = account.BillingState;
                contact.MailingPostalCode = account.BillingPostalCode;
                contact.Is_Synced__c = true;
                contacts.add(contact);
            }
            account.Updated_By_Contact__c = true;
        }

        update contacts;
        update scope;
    }

    public void finish(Database.BatchableContext bc){

    }

}