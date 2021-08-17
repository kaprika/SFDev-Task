/**
 * Created by Elena on 16.08.2021.
 */

@IsTest
public with sharing class AccountTriggerTest {
    private static final String SUBJECT = 'Email';
    private static final String PRIORITY = 'Normal';
    private static final String STATUS = 'Not Started';


    @IsTest
    static void afterInsertTriggerExecutedOnceTest() {
        List<Account> accountList = TestDataFactory.createDummyListOfAccounts(3,'Stone', false);

        Test.startTest();
        insert accountList.get(0);
        insert accountList.get(1);
        insert accountList.get(2);
        Test.stopTest();

        Integer expectedCounter = 1;
        System.assertEquals(expectedCounter, AccountHelper.counter);
    }


    @IsTest
    static void handleAfterInsertCreateTaskTest() {
        Account account = TestDataFactory.createDummyAccount('Stone', false);

        Test.startTest();
        insert account;
        Test.stopTest();

        Task actualTask = [SELECT WhatId, Is_Synced__c, Description, Subject, Priority, Status FROM Task WHERE WhatId = :account.Id LIMIT 1];
        System.assertEquals(false, actualTask.Is_Synced__c);
    }


    @IsTest
    static void handleBeforeUpdateTest() {
        List<Account> accounts = TestDataFactory.createDummyListOfAccountsWithContacts(2, 2);
        accounts.get(0).BillingCountry = 'Russia';
        accounts.get(1).Name = 'New Name';

        Test.startTest();
        update accounts;
        Test.stopTest();

        List<Contact> actualContacts = [
                SELECT Is_Synced__c, Processed_By_Queue__c, Processed_By_Future__c
                FROM Contact
                WHERE AccountId = :accounts.get(0).Id
        ];

        Integer expectedSize = 2;
        System.assertEquals(expectedSize, actualContacts.size());
        for (Integer i = 0; i < 2; i++) {
            System.assertEquals(false, actualContacts.get(i).Is_Synced__c);
            System.assertEquals(true, actualContacts.get(i).Processed_By_Queue__c);
            System.assertEquals(true, actualContacts.get(i).Processed_By_Future__c);
        }

        actualContacts = [
                SELECT Is_Synced__c, Processed_By_Queue__c, Processed_By_Future__c
                FROM Contact
                WHERE AccountId = :accounts.get(1).Id
        ];
        for (Integer i = 0; i < 2; i++) {
            System.assertEquals(true, actualContacts.get(i).Is_Synced__c);
            System.assertEquals(false, actualContacts.get(i).Processed_By_Queue__c);
            System.assertEquals(false, actualContacts.get(i).Processed_By_Future__c);
        }
    }


    @IsTest
    static void callBatchJobForTasksTest() {
        List<Account> accounts = TestDataFactory.createDummyListOfAccounts(5, 'Stone', true);

        Test.startTest();
        AccountHelper.callBatchJobForTasks();
        Test.stopTest();

        List<Account> actualAccounts = [ SELECT Name, Updated_By_Task__c, (SELECT Account_Owner__c, Is_Synced__c FROM Tasks) FROM Account];

        for (Account account : actualAccounts) {
            for (Task task : account.Tasks) {
                System.assertEquals(account.Name, task.Account_Owner__c);
                System.assertEquals(true, task.Is_Synced__c);
            }
            System.assertEquals(true, account.Updated_By_Task__c);
        }
    }
}