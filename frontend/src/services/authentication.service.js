
const is_logged = () => {
    return !!localStorage.getItem("user");
}
const get_user = () => {
    return localStorage.getItem("user");
}
const set_user = (user) => { 
    localStorage.setItem("user", user);
}
const delete_user = () => {
    localStorage.removeItem("user");
}   
export {
    is_logged,
    get_user,
    set_user,
    delete_user
}