import Axios from "@/services/api.service";

const users_url = "/users";

const get_user_by_id = async (user_id) => {
    try {
        const response = await Axios.get(
            `${users_url}/${user_id}`
        );
        return {
            status_code: response.status,
            data: response.data.data
        }
    } catch (error) {
        return {
            status_code: error.response.status,
            error: error.message
        }
    }
}

const get_user_by_credentials = async (username, email) => {
    try {
        const response = await Axios.get(
            `${users_url}`,
            {
                params: {
                    username: username,
                    email: email
                }
            }
        );
        return {
            status_code: response.status,
            data: response.data.data
        }
    } catch (error) {
        return {
            status_code: error.response.status,
            error: error.message
        }
    }
}

const create_user = async (username, email, role) => {
    try {
        const response = await Axios.post(
            `${users_url}`,
            {
                user: {
                    username: username,
                    email: email,
                    role: role
                }
            }
        );
        return {
            status_code: response.status,
            data: response.data.data
        }
    } catch (error) {
        return {
            status_code: error.response.status,
            error: error.message
        }
    }
}

const update_user = async (username, email, role) => {
    try {
        const response = await Axios.put(
            `${users_url}`,
            {
                user: {
                    username: username,
                    email: email,
                    role: role
                }
            }
        );
        return {
            status_code: response.status,
            data: response.data.data
        }
    } catch (error) {
        return {
            status_code: error.response.status,
            error: error.message
        }
    }
}

const delete_user = async (user_id) => {
    try {
        const response = await Axios.delete(`${users_url}/${user_id}`);
        return {
            status_code: response.status,
            data: response.data.data
        }
    } catch (error) {
        return {
            status_code: error.response.status,
            error: error.message
        }
    }
}

export const users_service = {
    get_user_by_id,
    get_user_by_credentials,
    create_user,
    update_user,
    delete_user
}