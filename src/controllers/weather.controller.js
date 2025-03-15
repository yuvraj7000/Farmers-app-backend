import axios from "axios";


const todaysWeather = async(req, res) => {
    const { lat , lon} = req.body;
    
    const weather = await axios.get(`https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&appid=${process.env.WEATHER_API_KEY}`)
    console.log("weather : ", weather)


    console.log("lat : ", lat)
    console.log("lon : ", lon)
    res.status(200).json({ message: 'Weather data for today', weather: weather.data });
}

export { todaysWeather }