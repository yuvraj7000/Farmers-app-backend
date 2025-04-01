import axios from "axios";


const todaysWeather = async (req, res) => {
    const { lat, lon } = req.query;
    console.log(`https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&appid=${process.env.WEATHER_API_KEY}`);
    
    try {
        const weather = await axios.get(`https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&appid=${process.env.WEATHER_API_KEY}`);
        console.log("weather : ", weather.data);

        console.log("lat : ", lat);
        console.log("lon : ", lon);
        res.status(200).json({ message: 'Weather data for today', weather: weather.data });
    } catch (error) {
        console.error("Error fetching weather data: ", error.message);
        res.status(500).json({ message: 'Failed to fetch weather data', error: error.message });
    }
};



const getWeatherData = async (req, res) => {
    try {
      const { lat, lon } = req.query; // Get latitude and longitude from query parameters

      if (!lat || !lon) {
        return res.status(400).json({ error: 'Latitude and Longitude are required' });
      }
  
      // Fetch hourly and daily weather data
      const [hourlyRes, dailyRes] = await Promise.all([
        axios.get(`https://pro.openweathermap.org/data/2.5/forecast/hourly?lat=${lat}&lon=${lon}&appid=${process.env.WEATHER_API_KEY}`),
        axios.get(`https://api.openweathermap.org/data/2.5/forecast/daily?lat=${lat}&lon=${lon}&cnt=16&appid=${process.env.WEATHER_API_KEY}`)
      ]);
  
      // Send the combined response back to the client
      res.status(200).json({
        hourlyRes: hourlyRes.data,
        dailyRes: dailyRes.data
      });
    } catch (error) {
      console.error('Error fetching weather data:', error.message);
      res.status(500).json({ error: 'Failed to fetch weather data' });
    }
  };


export { todaysWeather, getWeatherData };