/**
 * Created by Elena on 09.08.2021.
 */

trigger AccountTrigger on Account (
        before insert,
        before update,
        before delete,
        after insert,
        after update,
        after delete,
        after undelete) {

        if (Trigger.isBefore && Trigger.isInsert) {
                //Trigger.new
        }

        if (Trigger.isBefore && Trigger.isUpdate) {
                AccountTriggerHandler.handleBeforeUpdate(Trigger.new, Trigger.newMap, Trigger.old, Trigger.oldMap);
        }

        if (Trigger.isBefore && Trigger.isDelete) {
               //Trigger.old, Trigger.oldMap
        }

        if (Trigger.isAfter && Trigger.isInsert) {
                AccountTriggerHandler.handleAfterInsert(Trigger.New, Trigger.newMap);
        }

        if (Trigger.isAfter && Trigger.isUpdate) {
                //Trigger.new, Trigger.newMap, Trigger.old, Trigger.oldMap
        }

        if (Trigger.isAfter && Trigger.isDelete) {
                //Trigger.old, Trigger.oldMap
        }

        if (Trigger.isAfter && Trigger.isUndelete) {
                //Trigger.new, Trigger.newMap
        }
}

