import ballerina/http;
import big_billion_cars.user;
import big_billion_cars.model;
import big_billion_cars.amazonbucket;




type fileName record {
    string fileName;
    int code;
    boolean status;
};


@http:ServiceConfig {cors: {allowOrigins: ["http://localhost:4200","http://10.175.1.71:4200","https://d7eaf07c-fb05-4851-88da-2e5dfd0cd730-dev.e1-us-cdp-2.choreoapis.dev/bigbillioncars/ballerinaservices/user-27c/v1.0"], 
allowCredentials: false, 
allowHeaders: ["Content-Type","userId","API-Key","Authorization"],
exposeHeaders: ["*"], 
maxAge: 84900}}




service /user on httpl{

     isolated resource function get fetchUser(string id) returns user:Users|error? {
        return user:getUsers(id);
    }


     isolated resource function get userCount(string id) returns user:response|error {
        return user:userPresent(id);  
    }


     isolated resource function post addUser(user:Users user)returns string|error? {
        return user:addUser(user);
    }

    isolated resource function get checkUser(string username, string password) returns string|user:Users|error {
        return user:findUser(username, password);
    }

    isolated resource function post editUser(string id, user:Users user) returns user:response|error {
        return user:editUser(id, user);
    }
   resource function post uploadProPic(http:Request request) returns model:Response|error {

        
         model:Response|error uploadImage = amazonbucket:uploadImage(request);
        return uploadImage;

    }

     isolated resource function get downloadImage(string imageName) returns byte[]|error? {     
        return amazonbucket:downloadImage(imageName);

    }
    
}


