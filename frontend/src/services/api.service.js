import axios from "axios";

const Axios = axios.create({
    baseURL: "localhost:4000/api",
})

export default Axios;