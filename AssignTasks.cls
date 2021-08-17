/**
 * Created by Elena on 02.08.2021.
 */

public with sharing class AssignTasks {

    @InvocableMethod ( label = 'Assign Tasks')
    public static void assignTasks(List<Id> accountId) {
        List<Task> listTasks = new List<Task>();

        List<Account> accounts = [SELECT Id, (SELECT Id FROM Tasks) FROM Account];
        List<User> activeUsers = [SELECT Id FROM User WHERE IsActive = TRUE];

        if (!activeUsers.isEmpty()) {
            for (Account account : accounts) {
                if (account.Tasks.size() > 3) {
                    Integer randomUser = (Integer) (Math.random() * activeUsers.size());
                    for (Task task : account.Tasks) {
                        task.OwnerId = activeUsers.get(randomUser).Id;
                        listTasks.add(task);
                    }
                }
            }
        }
        update listTasks;
    }
}