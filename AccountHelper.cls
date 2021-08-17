/**
 * Created by Elena on 09.08.2021.
 */

public with sharing class AccountHelper {
    public static Integer counter = 0;


    public static void logSomething(Account[] accounts){
        System.debug('Trigger is run');
        counter++;
    }


    public static List<Id> getAccountsIdInWhichBillingAddressChanged(List<Account> updatedAccount, Map<Id, Account> oldMap) {
        List<Id> listAccountId = new List<Id>();
        for (Account account : updatedAccount) {
            if (account.BillingCountry != oldMap.get(account.Id).BillingCountry) {
                listAccountId.add(account.Id);
            }
        }
        return listAccountId;
    }


   @Future
    public static void createTask(List<Id> accountId){
        List<Task> tasks = new List<Task>();
        for (Id id : accountId) {
            Task task = new Task();
            task.Is_Synced__c = false;
            task.Subject = 'Email';
            task.Priority = 'Normal';
            task.Status = 'Not Started';
            task.WhatId = id;
            tasks.add(task);
        }

        upsert tasks;
    }


    @Future
    public static void updateRelatedContacts(List<Id> listAccountId){
        List<Contact> contacts = [SELECT Is_Synced__c, Processed_By_Future__c FROM Contact WHERE AccountId IN :listAccountId];
        for (Contact contact : contacts){
            contact.Is_Synced__c = false;
            contact.Processed_By_Future__c = true;
        }

        update contacts;
    }


    public static void callQueueableJob(List<Id> listAccountId){
        UpdateRelatedContacts updateJob = new UpdateRelatedContacts(listAccountId);
        ID jobID = System.enqueueJob(updateJob);
    }


    public static void callBatchJobForTasks(){
        TaskProcessor taskProcessor = new TaskProcessor();
        Id batchId = Database.executeBatch(taskProcessor);
    }


    public static void callBatchJobContactForContacts(){
        ContactProcessor contactProcessor = new ContactProcessor();
        Id batchId = Database.executeBatch(contactProcessor);
    }
}
