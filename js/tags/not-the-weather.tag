<not-the-weather>
  <!--html at top-->

  <div class = "container">
    <form name = "getTheWeatherForm">
      <input type = "text" placeholder = "city, country" name = "place" onchange = { getPlace }/>
    </form>
  </div>

  <!--now for some JS-->

  <script>
    var where = '';

    getPlace = function(place){
      console.log("place is: " + place);
      place = this.place.value.toString();
      console.log("Now place is: " + place)
      place = place.toLowerCase().replace("usa", "us").replace(" ", "");
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
              dataString = JSON.stringify(data);
              console.log("parsed data is: " + dataString);
              })
            //makeupWeather(response.json)
          }
        })
    }
  </script>

</not-the-weather>
