
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
    is_logged,
    get_user,
    set_user,
    delete_user
}