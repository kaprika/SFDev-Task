/**
 * Created by Elena on 02.08.2021.
 */

public with sharing class AssignTasks {

    @InvocableMethod ( label = 'Assign Tasks')
    public static void assignTasks(List<Id> accountId) {

        List<Task> listTasks = [SELECT Id FROM Task WHERE WhatId = :accountId.get(0)];

        if (listTasks.size() > 3) {
            List<User> listUser = [SELECT Id FROM User WHERE IsActive = TRUE];
            if (!listUser.isEmpty()) {
                Integer randomUser = (Integer)(Math.random()*listUser.size());
                for(Task task : listTasks) {
                    task.OwnerId = listUser.get(randomUser).Id;
                }

                upsert listTasks;
            }
        }
    }
}