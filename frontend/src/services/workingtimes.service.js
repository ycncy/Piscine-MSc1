import Axios from "@/services/api.service";

const workingtimes_url = "/workingtimes";

const get_working_times_by_id = async (user_id) => {
    try {
        const response = await Axios.get(`${workingtimes_url}/${user_id}`);
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

const get_all_working_times = async () => {
    try {
        const response = await Axios.get(`${workingtimes_url}/`);
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

export {    
    get_working_times_by_id,
    get_all_working_times
}

