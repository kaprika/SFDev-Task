/**
 * Created by Elena on 14.08.2021.
 */

@isTest
public class TestDataFactory {

    public static Account createDummyAccount(String name, Boolean needInsert) {
        Account account = new Account(Name = name);
        if (needInsert) {
            insert account;
        }
        return account;
    }


    public static List<Account> createDummyListOfAccounts(Integer count, String name, Boolean needInsert) {
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < count; i++) {
            accounts.add(createDummyAccount(name, false));
        }
        if (needInsert) {
            insert accounts;
        }
        return accounts;
    }


    public static List<Account> createDummyListOfAccountsWithTasks(Integer numAccounts, Integer numTasksPerAcct) {
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < numAccounts; i++) {
            Account a = new Account(Name='TestAccount' + i);
            accounts.add(a);
        }

        insert accounts;

        List<Task> tasks = new List<Task>();
        for (Account account : accounts) {
            for (Integer i = 0; i < numTasksPerAcct; i++) {
                tasks.add(new Task(WhatId = account.Id, Description = 'Negotiations with ' + account.Name,
                                   Subject = 'Email', Priority = 'Normal', Status = 'Not Started'));
            }
        }

        insert tasks;
        return accounts;
    }


    public static List<User> createDummyListOfActiveUsers(Integer count, Boolean needInsert) {
        List<User> users = new List<User>();
        for (Integer i = 0; i < count; i++) {
            users.add(new User(IsActive = true));
        }
        if (needInsert) {
            insert users;
        }
        return users;

    }


    public static List<Task> createDummyListOfTasks(Integer count, Id whatId, String description,
            String subject, String priority, String status, Boolean needInsert) {
        List<Task> tasks = new List<Task>();
        for (Integer i = 0; i < count; i++) {
            Task task = new Task();
            task.WhatId = whatId;
            task.Description = description;
            task.Subject = subject;
            task.Priority = priority;
            task.Status = status;
            tasks.add(task);
        }

        if (needInsert) {
            insert(tasks);
        }
        return tasks;
    }


    public static Task createDummyTask(Id whatId, String description, String subject, String priority, String status, Boolean needInsert) {
        Task task = new Task();
        task.WhatId = whatId;
        task.Description = description;
        task.Subject = subject;
        task.Priority = priority;
        task.Status = status;
        task.Is_Synced__c = false;
        if (needInsert) {
            insert(task);
        }
        return task;
    }


    public static List<Account> createDummyListOfAccountsWithContacts(Integer numAccounts, Integer numContactsPerAccount) {
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < numAccounts; i++) {
            Account account = new Account(Name='TestAccount' + i, BillingCountry = 'Belarus');
            accounts.add(account);
        }

        insert accounts;

        List<Contact> contacts = new List<Contact>();
        for (Integer i = 0; i < numAccounts; i++) {
            Account account = accounts.get(i);
            // For each account just inserted, add contacts
            for (Integer j = 0; j < numContactsPerAccount; j++) {
                contacts.add(new Contact(LastName = account.Name + ' Contact ' + j,
                                         AccountId = account.Id));
            }
        }
        insert contacts;

        return accounts;
    }


    //trailhead
    public static List<Account> createAccountsWithOpps(Integer numAccts, Integer numOppsPerAcct) {
        List<Account> accts = new List<Account>();

        for (Integer i = 0; i < numAccts; i++) {
            Account a = new Account(Name='TestAccount' + i);
            accts.add(a);
        }

        insert accts;

        List<Opportunity> opps = new List<Opportunity>();
        for (Integer j = 0; j < numAccts; j++) {
            Account acct = accts[j];
            // For each account just inserted, add opportunities
            for (Integer k = 0; k < numOppsPerAcct; k++) {
                opps.add(new Opportunity(Name=acct.Name + ' Opportunity ' + k,
                        StageName='Prospecting',
                        CloseDate=System.today().addMonths(1),
                        AccountId=acct.Id));
            }
        }
        // Insert all opportunities for all accounts.
        insert opps;

        return accts;
    }
}