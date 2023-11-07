import axios from "axios";

const Axios = axios.create({
    baseURL: "http://34.155.108.18:4000/api",
    withCredentials: true
})

export default Axios;