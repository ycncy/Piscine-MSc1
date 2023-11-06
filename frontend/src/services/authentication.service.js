import Axios from "@/services/api.service";
import store from "@/store";
const auth_url = "/authentication";

const login = async (email, password) => {
    try {
        const response = await Axios.post(
            `${auth_url}/login`,
            {
                user: {
                    email: email,
                    password: password
                }
            },
        );

        store.commit('setUser', response.data.user);
        store.commit('setToken', response.data.csrf_token);

        return {
            status_code: response.status,
            data: response.data.data
        }
    } catch (error) {
        console.log(error)
        return {
            status_code: error.response.status,
            error: error.response.data.reason
        }
    }
}


const is_logged = () => {
    return !!localStorage.getItem("user");
}
const get_user = () => {
    return localStorage.getItem("user");
}
const set_user = (user) => { 
    localStorage.setItem("user", JSON.stringify(user));
}
const delete_user = () => {
    localStorage.removeItem("user");
}   
export const authentication_service = {
    login,
    is_logged,
    get_user,
    set_user,
    delete_user
}