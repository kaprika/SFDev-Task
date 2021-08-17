/**
 * Created by Elena on 16.08.2021.
 */

public with sharing class ConnectFirstOrg {

    public static HttpResponse makePostCallout() {
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:SFDev/services/apexrest/Account/');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        String body = JSON.serialize(new Map<String, Object>{
                'name' => 'Account NEW',
                'phone' => '80123456',
                'billingState' => 'TX'
        });
        request.setBody(body);

        Http http = new Http();
        HttpResponse response;
        try {
            response = http.send(request);
        }
        catch(System.CalloutException e) {
            System.debug(e);
        }

        return response;
    }


    public static HttpResponse makeGetCallout(ID Id) {
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:SFDev/services/apexrest/Account/' + Id);
        request.setMethod('GET');

        Http http = new Http();
        HttpResponse response;
        try {
            response = http.send(request);
            Account account = (Account)JSON.deserialize(response.getBody(), Account.class);
            System.debug('Name: ' + account.Name + ' phone: ' + account.Phone + ' billingState: ' + account.BillingState);
        }
        catch(System.CalloutException e) {
            System.debug(e);
        }
        return response;
    }


    public static HttpResponse makeDeleteCallout(ID Id) {
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:SFDev/services/apexrest/Account/' + Id);
        request.setMethod('DELETE');

        Http http = new Http();
        HttpResponse response;
        try {
            response = http.send(request);
            System.debug(response.getStatus());
        } catch (System.CalloutException e) {
            System.debug(e);
        }
        return response;
    }


    public static HttpResponse makePutCallout(ID id) {
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:SFDev/services/apexrest/Account/');
        request.setMethod('PUT');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        String body = JSON.serialize(new Map<String, Object>{
                'Id' => id,
                'name' => 'New Name ',
                'phone' => '45612302',
                'billingState' => 'NC'
        });
        request.setBody(body);

        Http http = new Http();
        HttpResponse response;
        try {
            response = http.send(request);
            System.debug(response.getStatus());
        } catch (System.CalloutException e) {
            System.debug(e);
        }
        return response;
    }


    public static HttpResponse makePatchCallout(ID id) {
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:SFDev/services/apexrest/Account/' + id);
        request.setMethod('PATCH');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        String body = JSON.serialize(new Map<String, Object>{
                'name' => 'new name',
                'billingState' => 'NC'
        });
        request.setBody(body);

        Http http = new Http();
        HttpResponse response;
        try {
            response = http.send(request);
            System.debug(response.getBody());
        }
        catch(System.CalloutException e) {
            System.debug(e);
        }
        return response;
    }

}