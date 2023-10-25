import Axios from "@/services/api.service";

const clocks_url = "/clocks";

const get_clock_by_user_id = async (user_id) => {
    try {
        const response = await Axios.get(`${clocks_url}/${user_id}`);
        return response.data;
    } catch (error) {
        return {
            status_code: error.response.status,
            error: error.message
        }
    }
}

const create_clocking_time = async (clocking_time, user_id) => {    
    try {
        const response = await Axios.post(
            `${clocks_url}/${user_id}`,
            {
               clock: { 
                    time: clocking_time,
               }
            }
        );
        return response.data;
    } catch (error) {
        return {
            status_code: error.response.status,
            error: error.message
        }
    }
}

export {    
    get_clock_by_user_id,
    create_clocking_time
}

