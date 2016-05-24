<not-the-weather>
  <!--html at top-->

  <div class = "container">
    <form name = "getTheWeatherForm">
      <input type = "text" placeholder = "city, country" name = "place" onchange = { getPlace }>
    </form>
  </div>

  <!--now for some JS-->

  <script>

    var where = '';
    var now = new Date();
    function madeUpWeather(){
      this.weather = '',
      this.temp = 0,
      this.wind ='',
      this.precip = ''
    };
    var madeUpWeatherArray = [];

    getPlace = function(place){
      console.log("place is: " + place);
      var place = this.place.value.toString();
      console.log("Now place is: " + place)
      var place = place.toLowerCase().replace("usa", "us").replace(" ", "");
      where = place;
      console.log("where is: " + where)
      getWeather(where.toString())

    }

    getWeather = function(place){
      console.log("getWeather entered with: " + place)
      fetch("http://api.openweathermap.org/data/2.5/forecast?q=" + place +"&mode=json&units=imperial&APPID=5194556d508058f5c7a03fec4d5b05f0")
        .then(function(response){
          if (response.status !== 200){
            console.log("You broke something: " + response.status);
          } else {
            console.log("API is okaly-dokaly. Parsing promise reponse now!")
            response.json().then(function(data){
              var dataString = JSON.stringify(data);
              //console.log("parsed data is: " + dataString);
              makeUpWeather(dataString);
              })
          }
        })
    }

    makeUpWeather = function(forecast){
      //console.log("forecast being passed to makeUpWeather is: " + forecast);
      var falseWeather = null;
      var parsedForecast = JSON.parse(forecast);
      console.log("parsedForecast.list is:");
      console.log(parsedForecast.list);
      parsedForecast.list.forEach(function(object){
        falseWeather = new madeUpWeather();
        switch(object.weather.description){
          case "clear sky":
            falseWeather.weather = 'Rain'
            break;
          case "few clouds":
            falseWeather.weather = 'Severe Storms'
            break;
          case "light rain":
            falseWeather.weather = 'Flurries'
            break;
          case "scattered clouds":
            falseWeather.weather = 'Overcast'
            break;
          case "overcast clouds":
            falseWeather.weather = 'Clear Sky'
            break;
          console.log(falseWeather);
        }
    })
}
  </script>

</not-the-weather>
