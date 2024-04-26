import big_billion_cars.model;

import ballerina/http;
import big_billion_cars.inventory;
import big_billion_cars.favoriteVehicle;
import big_billion_cars.amazonbucket;





listener http:Listener httpl = new (8080);



@http:ServiceConfig {cors: {allowOrigins: ["http://localhost:4200","http://10.175.1.71:4200","https://d7eaf07c-fb05-4851-88da-2e5dfd0cd730-dev.e1-us-cdp-2.choreoapis.dev/bigbillioncars/ballerinaservices/appraisal-a0e/v1.0"], 
allowCredentials: false,    
allowHeaders: ["Content-Type","userId","AppraisalId","id","API-Key","Authorization"],
exposeHeaders: ["*"], 
maxAge: 84900}}

service /appraisal on httpl {
    resource function post addAppraiseVehicle(@http:Header string userId,model:Appraisal appraisal)returns model:Response|error? {
        return model:addAppraisal(userId,appraisal);
    }

    isolated resource function post updateAppraiseVehicle(@http:Header int id,model:Appraisal appraisal)returns model:Response|error {
        return model:editAppraisal(id, appraisal);
    }

    isolated resource function post deleteAppraisal(int apprRef)returns model:Response|error? {
        return model:deleteAppraisal(apprRef);
    }

    isolated resource function get downloadImage(string pic1) returns byte[]|error? {        
        return amazonbucket:downloadImage(pic1);

    }



     isolated resource function post showToUi(@http:Header int AppraisalId) returns model:showToUIRes|error? {
         model:Appraisal|error showAppraisal = model:showAppraisal(AppraisalId);
         model:showToUIRes  showToUicrd = {apr : check showAppraisal,message : "showToUi working" ,code : 200, status: true};
         return showToUicrd;
    }



    resource function post uploadImage(http:Request request) returns model:Response|error {
       
        model:Response|error uploadImage = amazonbucket:uploadImage(request);
        return uploadImage;
    }






    isolated resource function post apprList(@http:Header string userId,int pageNo,int pageSize) returns model:ApprCardsRes|error {
         model:Appraisal[]|error apprList = model:getApprList(userId,pageNo,pageSize);
         int|error? totlRcd = model:getTotalRecords("created",false,userId);
         int pages = model:getPages(check totlRcd ?: 0);
         model:ApprCardsRes  apprCards = {cards : check apprList, code : 200, message : "Appraisal cards success", status :true,totalRecords:check totlRcd ?: 0,totalPages:pages};
         return apprCards;
  
    }


    isolated resource function get filterAppraisal(string userId,string? make,string? model,int? year,int pageNumber, int pageSize) returns model:Appraisal[]|error? {
        return model:filterAppr(userId,make ?: "",model ?: "",year ?: 0,pageNumber,pageSize);
    }

    

    isolated resource function post moveToInventory(int apprRef) returns model:Response|error {
            return inventory:moveToInv(apprRef);
    }

    isolated resource function post moveToWishList(@http:Header string userId,int apprRef) returns model:Response|error {
        string|error favVeh = favoriteVehicle:addFavVeh(userId,apprRef );
        model:Response resp = {message:check favVeh, code:200, status:true};
         return resp;
    }

    isolated resource function post getFavoriteCards(@http:Header string userId,int pageNumber,int pageSize) returns favoriteVehicle:FavCardsRes|error {
         favoriteVehicle:FavCardsDto[]|error favVehList = favoriteVehicle:getFavVehList(userId, pageNumber,pageSize);
         int|error? totlRcd = favoriteVehicle:getFavRecords("created",false,userId);
         int pages = model:getPages(check totlRcd ?: 0);
         favoriteVehicle:FavCardsRes  favCards = {cards : check favVehList, code : 200, message : "favorite cards success", status :true,totalRecords:check totlRcd ?: 0,totalPages:pages};
         return favCards;
    }

    isolated resource function post removeFavorite(int apprId,@http:Header string userId) returns model:Response|error {
         string|error removeFavVeh = favoriteVehicle:removeFavVeh(apprId, userId);
         model:Response resp = {message:check removeFavVeh, code:200, status:true};
         return resp;
    }

    isolated resource function post checkVehicleAvailable(@http:Header string userId,string vin) returns model:Response|error {
            return model:checkVinNumber(userId,vin);
    }

    
}

