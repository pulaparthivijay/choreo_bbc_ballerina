import big_billion_cars.searchFactory;

import big_billion_cars.model;
import ballerina/http;

@http:ServiceConfig {
    cors: {
        allowOrigins: ["http://localhost:4200","http://10.175.1.71:4200","https://d7eaf07c-fb05-4851-88da-2e5dfd0cd730-dev.e1-us-cdp-2.choreoapis.dev/bigbillioncars/ballerinaservices/searchfactory-008/v1.0","https://c463bb48-bb66-4f3e-a60b-afc6455e9a25-prod.e1-us-east-azure.choreoapis.dev/choreo-project/bbcballerina/searchfactory-008/v1.0"],
        allowCredentials: false,
        allowHeaders: ["Content-Type","userId","buyerUser_id","API-Key","Authorization"],
        exposeHeaders: ["*"],
        maxAge: 84900
    }
}

service /searchFactory on httpl {
    isolated resource function post buyCar(int appr_id,@http:Header string userId) returns model:Response|error {
        string|error buyMsg = searchFactory:vehicleBuy(appr_id, userId);
        model:Response resp = {message:check buyMsg, code:200, status:true};
         return resp;
    }
    
}
