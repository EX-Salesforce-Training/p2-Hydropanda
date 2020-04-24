@isTest
public class APODHttpCalloutMock implements HttpCalloutMock {
    public HttpResponse respond(HttpRequest request) {
        system.debug(request);
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        String endpoint = request.getEndpoint();
        if (endpoint == 'https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&hd=true&date='
            + Date.today().year() + '-' + Date.today().month() + '-' + Date.today().day()) {
            response.setBody('{"copyright":"Miguel Claro","date":"2020-04-21","explanation":"Have you ever had stars in your eyes? It appears that the eye on the left does, and moreover it appears to be gazing at even more stars. The featured 27-frame mosaic was taken last July from Ojas de Salar in the Atacama Desert of Chile.  The eye is actually a small lagoon captured reflecting the dark night sky as the Milky Way Galaxy arched overhead. The seemingly smooth band of the Milky Way is really composed of billions of stars, but decorated with filaments of light-absorbing dust and red-glowing nebulas. Additionally, both Jupiter (slightly left the galactic arch) and Saturn (slightly to the right) are visible.  The lights of small towns dot the unusual vertical horizon.  The rocky terrain around the lagoon appears to some more like the surface of Mars than our Earth.","hdurl":"https://apod.nasa.gov/apod/image/2004/EyeOnMW_Claro_1380.jpg","media_type":"image","service_version":"v1","title":"Eye on the Milky Way","url":"https://apod.nasa.gov/apod/image/2004/EyeOnMW_Claro_960.jpg"}');
            response.setStatusCode(200);
        } else if (endpoint == 'https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&hd=true&date=2000-1-1') {
            response.setBody('{"date":"2000-01-01","explanation":"Welcome to the millennial year at the threshold of millennium three.  During millennium two, humanity continually redefined its concept of \\"Universe\\": first as spheres centered on the Earth, in mid-millennium as the Solar System, a few centuries ago as the Galaxy, and within the last century as the matter emanating from the Big Bang.  During millennium three humanity may hope to discover alien life, to understand the geometry and composition of our present concept of Universe, and even to travel through this Universe.  Whatever our accomplishments, humanity will surely find adventure and discovery in the space above and beyond, and possibly define the surrounding Universe in ways and colors we cannot yet imagine by the threshold of millennium four.","hdurl":"https://apod.nasa.gov/apod/image/0001/flammarion_halfcolor.gif","media_type":"image","service_version":"v1","title":"The Millennium that Defines Universe","url":"https://apod.nasa.gov/apod/image/0001/flammarion_halfcolor_big.gif"}');
            response.setStatusCode(200);
        } else if (endpoint == 'https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&hd=true&date='
        + Date.today().year() + '-' + Date.today().month() + '-' + (Date.today().day()-1)) {
            response.setBody('{"copyright":"Juan Filas","date":"2020-04-20","explanation":"To some, it looks like a giant chicken running across the sky. To others, it looks like a gaseous nebula where star formation takes place. Cataloged as IC 2944, the Running Chicken Nebula spans about 100 light years and lies about 6,000 light years away toward the constellation of the Centaur (Centaurus).  The featured image, shown in scientifically assigned colors, was captured recently in a 12-hour exposure. The star cluster Collinder 249 is visible embedded in the nebula\'s glowing gas.  Although difficult to discern here, several dark molecular clouds with distinct shapes can be found inside the nebula.","hdurl":"https://apod.nasa.gov/apod/image/2004/IC2944_Filas_3320.jpg","media_type":"image","service_version":"v1","title":"IC 2944: The Running Chicken Nebula","url":"https://apod.nasa.gov/apod/image/2004/IC2944_Filas_960.jpg"}');
            response.setStatusCode(200);
        } else {
            response.setStatusCode(404);
            response.setBody('No file found. Sorry about that.');
        }
        return response;
    }
}