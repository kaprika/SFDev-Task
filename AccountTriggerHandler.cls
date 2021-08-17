/**
 * Created by Elena on 09.08.2021.
 */

public with sharing class AccountTriggerHandler {
    public static Boolean isRun = false;

    public static void handleBeforeInsert(List<Account> newList) { }


    public static void handleBeforeUpdate(List<Account> newList, Map<Id, Account> newMap, List<Account> oldList, Map<Id, Account> oldMap) {
        List<Id> listAccountId = AccountHelper.getAccountsIdInWhichBillingAddressChanged(newList, oldMap);
     //   AccountHelper.updateRelatedContacts(listAccountId);
     //   AccountHelper.callQueueableJob(listAccountId);
    }


    public static void handleBeforeDelete(List<Account> oldList, Map<Id, Account> oldMap) {}


    public static void handleAfterInsert(List<Account> newList, Map<Id, Account> newMap){
        if(!isRun) {
            isRun = true;
            AccountHelper.logSomething(newList);
        }
        List<Id> accountsId = new List<Id>(newMap.keySet());
        AccountHelper.createTask(accountsId);
    }


    public static void handleAfterUpdate(List<Account> newList, Map<Id, Account> newMap, List<Account> oldList, Map<Id, Account> oldMap){
    }


    public static void handleAfterDelete(List<Account> oldList, Map<Id, Account> oldMap){}


    public static void handleAfterUndelete(List<Account> newList, Map<Id, Account> newMap){}

}