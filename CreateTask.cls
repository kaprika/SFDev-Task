/**
 * Created by Elena on 02.08.2021.
 */

public with sharing class CreateTask {

    @InvocableMethod (label = 'Create Task')
    public static void createTask(List<Id> accountId) {
        Task task = new Task();
        List<Account> listAccounts = [SELECT Name FROM Account WHERE Id = :accountId.get(0)];

        task.WhatId = accountId.get(0);
        task.Description = 'Negotiations with ' + listAccounts.get(0).Name;
        task.Subject = 'Email';
        task.Priority = 'Normal';
        task.Status = 'Not Started';

        upsert task;
    }

}