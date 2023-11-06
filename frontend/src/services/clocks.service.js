import Axios from "@/services/api.service";

const clocks_url = "/clocks";
const check_clocks_url = "check_clock";

const get_clock_by_user_id = async (user_id) => {
    try {
        const response = await Axios.get(`${clocks_url}/${user_id}`);
        console.log("clocks", response.data.data);
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

const create_clocking_time = async (clocking_time, user_id, status) => {    
    try {
        const response = await Axios.post(
            `${clocks_url}/${user_id}`,
            {
               clock: { 
                    time: clocking_time,
                    status: status,
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

const update_clock = async (id, time, status) => {
    try {
        const response = await Axios.put(
            `${clocks_url}/${id}`,
            {
                clock: {
                    time: time,
                    status: status
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

const check_clock = async (id, isActive, time) => {
    try {
        const response = await Axios.post(
            `${clocks_url}/${check_clocks_url}/${id}`,
            {
                clock: {
                    time: time,
                    status: isActive
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

export const clocks_service = {    
    get_clock_by_user_id,
    create_clocking_time,
    update_clock,
    check_clock
}

