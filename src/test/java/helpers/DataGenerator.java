package helpers;

import com.github.javafaker.Faker;

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

}