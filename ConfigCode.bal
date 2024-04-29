import ballerina/http;
import big_billion_cars.configuration;



@http:ServiceConfig {
    cors: {
        allowOrigins: ["http://localhost:4200","http://10.175.1.71:4200","https://d7eaf07c-fb05-4851-88da-2e5dfd0cd730-dev.e1-us-cdp-2.choreoapis.dev/bigbillioncars/ballerinaservices/configcodes-631/v1.0","https://c463bb48-bb66-4f3e-a60b-afc6455e9a25-prod.e1-us-east-azure.choreoapis.dev/choreo-project/bbcballerina/configcodes-631/v1.0"],
        allowCredentials: false,
        allowHeaders: ["Content-Type","userId","API-Key","Authorization"],
        exposeHeaders: ["*"],
        maxAge: 84900
    }
}

service /configcodes on httpl {

    isolated resource function post addConfig(configuration:ConfigCode config)returns int|error? {
        return configuration:addConfigCode(config);
    }

     isolated resource function post dropDowns()returns configuration:DropDown|error {
        configuration:ConfigCode[]|error? extrClrList = configuration:getExtrClrList();
         configuration:ConfigCode[]|error? intrClrList = configuration:getIntrClrList();
         configuration:DropDown  drop = {vehicleIntrColor : check intrClrList ?: [],vehicleExtrColor: check extrClrList ?: []};
         return drop;
     }

}
