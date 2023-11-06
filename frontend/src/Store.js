import {createStore} from "vuex";

const Store = createStore({
    state: {
        user: null,
        token: null,
    },
    mutations: {
        setUser(state, user) {
            state.user = user;
        },
        setToken(state, token) {
            state.token = token;
        },
    },
    actions: {},
    getters: {
        getUser: (state) => state.user,
        getToken: (state) => state.token,
    },
});

export default Store;