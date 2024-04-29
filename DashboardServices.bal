import ballerina/http;



@http:ServiceConfig {cors: {allowOrigins: ["http://localhost:4200","http://10.175.1.71:4200","https://d7eaf07c-fb05-4851-88da-2e5dfd0cd730-dev.e1-us-cdp-2.choreoapis.dev/bigbillioncars/ballerinaservices/dash-ecb/v1.0","https://c463bb48-bb66-4f3e-a60b-afc6455e9a25-prod.e1-us-east-azure.choreoapis.dev/choreo-project/bbcballerina/dash-ecb/v1.0"], 
allowCredentials: false, 
allowHeaders: ["Content-Type","API-Key","Authorization"],
exposeHeaders: ["*"], 
maxAge: 84900}}


service /dash on httpl{

    isolated resource function get getweatherinfo(decimal lati,decimal longi) returns json|error? {       
    http:Client weatherClient = check new ("https://api.weatherapi.com");

   
    http:Response response = check weatherClient->get("/v1/current.json?q="+lati.toString()+","+longi.toString()+"&key=933b063c2e53408290c63421241503");
    return response.getJsonPayload();
    }


 
   

}
