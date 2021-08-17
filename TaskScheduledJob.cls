/**
 * Created by Elena on 09.08.2021.
 */

global with sharing class TaskScheduledJob implements Schedulable {

    global void execute(SchedulableContext ctx) {
        TaskClass3 batch1 = new TaskClass3();
        Id batchId1 = Database.executeBatch(batch1);
        TaskClass4 batch2 = new TaskClass4();
        Id batchId2 = Database.executeBatch(batch2);
    }
}