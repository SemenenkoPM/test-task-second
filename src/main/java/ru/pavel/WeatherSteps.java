package ru.pavel;

import io.cucumber.java.en.When;
import io.restassured.RestAssured;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;

import java.util.Map;

import static org.junit.jupiter.api.Assertions.assertAll;
import static org.junit.jupiter.api.Assertions.assertEquals;

public class WeatherSteps {
    private final static String KEY = "5e4ffabe5edc1e85b8fd0d7d5cdc891e";
    private final static String URL = "http://api.weatherstack.com/";
    private Response response;

    @When("get {string} weather")
    public void getWeather(String city) {
        RestAssured.baseURI = URL;
        RequestSpecification httpRequest = RestAssured.given();
        Response response = httpRequest.get("/current?access_key=" + KEY + "&query=" + city);
        this.response = response;
    }

    @When("check request parameters {string} {string} {string} {string}")
    public void checkWeatherRequest(String type, String query, String language, String unit) {
        JsonPath jsonPath = response.jsonPath();
        Map<String, String> mapParams = jsonPath.getMap("request");
        assertAll(
                () -> assertEquals(type, mapParams.get("type")),
                () -> assertEquals(query, mapParams.get("query")),
                () -> assertEquals(language, mapParams.get("language")),
                () -> assertEquals(unit, mapParams.get("unit")));
    }

    @When("check location parameters {string} {string} {string} {string} {string} {string} {string}")
    public void checkWeatherLocation(String name, String country, String region, String lat, String lon, String timezone_id, String utc_offset) {
        JsonPath jsonPath = response.jsonPath();
        Map<String, String> mapParams = jsonPath.getMap("location");
        assertAll(
                () -> assertEquals(name, mapParams.get("name")),
                () -> assertEquals(country, mapParams.get("country")),
                () -> assertEquals(region, mapParams.get("region")),
                () -> assertEquals(lat, mapParams.get("lat")),
                () -> assertEquals(lon, mapParams.get("lon")),
                () -> assertEquals(timezone_id, mapParams.get("timezone_id")),
                () -> assertEquals(utc_offset, mapParams.get("utc_offset")));
    }
}
