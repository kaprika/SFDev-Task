/**
 * Created by Elena on 16.08.2021.
 */

@RestResource(urlMapping='/Account/*')
global with sharing class AccountManager {


    @HttpGet
    global static Account getAccountById() {
        RestRequest request = RestContext.request;
        String accountId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);

        Account result =  [SELECT Name, Phone, BillingState FROM Account WHERE Id = :accountId];

        return result;
    }


    @HttpPost
    global static ID createAccount(String name, String phone, String billingState) {
        Account account = new Account(Name = name, Phone = phone, BillingState = billingState);

        insert account;

        return account.Id;
    }


    @HttpDelete
    global static void deleteAccount() {
        RestRequest request = RestContext.request;
        String accountId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);

        Account account = [SELECT Id FROM Account WHERE Id = :accountId];

        delete account;
    }


    @HttpPut
    global static ID upsertAccount(String Id, String name, String phone, String billingState) {
        Account account = new Account(Id = id, Name = name, Phone = phone, BillingState = billingState);

        upsert account;

        return account.Id;
    }


    @HttpPatch
    global static ID updateAccountFields() {
        RestRequest request = RestContext.request;
        String accountId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);

        Account account = [SELECT Id FROM Account WHERE Id = :accountId];

        Map<String, Object> fields = (Map<String, Object>)JSON.deserializeUntyped(request.requestbody.toString());
        for(String fieldName : fields.keySet()) {
            account.put(fieldName, fields.get(fieldName));
        }

        update account;
        return account.Id;
    }
}
