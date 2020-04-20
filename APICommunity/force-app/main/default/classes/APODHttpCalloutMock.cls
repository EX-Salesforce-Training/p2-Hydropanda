@isTest
public class APODHttpCalloutMock implements HttpCalloutMock {
    public HttpResponse respond(HttpRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        String endpoint = request.getEndpoint();
        if (endpoint == 'https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&hd=true&date='
            + Date.today().year() + '-' + Date.today().month() + '-' + Date.today().day()) {
            response.setBody('{"date":"1995-06-16","explanation":"Today\'s Picture:    Explanation:  If the Earth could somehow be transformed to the ultra-high density of a neutron star , it might appear as it does in the above computer generated figure. Due to the very strong gravitational field, the neutron star distorts light from the background sky greatly. If you look closely, two images of the constellation Orion are visible. The gravity of this particular neutron star is so great that no part of the neutron star is blocked from view - light is pulled around by gravity even from the back of the neutron star.   We keep an  archive file.  Astronomy Picture of the Day is brought to you by  Robert Nemiroff and  Jerry Bonnell . Original material on this page is copyrighted to Robert Nemiroff and Jerry Bonnell.","hdurl":"https://apod.nasa.gov/apod/image/e_lens.gif","media_type":"image","service_version":"v1","title":"Neutron Star Earth","url":"https://apod.nasa.gov/apod/image/e_lens.gif"}');
            response.setStatusCode(200);
        } else if (endpoint == '') {
            system.debug('');
        } else if (endpoint == '') {
            system.debug('');
        } else if (endpoint == '') {
            system.debug('');
        }
        return response;
    }
}