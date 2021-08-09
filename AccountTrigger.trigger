/**
 * Created by Elena on 09.08.2021.
 */

trigger AccountTrigger on Account (after insert, before update) {

        AccountTriggerHandler handler = new AccountTriggerHandler(new AccountTriggerHandlerMeth());


        if (Trigger.isInsert && Trigger.isAfter) {
                handler.OnAfterInsert(Trigger.New);
        }

        if (Trigger.isUpdate && Trigger.isBefore) {
                handler.OnBeforeUpdate(Trigger.new, Trigger.oldMap);
        }
}

