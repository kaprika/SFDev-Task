/**
 * Created by Elena on 16.08.2021.
 */

@IsTest
private class ConnectFirstOrgTest {

    @IsTest
    static void postCalloutTest() {
        Test.setMock(HttpCalloutMock.class, new ConnectOrgHttpCalloutMock());

        HttpResponse response = ConnectFirstOrg.makePostCallout();

        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = '{"name": "Account NEW", "phone" : "80123456", "billingState" : "TX"}';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, response.getStatusCode());
    }
}