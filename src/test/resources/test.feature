Feature: City weather params is correct

  Scenario Outline: Get <city> request params and they are correct
    When get <city> weather
    Then check request parameters <type> <query> <language> <unit>

    Examples:
      | city               | type   | query                                | language | unit |
      | "New York"         | "City" | "New York, United States of America" | "en"     | "m"  |
      | "Moscow"           | "City" | "Moscow, Russia"                     | "en"     | "m"  |
      | "Sankt Petersburg" | "City" | "Sankt Petersburg, Russia"           | "en"     | "m"  |
      | "Melbourne"        | "City" | "Melbourne, Australia"               | "en"     | "m"  |

  Scenario Outline: Get <city> request location parameters and they are correct
    When get <city> weather
    Then check location parameters <name> <country> <region> <lat> <lon> <timezone_id> <utc_offset>

    Examples:
      | city               | name               | country                    | region                  | lat       | lon       | timezone_id           | utc_offset |
      | "New York"         | "New York"         | "United States of America" | "New York"              | "40.714"  | "-74.006" | "America/New_York"    | "-4.0"     |
      | "Moscow"           | "Moscow"           | "Russia"                   | "Moscow City"           | "55.752"  | "37.616"  | "Europe/Moscow"       | "3.0"      |
      | "Sankt Petersburg" | "Sankt Petersburg" | "Russia"                   | "Saint Petersburg City" | "59.894"  | "30.264"  | "Europe/Moscow"       | "3.0"      |
      | "Melbourne"        | "Melbourne"        | "Australia"                | "Victoria"              | "-37.817" | "144.967" | "Australia/Melbourne" | "10.0"     |

    Scenario Outline: Get <city> request params negative test
      When get <city> weather
      Then check request parameters <type> <query> <language> <unit>
      Examples:
        | city               | type   | query                                | language | unit |
        | "New York"         | "Cit" | "New York, United States of America" | "en"     | "m"  |
        | "Mosw"           | "City" | "Moscow, Russia"                     | "en"     | "m"  |
        | "Sankt Petersburg" | "City" | "Sankt Petersburg, Russia"           | "en"     | "m"  |
        | "Melbourne"        | "City" | "Melbourne, Australia"               | "en"     | "m"  |