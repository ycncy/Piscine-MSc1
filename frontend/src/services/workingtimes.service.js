import Axios from "@/services/api.service";

const workingtimes_url = "/workingtimes";

const get_working_times_by_id = async (user_id) => {
    try {
        const response = await Axios.get(`${workingtimes_url}/${user_id}`);
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

const get_all_working_times = async () => {
    try {
        const response = await Axios.get(`${workingtimes_url}/`);
        return {
            status_code: response,
            data: response.data
        }
    } catch (error) {
        return {
            status_code: error.response.status,
            error: error.message
        }
    }
}

const update_working_time = async (working_time_id, start_time, end_time, status) => {
    try {
        const response = await Axios.put(
            `${workingtimes_url}/${working_time_id}`,
            {
                working_time: {
                    start_time: start_time,
                    end_time: end_time,
                    status: status
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

const delete_working_time = async (working_time_id) => {
    try {
        const response = await Axios.delete(
            `${workingtimes_url}/${working_time_id}`,
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

const create_working_time = async (user_id, start_time, end_time, status) => {
    try {
        const response = await Axios.post(
            `${workingtimes_url}/${user_id}`,
            {
                working_time: {
                    start_time: start_time,
                    end_time: end_time,
                    status: status
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


export const working_time_service = {
    get_working_times_by_id,
    get_all_working_times,
    update_working_time,
    delete_working_time,
    create_working_time
}

