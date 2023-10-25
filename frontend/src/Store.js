import {createStore} from "vuex";

const Store = createStore({
    state() {
        return {
            user : undefined
        }
    },
    mutations: {
        set_user(state, user) {
            state.user = user;
        },
        delete_user(state) {
            state.user = undefined;
        }
    }
});
export default Store;