<not-the-weather>
  <!--html at top-->

  <div class = "container" id = "weather">
    <form name = "getTheWeatherForm">
      <input type = "text" placeholder = "city, country" name = "place" onchange = { getPlace }/>
    </form>
    <ul if = { madeUpWeatherArray.length > 0 }>
      <li each = "{ lie in madeUpWeatherArray }" name = "{ lie.weather }">{ lie.weather.toLowerCase() }, { lie.temp }<li>
    </ul>

  </div>

  <!--now for some JS-->

  <script>

    var where = '';
    var now = new Date();
    function madeUpWeather(){
      this.weather = '',
      this.temp = 0
    };
    madeUpWeatherArray = [];
    this.madeUpWeatherArray = madeUpWeatherArray;

    getPlace = function(place){
      var place = this.place.value.toString();
      var place = place.toLowerCase().replace("usa", "us").replace(" ", "");
      where = place;
      getWeather(where.toString())

    }

    getWeather = function(place){
      fetch("http://api.openweathermap.org/data/2.5/forecast?q=" + place +"&mode=json&units=imperial&APPID=5194556d508058f5c7a03fec4d5b05f0")
        .then(function(response){
          if (response.status !== 200){
            console.log("You broke something: " + response.status);
          } else {
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
      for(var i = 0; i < 3; i++){
        var object = parsedForecast.list[i];
        console.log("object is: ", object)
        falseWeather = new madeUpWeather();
        var temp = Math.floor(object.main.temp);
        var realWeather = object.weather[0].description;
        switch(realWeather) {
          case "clear sky":
            falseWeather.weather = 'Rain';
            falseWeather.temp = temp - 19;
            //[STRETCH-FEATURE]these temp values are arbitrary. When I have more time, I should write a function to calculate and randomize an optimum 'uncomfortable' temp.
            break;
          case "few clouds":
            falseWeather.weather = 'Overcast';
            falseWeather.temp = temp - 16;
            break;
          case "light rain":
            falseWeather.weather = 'Thunderstorms';
            falseWeather.temp = temp - 10;
            break;
          case "scattered clouds":
            falseWeather.weather = 'Severe Weather Alert';
            falseWeather.temp = temp - 22;
            break;
          case "overcast clouds":
            falseWeather.weather = 'Clear Sky';
            falseWeather.temp = temp + 16;
            break;
          case "heavy intensity rain":
            falseWeather.weather = 'Sunny';
            falseWeather.temp = temp + 22;
            break;
          case "moderate rain":
            falseWeather.weather = 'Few Clouds';
            falseWeather.temp = temp + 14;
            break;
          case "broken clouds":
            falseWeather.weather = 'Scattered Showers';
            falseWeather.temp = temp + 11;
            break;
      }
      console.log(falseWeather);
      madeUpWeatherArray.push(falseWeather);
      console.log(this.madeUpWeatherArray);
      if (this.madeUpWeatherArray.length > 3){
        this.madeUpWeatherArray.shift();
      }
    }
    update();
    bgImg('weather', this.madeUpWeatherArray[0].weather);
  }

  update = function(){
    riot.update();
  }

  bgImg = function (id, loc) {
    /*id is the element id of the background that needs to change
    loc is the url of the actual img*/
    loc = '/assets/' + loc.replace(/\s/g, '').toLowerCase() + '.jpg';
    console.log("loc is now: " + loc);
   return document.getElementById(id).style.backgroundImage = "url(" + loc +")";
  }

  updateStyles = function(weather){
    weather = this.madeUpWeatherArray[0].weather;
  }

  </script>
  
  <!--lets make this pretty -->
  <style>
    .container {
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      border-radius: 25px
    }
    
    input {
      width: 100%;
      border-radius: 4px;
      margin-top: 10%;
    }
    
    ul {
      padding: 0;
    }
    
    ul > li {
      list-style: none;
      color: white;
      text-border: black; 
      font-family: sans-serif;
      text-align: center;
    }
      
  </style>

</not-the-weather>
