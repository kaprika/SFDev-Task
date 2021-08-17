/**
 * Created by Elena on 16.08.2021.
 */

@IsTest
private class CreateAssignTaskTest {
    @IsTest
    static void createTaskTest() {
        Account account = TestDataFactory.createDummyAccount('Stone', true);
        List<Id> accountId = new List<Id>();
        accountId.add(account.Id);

        Test.startTest();
        CreateTask.createTask(accountId);
        Test.stopTest();

        Task task = [SELECT WhatId, Description, Subject, Priority, Status FROM Task LIMIT 1];
        System.assertNotEquals(null, task);
        System.assertEquals(account.Id, task.WhatId);
        System.assertEquals('Negotiations with ' + account.Name, task.Description);
        System.assertEquals('Email', task.Subject);
        System.assertEquals('Normal', task.Priority);
        System.assertEquals('Not Started', task.Status);
    }


    @IsTest
    static void assignTasksTest() {
        List<Account> accounts = TestDataFactory.createDummyListOfAccountsWithTasks(1, 4);
        Map<Id, Account> mapAccount = new Map<Id, Account>(accounts);
        List<Id> accountId = new List<Id>(mapAccount.keySet());

        TestDataFactory.createDummyListOfActiveUsers(5, true);

        Test.startTest();
        AssignTasks.assignTasks(accountId);
        Test.stopTest();

        List<Task> tasks = [SELECT OwnerId FROM Task];
        Id userId = tasks.get(0).OwnerId;
        for (Task task : tasks) {
            System.assertEquals(userId, task.OwnerId);
        }
    }
}