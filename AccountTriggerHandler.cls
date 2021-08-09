/**
 * Created by Elena on 09.08.2021.
 */

public with sharing class AccountTriggerHandler {

    public static Boolean isRun = false;

    private AccountTriggerHandlerMeth handler;

    private static List<Account> accountsBillingAddress;

    private static List<Account> listAccount;

    public AccountTriggerHandler(AccountTriggerHandlerMeth handler){
        this.handler = handler;
    }

    public void OnAfterInsert(Account[] accounts){
        if(!isRun) {
            isRun = true;
            handler.function(accounts);
        }
        listAccount = accounts;
        createTask();
    }

    public void OnBeforeUpdate(Object[] updatedAccount, Map<Id, Object> oldMap) {
        selectAccount(updatedAccount, oldMap);
        selectRelatedContacts();
        callQueueableJob();
    }

    private void selectAccount(Object[] updatedAccount, Map<Id, Object> oldMap) {
        List<Account> listAccount = new List<Account>();
        for (Account account : (List<Account>) updatedAccount) {
            if (account.BillingAddress != ((Map<Id, Account>) oldMap).get(account.Id).BillingAddress) {
                listAccount.add(account);
            }
        }
        accountsBillingAddress = listAccount;
    }

    @Future
    public static void createTask(){

        List<Task> tasks = new List<Task>();
        for (Account account : listAccount) {
            Task task = new Task();
            task.Is_Synced__c = false;
            task.Subject = 'Email';
            task.Priority = 'Normal';
            task.Status = 'Not Started';
            task.WhatId = account.Id;
        }
        insert tasks;

        }

    @Future
    public static void selectRelatedContacts(){

        Map<Id, Account> mapAccount = new Map<Id, Account>(accountsBillingAddress);
        List<Id> listAccountId = new List<Id>(mapAccount.keySet());
        List<Contact> contacts = [SELECT Is_Synced__c, Processed_By_Future__c FROM Contact WHERE AccountId IN :listAccountId];
        for (Contact contact : contacts){
            contact.Is_Synced__c = false;
            contact.Processed_By_Future__c = true;
        }

        update contacts;

    }

    public static void callQueueableJob(){
        UpdateRelatedContacts updateJob = new UpdateRelatedContacts(accountsBillingAddress);
        ID jobID = System.enqueueJob(updateJob);
    }

    public static void callBatchJobTask(){
        TaskProcessor taskProcessor = new TaskProcessor();
        Id batchId = Database.executeBatch(taskProcessor);
    }

    public static void callBatchJobContact(){
        ContactProcessor contactProcessor = new ContactProcessor();
        Id batchId = Database.executeBatch(contactProcessor);
    }

}