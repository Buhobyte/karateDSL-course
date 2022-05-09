package helpers;

import com.github.javafaker.Faker;

import net.minidev.json.JSONObject;

public class DataGenerator {

    public static String getRandomUserName() {

        Faker faker = new Faker();
        String userName = faker.name().firstName();
        return userName;
    }

    public static String getRandomEmail() {

        Faker faker = new Faker();
        String email = faker.name().firstName() + "@" +
                faker.internet().domainName();
        return email;
    }

    public String getRandomEmail2() {

        Faker faker = new Faker();
        String email = faker.name().firstName() + "@" +
                faker.internet().domainName();
        return email;
    }

    public static JSONObject getRandomArticleValues() {
        Faker faker = new Faker();
        String title = faker.gameOfThrones().character();
        String description = faker.gameOfThrones().city();
        String body = faker.gameOfThrones().quote();
        JSONObject json = new JSONObject();
        json.put("title", title);
        json.put("description", description);
        json.put("body", body);
        return json;
    }

}