/**
 * Created by Elena on 16.08.2021.
 */

@IsTest
global class ConnectOrgHttpCalloutMock implements HttpCalloutMock {

    global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"name": "Account NEW", "phone" : "80123456", "billingState" : "TX"}');
        response.setStatusCode(200);
        return response;
    }
}