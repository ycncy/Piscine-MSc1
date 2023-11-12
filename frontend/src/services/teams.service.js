import Axios from "@/services/api.service";

const teams_url = "/teams";

const get_all_teams = async () => {
    try {
        const response = await Axios.get(`${teams_url}`);
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

const get_team_by_id = async (teamID) => {
    try {
        const response = await Axios.get(`${teams_url}/${teamID}`);
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

const create_team = async (team_name) => {
    try {
        const response = await Axios.post(`${teams_url}`, {
            team: {
                name: team_name
            }
        });
        return {
            status_code: response.status,
            data: response.data
        }
    } catch (error) {
        console.log(team_name)
        return {
            status_code: error.response.status,
            error: error.message
        }
    }
}

const delete_team = async (teamID) => {
    try {
        const response = await Axios.delete(`${teams_url}/${teamID}`);
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

export const teams_service = {
    get_all_teams,
    get_team_by_id,
    create_team,
    delete_team
}
