package helpers;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;

import org.bson.Document;

import net.minidev.json.JSONObject;
import net.minidev.json.parser.JSONParser;

public class DbHandler {

    private static String connectionUrl = "mongodb+srv://mern_user:BJRQ3jKQlehAnlxR@cluster0.h7wuz.mongodb.net/";

    public static JSONObject getUsers(String user) {

        try {
            MongoClient client = MongoClients.create(connectionUrl);
            MongoDatabase database = client.getDatabase("mern_calendar_bdd");

            MongoCollection<Document> users = database.getCollection("usuarios");
            Document firstUser = users.find().first();

            System.out.print("users|||||||||||||||||||||: " + firstUser.toJson());
            JSONParser parser = new JSONParser();
            JSONObject json = (JSONObject) parser.parse(firstUser.toJson());

            return json;

        } catch (Exception e) {
            e.printStackTrace();
            return new JSONObject();
        }
    }

}
