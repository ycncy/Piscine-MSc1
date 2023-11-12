import Axios from "@/services/api.service";
const auth_url = "/authentication";

const login = async (email, password) => {
    try {
        const response = await Axios.post(
            `${auth_url}/login`,
            {
                "user": {
                    "email": email,
                    "password": password
                }
            },
        );

        set_user(response.data.user);
        set_token(response.data.csrf_token);

        return {
            status_code: response.status,
            data: response.data.data
        }
    } catch (error) {
        return {
            status_code: error.response.status,
            error: error.response.data.reason
        }
    }
}

const logout = async () => {
    try {
        const response = await Axios.post(
            `${auth_url}/logout`,
        );

        return {
            status_code: response.status,
            data: response.data.data
        }
    } catch (error) {
        return {
            status_code: error.response.status,
            error: error.response.data.reason
        }
    }
}


const is_logged = async () => {
    try {
        const response = await Axios.get(`${auth_url}/check-auth`);

        if (response.status === 200) {
            set_user({
                id: response.data.payload.user_id,
                team_id: response.data.payload.team_id,
                role: response.data.payload.role,
            });
            set_token(response.data.payload.csrf_token);

            return true;
        }

        return false;
    } catch (error) {
        return false;
    }
}
const get_user = () => {
    return sessionStorage.getItem("user");
}
const set_user = (user) => {
    sessionStorage.setItem("user", JSON.stringify(user));
}
const get_token = () => {
    return sessionStorage.getItem("token")
}
const set_token = (token) => {
    sessionStorage.setItem("token", token)
}
const delete_user = () => {
    sessionStorage.removeItem("user");
}
const delete_token = () => {
    sessionStorage.removeItem("token")
}
export const authentication_service = {
    login,
    logout,
    is_logged,
    get_user,
    set_user,
    delete_user,
    delete_token,
    set_token,
    get_token
}