import Store from "@/Store";

const is_logged = () => {
    return !!Store.state.user;
}
const get_user = () => {
    return Store.state.user;
}
const set_user = (user) => { 
    Store.commit("set_user", {user: user});
}
const delete_user = () => {
    Store.commit("delete_user");
}   
export {
    is_logged,
    get_user,
    set_user,
    delete_user
}