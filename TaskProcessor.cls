/**
 * Created by Elena on 09.08.2021.
 */

public with sharing class TaskProcessor implements Database.Batchable<SObject> {

        public Database.QueryLocator start(Database.BatchableContext bc) {
            return Database.getQueryLocator(
                    'SELECT ID, Name, Updated_By_Task__c, ' +
                            '(SELECT Id, Is_Synced__c, Account_Owner__c FROM Tasks WHERE Is_Synced__c = false) ' +
                            'FROM Account'
            );
        }

        public void execute(Database.BatchableContext bc, List<Account> scope){
            List<Task> tasks = new List<Task>();

            for (Account account : scope) {
                for (Task task : account.Tasks) {
                    task.Is_Synced__c = true;
                    task.Account_Owner__c = account.Name;
                    tasks.add(task);
                }
                account.Updated_By_Task__c = true;
            }

            update tasks;
            update scope;

        }

        public void finish(Database.BatchableContext bc){
            // execute any post-processing operations
        }

}

