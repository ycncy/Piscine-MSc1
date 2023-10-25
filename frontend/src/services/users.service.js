import Axios from "@/services/api.service";
import {HttpStatusCode} from "axios";

const users_url = "/users";

const get_user_by_id = async (user_id) => {
    try {
        const response = await Axios.get(`${users_url}/${user_id}/azeaze`).catch(
            () => {
                throw new Error("Not found")
            }
        )
        return response.data.data;
    } catch (error) {
        return {
            error: error
        }
    }
}

const get_user_by_credentials = async (username, email) => {
    await Axios.get(
        `${users_url}`,
        {
            params: {
                username: username,
                email: email
            }
        }
    ).then(response => {
        return response.data;
    }).catch(error => {
        console.log(`Error trying to fetch user by credentials : ${error}`)
        throw error;
    });
}

export const users_service = {
    get_user_by_id, get_user_by_credentials
}