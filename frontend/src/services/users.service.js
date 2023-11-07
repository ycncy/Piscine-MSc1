import Axios from "@/services/api.service";

const users_url = "/users";

const get_all_users = async () => {
    try {
        const response = await Axios.get(
            `${users_url}/all`
        );
        return {
            status_code: response.status,
            data: response.data
        }
    } catch (error) {
        return {
            status_code: error.response.status,
            error: error.message
        }
    }
}

const get_user_by_id = async (user_id) => {
    try {
        const response = await Axios.get(
            `${users_url}/${user_id}`
        );
        return {
            status_code: response.status,
            data: response.data
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
            data: response.data
        }
    } catch (error) {
        return {
            status_code: error.response.status,
            error: error.message
        }
    }
}

const create_user = async (username, email, password, role) => {
    try {
        const response = await Axios.post(
            `${users_url}`,
            {
                user: {
                    username: username,
                    email: email,
                    password: password,
                    role: role
                }
            }
        );
        return {
            status_code: response.status,
            data: response.data
        }
    } catch (error) {
        return {
            status_code: error.response.status,
            error: error.message
        }
    }
}

const update_user = async (user_id, username, email, role) => {
    try {
        const response = await Axios.put(
            `${users_url}/${user_id}`,
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
            data: response.data
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
            data: response.data
        }
    } catch (error) {
        return {
            status_code: error.response.status,
            error: error.message
        }
    }
}

export const users_service = {
    get_all_users,
    get_user_by_id,
    get_user_by_credentials,
    create_user,
    update_user,
    delete_user
}