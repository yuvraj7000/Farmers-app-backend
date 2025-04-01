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

export { todaysWeather }