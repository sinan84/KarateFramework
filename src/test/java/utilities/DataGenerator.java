package utilities;

import com.github.javafaker.Faker;
import com.github.javafaker.IdNumber;

import java.util.HashMap;
import java.util.Map;

public class DataGenerator {

    public static Map<String, Object> createUser() {

        Faker faker = new Faker();
        String name = faker.name().firstName();
        String lastName = faker.name().lastName();
        String gender = faker.demographic().sex();
        String email = faker.name().username() + "@gmail.com";
//        String email = faker.internet().emailAddress();
        long phone = Long.parseLong(faker.numerify("#####"));

        Map<String, Object> newUser = new HashMap<>();

        newUser.put("name", name);
        newUser.put("gender", gender);
        newUser.put("email", email);
        newUser.put("status", "Active");

        return newUser;


    }

    public static String createName() {

        Faker faker = new Faker();
        String name = faker.name().firstName();
        return name;

    }

}